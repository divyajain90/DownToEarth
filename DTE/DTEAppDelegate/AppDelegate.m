//
//  AppDelegate.m
//  DTE
//
//  Created by Divya Jain on 5/1/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftMenuViewController.h"
#import "SlideNavigationController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch
    
    [NSThread sleepForTimeInterval:3.0];
    [[APIManager sharedManager]getAllCategories];
    [[APIManager sharedManager] getAllStates];

    [UIApplication sharedApplication].statusBarHidden = YES;
    


    if (![[User sharedUser]isLoggedIn]) {
        // Login
            [self showLoginScreen:NO];

     }

    LeftMenuViewController *leftMenu = (LeftMenuViewController*)[GET_STORYBOARD
                                                                 instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
    
    
    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidClose object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Closed %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidOpen object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Opened %@", menu);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SlideNavigationControllerDidReveal object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSString *menu = note.userInfo[@"menu"];
        NSLog(@"Revealed %@", menu);
    }];
    

    
    return YES;
}

-(void)showLoginScreen:(BOOL)login
{
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:[GET_STORYBOARD instantiateViewControllerWithIdentifier:@"Login"]];
    [self.window makeKeyAndVisible];
[self.window.rootViewController presentViewController:navigation animated:YES completion:nil];
//    self.window.rootViewController = navigation;

}

-(void) logout
{
    [[User sharedUser] logout ];
        SlideNavigationController *nav = [[SlideNavigationController alloc] initWithRootViewController:[GET_STORYBOARD instantiateViewControllerWithIdentifier:@"HomeView1"]];
    [self.window setRootViewController:nav];

    [self showLoginScreen:YES];


}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
