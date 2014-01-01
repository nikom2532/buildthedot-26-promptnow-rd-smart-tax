//
//  EfilingValidatePasswordViewController.h
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "ENAuthenService.h"

#import "Susanoo.h"
#import "M_Login.h"
#import "M_Update_Version.h"
#import "M_GetKeyExchange.h"

@interface EfilingValidatePasswordViewController : KeyboardViewController <UITextFieldDelegate, ENAuthenServiceDelegate,KeyExchangeDelegate, LoginServiceDelegate, UpdateVersionDelegate>

@property (nonatomic, retain) Susanoo *susanooObject;
@property (strong, nonatomic) M_Login *mLogin;
@property (strong, nonatomic) M_Update_Version *mUpdateversion;
@property (retain, nonatomic) M_GetKeyExchange *mGetKeyExchange;

@property (weak, nonatomic) IBOutlet UILabel *labelTitile;
@property (weak, nonatomic) IBOutlet UILabel *labelIdCard;
@property (weak, nonatomic) IBOutlet UILabel *labelIdCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnForgetPassword;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

- (IBAction)onLoginButtonClicked:(id)sender;
- (IBAction)onForgetPasswordButtonClicked:(id)sender;

@property (nonatomic, strong) NSString *pIdCard;
@property (nonatomic, strong) NSString *pUserId;

@end

