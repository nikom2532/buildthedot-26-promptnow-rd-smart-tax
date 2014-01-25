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

#import "Susanoo.h"
#import "M_Login.h"
#import "M_Update_Version.h"
#import "M_GetKeyExchange.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,KeyExchangeDelegate, LoginServiceDelegate, UpdateVersionDelegate>

@property (nonatomic, retain) Susanoo *susanooObject;
@property (strong, nonatomic) M_Login *mLogin;
@property (strong, nonatomic) M_Update_Version *mUpdateversion;
@property (retain, nonatomic) M_GetKeyExchange *mGetKeyExchange;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController* mainViewController;
@property (strong, nonatomic) EfilingCheckNewUserViewController* efilingCheckNewUserViewController;
@property (strong, nonatomic) Header *header;

@end
