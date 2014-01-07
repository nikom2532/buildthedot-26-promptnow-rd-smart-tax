//
//  EfilingRegisterSaveViewController.h
//  RDSmartTax
//
//  Created by Noi on 12/7/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "ENRegisterSaveService.h"

@interface EfilingRegisterSaveViewController : HeaderViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,ENRegisterSaveServiceDelegate,UIPickerViewDataSource, UIPickerViewDelegate>{

	UITextField* nameField_ ;
    UITextField* middleNameField_ ;
	UITextField* surnameField_ ;
	UITextField* birthDateField_ ;
    UITextField* passportNoField_ ;
	UITextField* countryCodeField_ ;
	UITextField* fatherNameField_ ;
	UITextField* motherNameField_ ;
    UITextField* telephoneField_ ;
	UITextField* telephoneExtensionField_ ;
	UITextField* mobileField_ ;
	UITextField* passwordField_ ;
    UITextField* confirmPasswordField_ ;
    UITextField* questionIdField_ ;
	UITextField* answerField_ ;
	UITextField* emailField_ ;
    
    NSMutableArray *dataArray;
    UITextField *txtActiveEditing;

}
@property (nonatomic, retain) IBOutlet UITableView *tableView;

//@property (nonatomic,copy) NSString* nid;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* midleName;
@property (nonatomic,strong) NSString* surname;
@property (nonatomic,strong) NSString* birthDate;
@property (nonatomic,strong) NSString* passportNo;
@property (nonatomic,strong) NSString* countryCode;
@property (nonatomic,strong) NSString* fatherName;
@property (nonatomic,strong) NSString* motherName;
@property (nonatomic,strong) NSString* telephone;
@property (nonatomic,strong) NSString* telephoneExtension;
@property (nonatomic,strong) NSString* mobile;
@property (nonatomic,strong) NSString* password;
@property (nonatomic,strong) NSString* confirmPassword;
@property (nonatomic,strong) NSString* questionId;
@property (nonatomic,strong) NSString* answer;
@property (nonatomic,strong) NSString* email;

@property (nonatomic, strong) NSString *pThaiNation;
@property (nonatomic, strong) NSString *pNid;

@property(nonatomic,retain) UIView *tableFooterView;
- (IBAction)save:(id)sender;
-(void)getQuestionList;

@end
