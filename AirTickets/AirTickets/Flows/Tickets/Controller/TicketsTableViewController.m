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
        self.title = @"Билеты";
        [self setupDatePicker];
    }
    return self;
}

- (void)setupFavouriteTickets {
    self.title = @"Избранное";
    
    self.isFavorites = YES;
    self.tickets = [NSArray new];
    [self configureSegmanetedControl];
}

- (void)configureSegmanetedControl {
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Билеты", @"Карта"]];
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
        [self.tableView reloadData];
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
        NSString *message = [NSString stringWithFormat:@"%@ - %@ за %@ руб.", self.notificationCell.ticket.from, self.notificationCell.ticket.to, self.notificationCell.ticket.price];
        NSURL *imageURL;

        Notification notification = NotificationMake(@"Напоминание о билете", message, self.datePicker.date, imageURL);
        [NotificationCenter.sharedInstance sendNotification:notification];

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Успешно" message:[NSString stringWithFormat:@"Уведомление будет отправлено - %@", _datePicker.date] preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    self.datePicker.date = [NSDate date];
    self.notificationCell = nil;
    [self.view endEditing:YES];
}

- (void)cancelButtonDidTap:(UIBarButtonItem *)sender {
    self.notificationCell = nil;
    [self.view endEditing:YES];
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
    
    if (self.isFavorites) { return; }
    
    Ticket *ticket = self.tickets[indexPath.row];
    UIAlertAction *favouriteAction;
    if ([CoreDataStorage.sharedInstance isFavourite:ticket]) {
        favouriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [CoreDataStorage.sharedInstance removeFromFavourite:ticket];
        }];
    } else {
        favouriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataStorage sharedInstance] addToFavourite:ticket];
        }];
    }
    
    UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:@"Напомнить" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
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

@end
