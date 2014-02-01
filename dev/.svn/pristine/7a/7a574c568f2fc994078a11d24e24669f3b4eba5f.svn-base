//
//  EfilingForgetPasswordQuestionViewController.h
//  RDSmartTax
//
//  Created by Noi on 12/19/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "ENConfirmQuestionService.h"

@interface EfilingForgetPasswordQuestionViewController : KeyboardViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,ENConfirmQuestionServiceDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
    
    UITextField* txtActiveEditing;
    
}
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSString* pNid;
@property (nonatomic,strong) NSString *pBirthDate;
@property (nonatomic,strong) NSString* pQuestion;
@property (nonatomic,strong) NSString* pAnswer;
@property (nonatomic,strong) NSString* pVersion;
@property (nonatomic,strong) NSString* pThaiNation;
@property (strong, nonatomic) IBOutlet UITextField *txtQuestion;
@property (strong, nonatomic) IBOutlet UITextField *txtAnswer;
@property (strong, nonatomic) IBOutlet UILabel *labelQuestion;
@property (strong, nonatomic) IBOutlet UILabel *labelAnswer;
@property (strong, nonatomic) IBOutlet UIButton *btnConfirm;
@property (strong, nonatomic) IBOutlet UIButton *btnForgetQuestion;

@property (nonatomic) ENConfirmQuestionService *enConfirmQuestionService;

- (IBAction)onConfirmButtonClicked:(id)sender;
- (IBAction)onForgotButtonClicked:(id)sender;


@end
