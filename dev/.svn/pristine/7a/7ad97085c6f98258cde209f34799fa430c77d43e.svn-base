//
//  EfilingChangeOnlyPasswordViewController.h
//  RDSmartTax
//
//  Created by Noi on 12/19/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "ENChangeOnlyPasswordService.h"

@interface EfilingChangeOnlyPasswordViewController : KeyboardViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,ENChangeOnlyPasswordServiceDelegate>{
    UITextField* txtActiveEditing;
}

@property (nonatomic,copy) NSString* pNid;
@property (strong, nonatomic) IBOutlet UILabel *labelNewPassword;
@property (strong, nonatomic) IBOutlet UILabel *labelConfirmPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtNewPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtConfirmNewPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;

@property (nonatomic) ENChangeOnlyPasswordService *enChangeOnlyPasswordService;

- (IBAction)onHintPasswordButtonClicked:(id)sender;
- (IBAction)onHintPasswordConfirmButtonClicked:(id)sender;
- (IBAction)onConfirmButtonClicked:(id)sender;

@end
