//
//  AppDelegate.m
//  AirTickets
//
//  Created by Alexey on 14.05.2021.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect frame = UIScreen.mainScreen.bounds;
    self.window = [[UIWindow alloc] initWithFrame: frame];
        
    MainViewController *vc = [MainViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];

    return YES;
}


@end
