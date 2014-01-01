//
//  AppDelegate.h
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "EfilingCheckNewUserViewController.h"
#import "Header.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController* mainViewController;
@property (strong, nonatomic) EfilingCheckNewUserViewController* efilingCheckNewUserViewController;
@property (strong, nonatomic) Header *header;

@end
