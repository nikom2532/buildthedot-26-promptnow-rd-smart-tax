//
//  EfilingGeneralProfileViewController.h
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "ENUpdateProfileService.h"
#import "ENSaveLoginFirstService.h"

@interface EfilingGeneralProfileViewController : KeyboardViewController <UITextFieldDelegate, ENUpdateProfileServiceDelegate, UIGestureRecognizerDelegate, ENSaveLoginFirstServiceDelegate> {
    
/*
    //-- text
//    NSString *nid_;
//    NSString *version_;
//    NSString *authenKey_;
    NSString *name_;
    NSString *surname_;
//    NSString *birthDate_;
    NSString *tel_;
    NSString *email_;
    NSString *country_;
    NSString *passportId_;
    
    NSString *buildName_;
    NSString *roomNo_;
    NSString *floorNo_;
    NSString *addressNo_;
    NSString *soi_;
    NSString *village_;
    NSString *mooNo_;
    NSString *street_;
    NSString *tambol_;
    NSString *amphur_;
    NSString *province_;
    NSString *postcode_;
    
    NSString *taxpayerStatus_;
    NSString *spouseStatus_;
    NSString *marryStatus_;
    NSString *spouseNid_;
    NSString *spouseName_;
    NSString *spouseSurname_;
    NSString *childNoStudy_;
    NSString *childStudy_;
    NSString *txpFatherPin_;
    NSString *txpMotherPin_;
    NSString *spouseFatherPin_;
    NSString *spouseMotherPin_;
*/
    
    
    
    //-- textfield
    UITextField *nameField_;
    UITextField *surnameField_;
    UITextField *telField_;
    UITextField *emailField_;
    UITextField *countryField_;
    UITextField *passportIdField_;
    
    UITextField *buildNameField_;
    UITextField *roomNoField_;
    UITextField *floorNoField_;
    UITextField *addressNoField_;
    UITextField *soiField_;
    UITextField *villageField_;
    UITextField *mooNoField_;
    UITextField *streetField_;
    UITextField *tambolField_;
    UITextField *amphurField_;
    UITextField *provinceField_;
    UITextField *postcodeField_;
    
    UITextField *taxpayerStatusField_;
    UITextField *spouseStatusField_;
    UITextField *marryStatusField_;
    UITextField *spouseNidField_;
    UITextField *spouseNameField_;
    UITextField *spouseSurnameField_;
    UITextField *spouseBirthDateField_;
    UITextField *spousePassportIdField_;
    UITextField *spouseCountryField_;
    UITextField *childNoStudyField_;
    UITextField *childStudyField_;
    UITextField *txpFatherPinField_;
    UITextField *txpMotherPinField_;
    UITextField *spouseFatherPinField_;
    UITextField *spouseMotherPinField_;
    
    UITextField *txtActiveEditing;
    NSMutableArray *dataArray;
    //[but addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *surname;
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *country;
@property (nonatomic,copy) NSString *passportId;

@property (nonatomic,copy) NSString *buildName;
@property (nonatomic,copy) NSString *roomNo;
@property (nonatomic,copy) NSString *floorNo;
@property (nonatomic,copy) NSString *addressNo;
@property (nonatomic,copy) NSString *soi;
@property (nonatomic,copy) NSString *village;
@property (nonatomic,copy) NSString *mooNo;
@property (nonatomic,copy) NSString *street;
@property (nonatomic,copy) NSString *tambol;
@property (nonatomic,copy) NSString *amphur;
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *postcode;

@property (nonatomic,copy) NSString *taxpayerStatus;
@property (nonatomic,copy) NSString *spouseStatus;
@property (nonatomic,copy) NSString *marryStatus;
@property (nonatomic,copy) NSString *spouseNid;
@property (nonatomic,copy) NSString *spouseName;
@property (nonatomic,copy) NSString *spouseSurname;
@property (nonatomic,copy) NSString *spouseBirthDate;
@property (nonatomic,copy) NSString *spousePassportId;
@property (nonatomic,copy) NSString *spouseCountry;
@property (nonatomic,copy) NSString *childNoStudy;
@property (nonatomic,copy) NSString *childStudy;
@property (nonatomic,copy) NSString *txpFatherPin;
@property (nonatomic,copy) NSString *txpMotherPin;
@property (nonatomic,copy) NSString *spouseFatherPin;
@property (nonatomic,copy) NSString *spouseMotherPin;

@property (nonatomic,weak) NSString *pFirstLogin;
@end
