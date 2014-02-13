//
//  EfilingPersonalProfileViewController.h
//  RDSmartTax
//
//  Created by fone on 12/22/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENUpdateProfileService.h"
#import "ENGetAmphur.h"
#import "ENGetProvince.h"
#import "EtextField.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
@interface EfilingPersonalProfileViewController : HeaderViewController <UITextFieldDelegate, ENUpdateProfileServiceDelegate, UIGestureRecognizerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate, ENGetAmphurDelegate, ENGetProvinceDelegate> {

    //-- textfield
//    EtextField *nameTitleField_;
    EtextField *nameField_;
    EtextField *middleNameField_;
    EtextField *surnameField_;
    EtextField *telField_;
    EtextField *emailField_;
//    EtextField *countryField_;
    EtextField *passportIdField_;
    
    EtextField *buildNameField_;
    EtextField *roomNoField_;
    EtextField *floorNoField_;
    EtextField *addressNoField_;
    EtextField *soiField_;
    EtextField *villageField_;
    EtextField *mooNoField_;
    EtextField *streetField_;
//    EtextField *tambolField_;
//    EtextField *amphurField_;
//    EtextField *provinceField_;
    EtextField *postcodeField_;

//    EtextField *taxpayerStatusLabel_;0
//    EtextField *spouseStatusField_;1
//    EtextField *marryStatusField_;2
    EtextField *spouseNidField_;
    EtextField *spouseNameField_;
    EtextField *spouseSurnameField_;
//    EtextField *spouseBirthDateField_;
    EtextField *spousePassportIdField_;
//    EtextField *spouseCountryField_;
    EtextField *childNoStudyField_;
    EtextField *childStudyField_;
    EtextField *txpFatherPinField_;
    EtextField *txpMotherPinField_;
    EtextField *spouseFatherPinField_;
    EtextField *spouseMotherPinField_;
    
    EtextField *txtActiveEditing;
    NSMutableArray *dataArray;
    
}
@property (nonatomic) ENUpdateProfileService *enUpdateProfileService;
@property (nonatomic) ENGetAmphur *enGetAmphur;
@property (nonatomic) ENGetProvince *enGetProvince;

@property (weak, nonatomic) IBOutlet UIView *pHeaderView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,copy) NSString *nid;
@property (nonatomic,copy) NSString *nameTitle;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *middleName;
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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
