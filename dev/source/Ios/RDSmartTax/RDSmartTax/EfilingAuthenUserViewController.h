//
//  EfilingAuthenUserViewController.h
//  RDSmartTax
//
//  Created by Noi on 12/20/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "ENConfirmRequestPassword.h"

@interface EfilingAuthenUserViewController : HeaderViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,ENConfirmRequestPasswordServiceDelegate,UIPickerViewDataSource, UIPickerViewDelegate>{

    UITextField* nameField_ ;
    UITextField* middleNameField_ ;
	UITextField* surnameField_ ;
	UITextField* fatherNameField_ ;
    UITextField* motherNameField_ ;
	UITextField* passportNoField_ ;
	UITextField* countryField_ ;
    
    NSMutableArray *dataArray;
    UITextField *txtActiveEditing;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* middleName;
@property (nonatomic,strong) NSString* surname;
@property (nonatomic,strong) NSString* birthDate;
@property (nonatomic,strong) NSString* fatherName;
@property (nonatomic,strong) NSString* motherName;
@property (nonatomic,strong) NSString* passportNo;
@property (nonatomic,strong) NSString* countryCode;

@property (nonatomic,strong) NSString *pNid;
@property (nonatomic,strong) NSString *pThaiNation;
@property (nonatomic,strong) NSString *pBirthDate;
- (IBAction)onButtonConfirmClicked:(id)sender;

@property (nonatomic) ENConfirmRequestPassword *enConfirmRequestPasswordService;

@property (strong, nonatomic) IBOutlet UIButton *buttonConfirm;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain) UIView *tableFooterView;



@end
