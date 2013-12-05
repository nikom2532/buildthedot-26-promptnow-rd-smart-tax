//
//  EfilingCheckNewUserViewController.h
//  RDSmartTax
//
//  Created by fone on 12/4/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "ENCheckNewUserService.h"

@interface EfilingCheckNewUserViewController : KeyboardViewController <UITextFieldDelegate, ENCheckNewUserServiceDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelIdCard;
@property (weak, nonatomic) IBOutlet UITextField *txtIdCard;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)onLoginButtonClicked:(id)sender;

@end
