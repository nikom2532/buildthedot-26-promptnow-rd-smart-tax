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

@interface EfilingForgetPasswordViewController : HeaderViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,ENResetPasswordRequestServiceDelegate>{
UITextField *txtActiveEditing;
}

@property (strong, nonatomic) IBOutlet UIView *birthDateView;
@property (nonatomic,strong) NSString* pNid;
@property (nonatomic,strong) NSString* pThaiNation;
@property (strong, nonatomic) IBOutlet UILabel *labelNid;
@property (strong, nonatomic) IBOutlet UILabel *txtNid;
@property (strong, nonatomic) IBOutlet UIButton *btnConfirm;

@property (nonatomic) ENResetPasswordRequestService *enResetPasswordRequestService;

- (IBAction)onConfirmButtonClicked:(id)sender;

@property (strong, nonatomic) UIDatePicker* datePicker;

@end
