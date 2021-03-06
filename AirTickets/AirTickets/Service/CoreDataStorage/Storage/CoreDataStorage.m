//
//  CoreDataStorage.m
//  AirTickets
//
//  Created by Alexey on 01.06.2021.
//

#import "CoreDataStorage.h"

@interface CoreDataStorage ()

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

@end


@implementation CoreDataStorage

+ (instancetype)sharedInstance {
    static CoreDataStorage *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [CoreDataStorage new];
        [instance setup];
    });
    return instance;
}

- (void)setup {
    NSURL *modelURL = [NSBundle.mainBundle URLForResource:@"Ticket" withExtension:@"momd"];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSURL *docsURL = [[NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"base.sqlite"];
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    NSPersistentStore* store = [self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    if (!store) {
        abort();
    }
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
}

- (void)save {
    NSError *error;
    [self.managedObjectContext save: &error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (FavouriteTicket *)favouriteFromTicket:(Ticket *)ticket {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavouriteTicket"];
    request.predicate = [NSPredicate predicateWithFormat:@"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND expires == %@ AND flightNumber == %ld", (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, ticket.departure, ticket.expires, (long)ticket.flightNumber.integerValue];
    return [[self.managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (BOOL)isFavourite:(Ticket *)ticket {
    return [self favouriteFromTicket:ticket] != nil;
}

- (void)addToFavourite:(Ticket *)ticket {
    FavouriteTicket *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavouriteTicket" inManagedObjectContext:self.managedObjectContext];
    favorite.price = ticket.price;
    favorite.airline = ticket.airline;
    favorite.departure = ticket.departure;
    favorite.expires = ticket.expires;
    favorite.flightNumber = ticket.flightNumber;
    favorite.returnDate = ticket.returnDate;
    favorite.from = ticket.from;
    favorite.to = ticket.to;
    favorite.created = [NSDate date];
      
    [self save];
}

- (void)removeFromFavourite:(Ticket *)ticket {
    FavouriteTicket *favorite = [self favouriteFromTicket:ticket];
    if (favorite) {
        [self.managedObjectContext deleteObject:favorite];
        [self save];
    }
}

- (NSArray *)favourites {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavouriteTicket"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]];
    return [self.managedObjectContext executeFetchRequest:request error:nil];
}

- (FavouriteMapPrice *)favouriteFromMapPrice:(SimpleMapPrice *)price {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavouriteMapPrice"];
    request.predicate = [NSPredicate predicateWithFormat:@"price == %@ AND destination == %@", price.price, price.destination];
    return [[self.managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (BOOL)isFavouriteMapPrice:(SimpleMapPrice *)ticket {
    return [self favouriteFromMapPrice:ticket] != nil;
}


- (void)addToFavouriteMapPrice:(SimpleMapPrice *)price {
    FavouriteMapPrice *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavouriteMapPrice" inManagedObjectContext:self.managedObjectContext];
    favorite.price = price.price;
    favorite.destination = price.destination;
    favorite.created = [NSDate new];
      
    [self save];
}

- (void)removeFromFavouriteMapPrice:(SimpleMapPrice *)price {
    FavouriteMapPrice *favorite = [self favouriteFromMapPrice:price];
    if (favorite) {
        [self.managedObjectContext deleteObject:favorite];
        [self save];
    }
}

- (NSArray *)favouritesMapPrice {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavouriteMapPrice"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]];
    return [self.managedObjectContext executeFetchRequest:request error:nil];
}


@end
