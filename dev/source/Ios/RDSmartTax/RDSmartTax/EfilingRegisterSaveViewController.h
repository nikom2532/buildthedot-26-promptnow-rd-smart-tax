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

@interface EfilingRegisterSaveViewController : KeyboardViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,ENRegisterSaveServiceDelegate>{
   
    //NSString* nid_ ;
	NSString* name_ ;
	NSString* surname_ ;
	NSString* birthDate_ ;
    NSString* passportNo_ ;
	NSString* countryCode_ ;
	NSString* fatherName_ ;
	NSString* motherName_ ;
    NSString* telephone_ ;
	NSString* telephoneExtension_ ;
    NSString* mobile_ ;
	NSString* password_ ;
    NSString* confirmPassword_ ;
	NSString* questionId_ ;
    NSString* answer_ ;
	NSString* email_ ;    
	
	//UITextField* nidField_ ;
	UITextField* nameField_ ;
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
    UIView *tableFooterView;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property (nonatomic,copy) NSString* nid;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* surname;
@property (nonatomic,copy) NSString* birthDate;
@property (nonatomic,copy) NSString* passportNo;
@property (nonatomic,copy) NSString* countryCode;
@property (nonatomic,copy) NSString* fatherName;
@property (nonatomic,copy) NSString* motherName;
@property (nonatomic,copy) NSString* telephone;
@property (nonatomic,copy) NSString* telephoneExtension;
@property (nonatomic,copy) NSString* mobile;
@property (nonatomic,copy) NSString* password;
@property (nonatomic,copy) NSString* confirmPassword;
@property (nonatomic,copy) NSString* questionId;
@property (nonatomic,copy) NSString* answer;
@property (nonatomic,copy) NSString* email;

@property (nonatomic, strong) NSString *pThaiNation;
@property (nonatomic, strong) NSString *pNid;

@property(nonatomic,retain) UIView *tableFooterView;
- (IBAction)save:(id)sender;


- (IBAction)clicked:(id)sender;

@end
