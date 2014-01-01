//
//  EfilingChangePasswordViewController.h
//  RDSmartTax
//
//  Created by fone on 12/21/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENChangePassword.h"
#import "KeyboardViewController.h"

@interface EfilingChangePasswordViewController : KeyboardViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,ENChangePasswordServiceDelegate>{
    
    UITextField* txtActiveEditing;
    
}

@property (strong, nonatomic) IBOutlet UILabel *labelOldPassword;
@property (strong, nonatomic) IBOutlet UILabel *labelNewPassword;
@property (strong, nonatomic) IBOutlet UILabel *labelConfirmPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnConfirm;

@property (strong, nonatomic) IBOutlet UITextField *txtOldPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtNewPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtConfirmPassword;
- (IBAction)onConfirmButtonClicked:(id)sender;

@end
