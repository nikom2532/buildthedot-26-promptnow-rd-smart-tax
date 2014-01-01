//
//  EfilingForgetPasswordViewController.h
//  RDSmartTax
//
//  Created by Noi on 12/16/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "ENResetPasswordRequestService.h"
#import "WCLabel.h"
@interface EfilingForgetPasswordViewController : HeaderViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,ENResetPasswordRequestServiceDelegate>{
UITextField *txtActiveEditing;
}

@property (strong, nonatomic) IBOutlet UIView *birthDateView;
@property (nonatomic,copy) NSString* pNid;
@property (strong, nonatomic) IBOutlet UILabel *labelNid;
@property (strong, nonatomic) IBOutlet UILabel *txtNid;
@property (strong, nonatomic) IBOutlet UILabel *labelBirthDate;
@property (strong, nonatomic) IBOutlet UIButton *btnConfirm;

- (IBAction)onConfirmButtonClicked:(id)sender;

@property (strong, nonatomic) IBOutlet WCLabel *txtBirthDates;
@property (strong, nonatomic) UIDatePicker* datePicker;

@end
