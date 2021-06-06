//
//  AppDelegate.m
//  AirTickets
//
//  Created by Alexey on 14.05.2021.
//

#import "AppDelegate.h"
#import "MainMenuBuilder.h"
#import "TicketsBuilder.h"
#import "MapBuilder.h"
#import "Colors.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect frame = UIScreen.mainScreen.bounds;
    self.window = [[UIWindow alloc] initWithFrame: frame];
        
    MainMenuViewController *mainMenuVC = (MainMenuViewController *)[MainMenuBuilder build];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainMenuVC];
    navController.tabBarItem.title = @"Поиск";
    navController.tabBarItem.image = [UIImage systemImageNamed:@"magnifyingglass.circle.fill"];
    
    MapViewController *mapVC = (MapViewController *)[MapBuilder build];
    mapVC.tabBarItem.title = @"Карта цен";
    mapVC.tabBarItem.image = [UIImage systemImageNamed:@"map.fill"];
    
    UITabBarController *tabBarController = [UITabBarController new];
    tabBarController.tabBar.barTintColor = UIColorFromRGB(darkColor);
    tabBarController.tabBar.tintColor = UIColor.whiteColor;
    
    TicketsTableViewController *favoriteVC = (TicketsTableViewController *) [TicketsBuilder buildFavoutives];
    favoriteVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Избранное" image:[UIImage systemImageNamed:@"star"] selectedImage:[UIImage systemImageNamed:@"star.fill"]];
    UINavigationController *favouriteNavVC = [[UINavigationController alloc] initWithRootViewController:favoriteVC];
    
    NSMutableArray *tabItems = [[NSMutableArray alloc] initWithCapacity:3];
    [tabItems addObject:navController];
    [tabItems addObject:mapVC];
    [tabItems addObject:favouriteNavVC];
    
    tabBarController.viewControllers = tabItems;
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
