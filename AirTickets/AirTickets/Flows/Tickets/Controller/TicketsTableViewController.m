//
//  TicketsViewController.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "TicketsTableViewController.h"
#import "TicketTableViewCell.h"
#import "CoreDataStorage.h"
#import "NotificationCenter.h"

@interface TicketsTableViewController ()

@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *dateTextField;

@property BOOL isFavorites;
@property (strong, nonatomic) TicketTableViewCell *notificationCell;

@end

@implementation TicketsTableViewController

- (instancetype)initWithPresenter:(NSObject<TicketsViewOutput> *)presenter {
    self = [super init];
    if (self) {
        self.presenter = presenter;
        self.title = NSLocalizedString(@"ticketsTitle", "");
        [self setupDatePicker];
    }
    return self;
}

- (void)setupFavouriteTickets {
    self.title = NSLocalizedString(@"favBarTitle", "");
    
    self.isFavorites = YES;
    self.tickets = [NSArray new];
    [self configureSegmanetedControl];
}

- (void)configureSegmanetedControl {
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"tickets", ""), NSLocalizedString(@"map", "")]];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
}

- (void)setupDatePicker {
    self.datePicker = [UIDatePicker new];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    self.datePicker.minimumDate = [NSDate date];
    
    self.dateTextField = [UITextField new];
    self.dateTextField.hidden = YES;
    self.dateTextField.inputView = self.datePicker;
    
    UIToolbar *keyboardToolbar = [UIToolbar new];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidTap:)];
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonDidTap:)];
    keyboardToolbar.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    keyboardToolbar.items = @[cancelBarButton, flexBarButton, doneBarButton];
    
    self.dateTextField.inputAccessoryView = keyboardToolbar;
    [self.view addSubview:self.dateTextField];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketTableViewCell.reuseIdentifier];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    if (self.isFavorites) {
        [self valueChanged:self.segmentedControl];
    }
}

- (void)valueChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.tickets = [self.presenter getFavourites];
    } else {
        self.tickets = [self.presenter getFavouritesMapPrice];
    }
    [self.tableView reloadData];
}

- (void)doneButtonDidTap:(UIBarButtonItem *)sender {
    if (self.datePicker.date && self.notificationCell) {
        NSString *message = [NSString stringWithFormat:@"%@ - %@ %@ %@ %@.", self.notificationCell.ticket.from, self.notificationCell.ticket.to,
            NSLocalizedString(@"for", ""),
            self.notificationCell.ticket.price,
            NSLocalizedString(@"rubles", "")];
        NSURL *imageURL;

        Notification notification = NotificationMake(NSLocalizedString(@"ticketNotification", ""), message, self.datePicker.date, imageURL);
        [NotificationCenter.sharedInstance sendNotification:notification];

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"success", "") message:[NSString stringWithFormat:@"%@ - %@", NSLocalizedString(@"notificationWillBeSent", ""), _datePicker.date] preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"close", "") style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            [CoreDataStorage.sharedInstance addToFavourite:self.notificationCell.ticket];
            self.datePicker.date = [NSDate date];
            self.notificationCell = nil;
            [self.view endEditing:YES];
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)cancelButtonDidTap:(UIBarButtonItem *)sender {
    self.notificationCell = nil;
    [self.view endEditing:YES];
}

- (void)removeTicket:(Ticket *)ticket withIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *tempTickets = [[NSMutableArray alloc] initWithArray:self.tickets];
    [tempTickets removeObjectAtIndex:indexPath.row];
    self.tickets = tempTickets;
    
    if (self.tickets.count != 0) {
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        [self.tableView reloadData];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tickets.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isFavorites && self.segmentedControl.selectedSegmentIndex == 1) { return; }
    
    Ticket *ticket = self.tickets[indexPath.row];
    
    if (self.isFavorites) {
        UIAlertAction *removeAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"remove", "") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self removeTicket:ticket withIndexPath:indexPath];
            [CoreDataStorage.sharedInstance removeFromFavourite:ticket];
        }];
        
        [self.presenter viewDidTapCellWithActions:@[removeAction]];
        
        return;
    }
    
    UIAlertAction *favouriteAction;
    if ([CoreDataStorage.sharedInstance isFavourite:ticket]) {
        favouriteAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"removeFromFavourites", "") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [CoreDataStorage.sharedInstance removeFromFavourite:ticket];
        }];
    } else {
        favouriteAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"addToFavourites", "") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataStorage sharedInstance] addToFavourite:ticket];
        }];
    }
    
    UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"notify", "") style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.notificationCell = [tableView cellForRowAtIndexPath:indexPath];
        [self.dateTextField becomeFirstResponder];
    }];
    
    
    [self.presenter viewDidTapCellWithActions:@[favouriteAction, notificationAction]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketTableViewCell.reuseIdentifier forIndexPath:indexPath];
    if (self.isFavorites) {
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            cell.favouriteTicket = self.tickets[indexPath.row];
        } else {
            cell.favouriteMapPrice = self.tickets[indexPath.row];
        }
    } else {
        cell.ticket = self.tickets[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.transform = CGAffineTransformMakeTranslation(self.tableView.bounds.size.width, 0);
    cell.alpha = 0;
    
    [UIView animateWithDuration:0.95 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cell.transform = CGAffineTransformMakeTranslation(0, 0);
        cell.alpha = 1;
    } completion:nil];
}

@end
