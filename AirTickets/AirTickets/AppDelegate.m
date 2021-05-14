//
//  AppDelegate.m
//  AirTickets
//
//  Created by Alexey on 14.05.2021.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect windowFrame = UIScreen.mainScreen.bounds;
    self.window = [[UIWindow alloc] initWithFrame: windowFrame];
        
    ViewController *vc = [ViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];

    return YES;
}


@end
