//
//  AppDelegate.m
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "AppDelegate.h"
#import "Util.h"

#import "EfilingTaxPaymentViewController.h"
#define COLOR(x) x/255.0

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.efilingCheckNewUserViewController = [[EfilingCheckNewUserViewController alloc] initWithNibName:@"EfilingCheckNewUserViewController" bundle:nil];
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:self.efilingCheckNewUserViewController];
    
//    EfilingTaxPaymentViewController *efil = [[EfilingTaxPaymentViewController alloc] initWithNibName:@"EfilingTaxPaymentViewController" bundle:nil];
//    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:efil];
//    nav.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_grey.png"]];
    
    //-- set navigation bar
//    UIImage *navBackgroundImage = [UIImage imageNamed:@"bg_green"];
//    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
//    UIImage *img = [UIImage imageNamed:@"icon_efiling.png"];
//    CGRect frame = CGRectMake(nav.navigationBar.frame.size.width/2-img.size.width/2, nav.navigationBar.frame.size.height/2, img.size.width, img.size.height);
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
//    imageView.image = img;
//    [nav.view addSubview: imageView];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
