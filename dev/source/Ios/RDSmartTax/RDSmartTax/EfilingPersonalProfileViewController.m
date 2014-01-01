//
//  EfilingPersonalProfileViewController.m
//  RDSmartTax
//
//  Created by fone on 12/22/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingPersonalProfileViewController.h"
#import "EfilingHomeViewController.h"
#import "EfilingUserProfileViewController.h"

#import "TextFieldModel.h"
#import "DropdownViewModel.h"

#import "FontUtil.h"
#import "Util.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"
#import "JLString.h"
#import "TextFormatterUtil.h"

@interface EfilingPersonalProfileViewController () {
    
    ENUpdateProfileService *enUpdateProfileService;
    ENSaveLoginFirstService *enSaveLoginFirstService;
    
    //-- master val
    NSMutableArray *masterGeneralTitle;
    NSMutableArray *masterGeneralValue;
    NSMutableArray *masterGeneralPlaceHolder;
    NSMutableArray *masterGeneralKeyboardType;
    NSMutableArray *masterGeneralDisplayType;
    NSMutableArray *masterGeneralTextField;
    
    NSMutableArray *masterAddressTitle;
    NSMutableArray *masterAddressValue;
    NSMutableArray *masterAddressPlaceHolder;
    NSMutableArray *masterAddressKeyboardType;
    NSMutableArray *masterAddressDisplayType;
    NSMutableArray *masterAddressTextField;
    
    NSMutableArray *masterTaxTitle;
    NSMutableArray *masterTaxValue;
    NSMutableArray *masterTaxPlaceHolder;
    NSMutableArray *masterTaxKeyboardType;
    NSMutableArray *masterTaxDisplayType;
    NSMutableArray *masterTaxTextfield;
    
    //-- current data
    int currentRule;
    NSString *currentThaiNation;
    NSString *currentNameTitle;
    NSString *currentTaxpayerStatus;
    NSString *currentSpouseStatus;
    NSString *currentMarryStatus;
    NSString *currentSpouseBirthDate;
    NSLocale *currentLocale;
    NSDateFormatter* dateFormatter;
    
    NSMutableArray *ddNameTitleIdHashArray;
    NSMutableArray *ddNameTitleNameHashArray;
    NSMutableArray *ddTaxpayerHashArray;
    NSMutableArray *ddSpouseHashArray;
    NSMutableArray *ddMarryHashArray;
    
    //-- keyboard type
    NSString *kbTypeNone;
    NSString *kbTypeAlplabet;
    NSString *kbTypeNumber;
    NSString *kbTypePhone;
    NSString *kbTypeEmail;
    
    //-- display type
    NSString *displayTypeLabel;
    NSString *displayTypeTextfield;
    NSString *displayTypeDropdownDate;
    NSString *displayTypeDropdown;
    
    //-- permission
    NSMutableArray* generalPermission;
    NSMutableArray* taxPermission;
    
    //-- bool
    NSNumber* Y;
    NSNumber* N;
    
    //-- ready array
    NSMutableArray *readyGeneralTitle;
    NSMutableArray *readyGeneralValue;
    NSMutableArray *readyGeneralPlaceHolder;
    NSMutableArray *readyGeneralKeyboardType;
    NSMutableArray *readyGeneralDisplayType;
    NSMutableArray *readyGeneralTextfield;
    
    NSMutableArray *readyTaxTitle;
    NSMutableArray *readyTaxValue;
    NSMutableArray *readyTaxPlaceHolder;
    NSMutableArray *readyTaxKeyboardType;
    NSMutableArray *readyTaxDisplayType;
    NSMutableArray *readyTaxTextfield;
    
    //-- model
    TextFieldModel *textFieldModel;
    DropdownViewModel *dropdownViewModel;
    
    //-- dropdown
    UIPickerView *dropDownPickerView;
    UIActionSheet *dropDownActionSheet;
    UIButton *currentButton;
    
    UIDatePicker *dropDownDatePickerView;
    
    NSDictionary *readyGeneralDic;
    NSDictionary *masterAddressDic;
    NSDictionary *readyTaxDic;
}

@end

@implementation EfilingPersonalProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [btnNext setTitle:[Util stringWithScreenName:@"Common" labelName:@"Save"] forState:UIControlStateNormal];
    
    //-- set table view
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.navigationController.navigationBar.hidden = YES;
    //-- Header
    self.header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    self.header.pImage.image = [UIImage imageNamed:@"icon_efiling.png"];
    self.header.pLabel.hidden = YES;
    [self.header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.header.pRightButton.hidden = YES;
    [self.pHeaderView addSubview:self.header];
    
    //-- init data
    Y = [NSNumber numberWithBool:YES];
    N = [NSNumber numberWithBool:NO];
    
    //-- set current
    currentNameTitle = [ShareUserDetail retrieveDataWithStringKey:@"titleName"];
    currentThaiNation = [ShareUserDetail retrieveDataWithStringKey:@"thaiNation"];
    currentTaxpayerStatus = [ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"];
    currentSpouseStatus = [ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"];
    currentMarryStatus = [ShareUserDetail retrieveDataWithStringKey:@"marryStatus"];
    currentSpouseBirthDate = [ShareUserDetail retrieveDataWithStringKey:@"spouseBirthDate"];
    
    //-- keyboard type
    kbTypeNone = @"0";
    kbTypeAlplabet = @"1";
    kbTypeNumber = @"2";
    kbTypePhone = @"3";
    kbTypeEmail = @"4";
    
    //-- display type
    displayTypeLabel = @"0";
    displayTypeTextfield = @"1";
    displayTypeDropdownDate = @"2";
    displayTypeDropdown = @"3";
    
    //-- table view
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //-- Check locale and set date format
    currentLocale = [self checkLocale];
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    [dateFormatter setLocale:currentLocale];
    
    //-- init master data
    [self initvariable];
    [self initTextfield];
    [self initMasterData];
    
    if ([self.pFirstLogin isEqualToString:@"1"]) {
        //-- save first login
        enSaveLoginFirstService = [[ENSaveLoginFirstService alloc]init];
        enSaveLoginFirstService.delegate = self;
        [enSaveLoginFirstService requestENSaveLoginFirstServiceWithNid:[ShareUserDetail retrieveDataWithStringKey:@"nid"]];
    }
    
    //-- Initialize the dataArray
    dataArray = [[NSMutableArray alloc] init];
    
    //-- init dropdown
    [self initDropdownData];
    
    //-- get general permission
    generalPermission = [self getGeneralPermission];
    [self setGeneralReadyDataWithPermission:generalPermission];
    
    //-- get tax permission
    taxPermission = [self getTaxPermission];
    [self setTaxReadyDataWithPermission:taxPermission];
    
    //-- set state
    [self setTableViewState];
    
    //-- Add Tap Gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}

- (NSLocale *) checkLocale {
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        return [[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"];
    } else {
        return [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    }
}

#pragma mark - ready data
- (void) setTableViewState {
    readyGeneralDic = [NSDictionary dictionaryWithObject:readyGeneralTitle forKey:@"data"];
    [dataArray addObject:readyGeneralDic];
    masterAddressDic = [NSDictionary dictionaryWithObject:masterAddressTitle forKey:@"data"];
    [dataArray addObject:masterAddressDic];
    readyTaxDic = [NSDictionary dictionaryWithObject:readyTaxTitle forKey:@"data"];
    [dataArray addObject:readyTaxDic];
}
- (void) setGeneralReadyDataWithPermission : (NSMutableArray *) permiss {
    
    readyGeneralTitle = [[NSMutableArray alloc]init];
    readyGeneralValue = [[NSMutableArray alloc]init];
    readyGeneralPlaceHolder = [[NSMutableArray alloc]init];
    readyGeneralKeyboardType = [[NSMutableArray alloc]init];
    readyGeneralDisplayType = [[NSMutableArray alloc]init];
    readyGeneralTextfield = [[NSMutableArray alloc]init];
    for (int i = 0; i < [permiss count];i++) {
        if ([permiss objectAtIndex:i]==Y) {
            [readyGeneralTitle addObject:[masterGeneralTitle objectAtIndex:i]];
            [readyGeneralValue addObject:[masterGeneralValue objectAtIndex:i]];
            [readyGeneralPlaceHolder addObject:[masterGeneralPlaceHolder objectAtIndex:i]];
            [readyGeneralKeyboardType addObject:[masterGeneralKeyboardType objectAtIndex:i]];
            [readyGeneralDisplayType addObject:[masterGeneralDisplayType objectAtIndex:i]];
            [readyGeneralTextfield addObject:[masterGeneralTextField objectAtIndex:i]];
        }
    }
}

- (void) setTaxReadyDataWithPermission : (NSMutableArray *) permiss {

    readyTaxTitle = [[NSMutableArray alloc]init];
    readyTaxValue = [[NSMutableArray alloc]init];
    readyTaxPlaceHolder = [[NSMutableArray alloc]init];
    readyTaxKeyboardType = [[NSMutableArray alloc]init];
    readyTaxDisplayType = [[NSMutableArray alloc]init];
    readyTaxTextfield = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [permiss count];i++) {
        if ([permiss objectAtIndex:i]==Y) {
            [readyTaxTitle addObject:[masterTaxTitle objectAtIndex:i]];
            [readyTaxValue addObject:[masterTaxValue objectAtIndex:i]];
            [readyTaxPlaceHolder addObject:[masterTaxPlaceHolder objectAtIndex:i]];
            [readyTaxKeyboardType addObject:[masterTaxKeyboardType objectAtIndex:i]];
            [readyTaxDisplayType addObject:[masterTaxDisplayType objectAtIndex:i]];
            [readyTaxTextfield addObject:[masterTaxTextfield objectAtIndex:i]];
        }
    }
}

#pragma mark - permission - RULE

- (NSMutableArray *) getGeneralPermission {
    //-- Thai
    if ([currentThaiNation isEqualToString:@"1"]) {
        return [[NSMutableArray alloc]initWithObjects:Y,Y,Y,Y,Y,N,N,Y,Y, nil];
    
    } else {
        return [[NSMutableArray alloc]initWithObjects:Y,Y,Y,Y,Y,Y,Y,Y,Y, nil];
        
    }
    
}
- (NSMutableArray *) getTaxPermission {
    
    //-- Thai
    if ([currentThaiNation isEqualToString:@"1"]) {
        
        //-- Single and devorce
        if ([currentTaxpayerStatus isEqualToString:@"0"] || [currentTaxpayerStatus isEqualToString:@"3"]) {
            currentRule = 1;
            return [[NSMutableArray alloc]initWithObjects:Y,N,N,N,N,N,N,N,N,Y,Y,N,N,Y,Y, nil];
            
        //-- Marry Thai
        } else if ([currentTaxpayerStatus isEqualToString:@"1"]) {
            
            //-- have salary
            if ([currentSpouseStatus isEqualToString:@"1"]) {
                currentRule = 2;
                return [[NSMutableArray alloc]initWithObjects:Y,Y,Y,Y,Y,Y,Y,N,N,Y,Y,N,N,Y,Y, nil];
                
            } else {
                currentRule = 3;
                return [[NSMutableArray alloc]initWithObjects:Y,Y,Y,Y,Y,Y,Y,N,N,Y,Y,Y,Y,Y,Y, nil];
                
            }
            
            
        //-- Marry Eng
        } else {
            
            //-- have salary
            if ([currentSpouseStatus isEqualToString:@"1"]) {
                currentRule = 4;
                return [[NSMutableArray alloc]initWithObjects:Y,Y,Y,Y,Y,Y,Y,N,N,Y,Y,N,N,Y,Y, nil];
                
            } else {
                currentRule = 5;
                return [[NSMutableArray alloc]initWithObjects:Y,Y,Y,N,Y,Y,Y,Y,Y,Y,Y,N,N,Y,Y, nil];
                
            }
        }
        
    //-- Eng
    } else {
        
        //-- Single and devorce
        if ([currentTaxpayerStatus isEqualToString:@"0"] || [currentTaxpayerStatus isEqualToString:@"3"]) {
            currentRule = 6;
            return [[NSMutableArray alloc]initWithObjects:Y,N,N,N,N,N,N,N,N,N,N,N,N,Y,Y, nil];
            
        //-- Marry Thai
        } else if ([currentTaxpayerStatus isEqualToString:@"1"]) {
            
            //-- have salary
            if ([currentSpouseStatus isEqualToString:@"1"]) {
                currentRule = 7;
                return [[NSMutableArray alloc]initWithObjects:Y,Y,Y,Y,Y,Y,Y,N,N,N,N,N,N,Y,Y, nil];
                
            } else {
                currentRule = 8;
                return [[NSMutableArray alloc]initWithObjects:Y,Y,Y,Y,Y,Y,Y,N,N,N,N,Y,Y,Y,Y, nil];
                
            }
            
            
        //-- Marry Eng
        } else {
            
            //-- have salary
            if ([currentSpouseStatus isEqualToString:@"1"]) {
                currentRule = 9;
                return [[NSMutableArray alloc]initWithObjects:Y,Y,Y,Y,Y,Y,Y,N,N,N,N,N,N,Y,Y, nil];
            } else {
                currentRule = 10;
                return [[NSMutableArray alloc]initWithObjects:Y,Y,Y,N,Y,Y,Y,Y,Y,N,N,N,N,Y,Y, nil];
            }
        }
    }
}

#pragma mark - MASTER DATA
- (void) initvariable {

    //-- general
    self.nid = [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"nid"]];
    self.nameTitle = [ShareUserDetail retrieveDataWithStringKey:@"titleName"];
    self.name = [ShareUserDetail retrieveDataWithStringKey:@"name"];
    self.middleName = [ShareUserDetail retrieveDataWithStringKey:@"middleName"];
    self.surname = [ShareUserDetail retrieveDataWithStringKey:@"surname"];
    self.tel = [TextFormatterUtil formatMobileNo:[ShareUserDetail retrieveDataWithStringKey:@"contractNo"]];
    self.email = [ShareUserDetail retrieveDataWithStringKey:@"email"];
    self.country = [ShareUserDetail retrieveDataWithStringKey:@"countryCode"];
    self.passportId = [ShareUserDetail retrieveDataWithStringKey:@"passportNo"];
    
    //-- address
    self.buildName = [ShareUserDetail retrieveDataWithStringKey:@"buildName"];;
    self.roomNo = [ShareUserDetail retrieveDataWithStringKey:@"roomNo"];
    self.floorNo = [ShareUserDetail retrieveDataWithStringKey:@"floorNo"];
    self.addressNo = [ShareUserDetail retrieveDataWithStringKey:@"addressNo"];
    self.soi = [ShareUserDetail retrieveDataWithStringKey:@"soi"];
    self.village = [ShareUserDetail retrieveDataWithStringKey:@"village"];
    self.mooNo = [ShareUserDetail retrieveDataWithStringKey:@"mooNo"];
    self.street = [ShareUserDetail retrieveDataWithStringKey:@"street"];
    self.tambol = [ShareUserDetail retrieveDataWithStringKey:@"tambol"];
    self.amphur = [ShareUserDetail retrieveDataWithStringKey:@"amphur"];
    self.province = [ShareUserDetail retrieveDataWithStringKey:@"province"];
    self.postcode = [ShareUserDetail retrieveDataWithStringKey:@"postcode"];
    
    //-- tax
    NSString *hashTaxpayerStatus = [NSString stringWithFormat:@"%@%@", @"taxpayerHash",[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"]];
    self.taxpayerStatus = [ShareUserDetail retrieveDataWithStringKey:hashTaxpayerStatus];
    
    NSString *hashMarryStatus = [NSString stringWithFormat:@"%@%@", @"marryHash",[ShareUserDetail retrieveDataWithStringKey:@"marryStatus"]];
    self.marryStatus = [ShareUserDetail retrieveDataWithStringKey:hashMarryStatus];
    
    NSString *hashSpouseStatus = [NSString stringWithFormat:@"%@%@", @"spouseHash",[ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"]];
    self.spouseStatus = [ShareUserDetail retrieveDataWithStringKey:hashSpouseStatus];
    
    self.spouseNid = [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"spouseNid"]];
    self.spouseName = [ShareUserDetail retrieveDataWithStringKey:@"spouseName"];
    self.spouseSurname = [ShareUserDetail retrieveDataWithStringKey:@"spouseSurname"];
    self.spouseBirthDate = [ShareUserDetail retrieveDataWithStringKey:@"spouseBirthDate"];
    self.spousePassportId = [ShareUserDetail retrieveDataWithStringKey:@"spousePassportNo"];
    self.spouseCountry = [ShareUserDetail retrieveDataWithStringKey:@"spouseCountryCode"];
    self.txpFatherPin = [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"txpFatherPin"]];
    self.txpMotherPin = [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"txpMotherPin"]];
    self.spouseFatherPin = [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"spouseFatherPin"]];
    self.spouseMotherPin = [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"spouseMotherPin"]];
    self.childNoStudy = [ShareUserDetail retrieveDataWithStringKey:@"childNoStudy"];
    self.childStudy = [ShareUserDetail retrieveDataWithStringKey:@"childStudy"];
}

- (void) initTextfield {
    nameField_ = [[EtextField alloc]init];
    middleNameField_ = [[EtextField alloc]init];
    surnameField_ = [[EtextField alloc]init];
    telField_ = [[EtextField alloc]init];
    emailField_ = [[EtextField alloc]init];
    passportIdField_ = [[EtextField alloc]init];
    
    buildNameField_ = [[EtextField alloc]init];
    roomNoField_ = [[EtextField alloc]init];
    floorNoField_ = [[EtextField alloc]init];
    addressNoField_ = [[EtextField alloc]init];
    soiField_ = [[EtextField alloc]init];
    villageField_ = [[EtextField alloc]init];
    mooNoField_ = [[EtextField alloc]init];
    streetField_ = [[EtextField alloc]init];
    postcodeField_ = [[EtextField alloc]init];
    
    spouseNidField_ = [[EtextField alloc]init];
    spouseNameField_ = [[EtextField alloc]init];
    spouseSurnameField_ = [[EtextField alloc]init];
    spousePassportIdField_ = [[EtextField alloc]init];
    childNoStudyField_ = [[EtextField alloc]init];
    childStudyField_ = [[EtextField alloc]init];
    txpFatherPinField_ = [[EtextField alloc]init];
    txpMotherPinField_ = [[EtextField alloc]init];
    spouseFatherPinField_ = [[EtextField alloc]init];
    spouseMotherPinField_ = [[EtextField alloc]init];
}

- (void) initDropdownData {
    
    ddNameTitleIdHashArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"titleId"]];
    ddNameTitleNameHashArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"titleNameHash"]];
    
    ddTaxpayerHashArray = [[NSMutableArray alloc]initWithObjects:[ShareUserDetail retrieveDataWithStringKey:@"taxpayerHash0"],
                           [ShareUserDetail retrieveDataWithStringKey:@"taxpayerHash1"],
                           [ShareUserDetail retrieveDataWithStringKey:@"taxpayerHash2"], nil];
    
    ddSpouseHashArray = [[NSMutableArray alloc]initWithObjects:[ShareUserDetail retrieveDataWithStringKey:@"spouseHash0"],
                         [ShareUserDetail retrieveDataWithStringKey:@"spouseHash1"],nil];
    
    ddMarryHashArray = [[NSMutableArray alloc]initWithObjects:[ShareUserDetail retrieveDataWithStringKey:@"marryHash0"],
                        [ShareUserDetail retrieveDataWithStringKey:@"marryHash1"],
                        [ShareUserDetail retrieveDataWithStringKey:@"marryHash2"],
                        [ShareUserDetail retrieveDataWithStringKey:@"marryHash3"], nil];
}

- (void) initMasterData {
    
    //----------------------- GENERAL DATA -----------------------
    masterGeneralTitle = [[NSMutableArray alloc]initWithObjects:
                          [Util stringWithScreenName:@"Common" labelName:@"Nid"],
                          [Util stringWithScreenName:@"Common" labelName:@"NameTitle"],
                          [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                          [Util stringWithScreenName:@"Common" labelName:@"MiddleName"],
                          [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                          [Util stringWithScreenName:@"Common" labelName:@"Passport"],
                          [Util stringWithScreenName:@"Common" labelName:@"Country"],
                          [Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
                          [Util stringWithScreenName:@"Common" labelName:@"Email"],
                          nil];
    
//    masterGeneralValue = [[NSMutableArray alloc]initWithObjects:
//                          [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"nid"]],
//                          currentNameTitle,
//                          [ShareUserDetail retrieveDataWithStringKey:@"name"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"middleName"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"surname"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"passportNo"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"countryCode"],
//                          [TextFormatterUtil formatMobileNo:[ShareUserDetail retrieveDataWithStringKey:@"contractNo"]],
//                          [ShareUserDetail retrieveDataWithStringKey:@"email"],
//                          nil];

    masterGeneralValue = [[NSMutableArray alloc]initWithObjects:
                          self.nid,
                          currentNameTitle,
                          self.name,
                          self.middleName,
                          self.surname,
                          self.passportId,
                          self.country,
                          self.tel,
                          self.email,
                          nil];
    
    masterGeneralPlaceHolder = [[NSMutableArray alloc]initWithObjects:
                                [Util stringWithScreenName:@"Common" labelName:@"Nid"],
                                [Util stringWithScreenName:@"Common" labelName:@"NameTitle"],
                                [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                                [Util stringWithScreenName:@"Common" labelName:@"MiddleName"],
                                [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                                [Util stringWithScreenName:@"Common" labelName:@"Passport"],
                                [Util stringWithScreenName:@"Common" labelName:@"Country"],
                                [Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
                                [Util stringWithScreenName:@"Common" labelName:@"Email"],
                                nil];
    
    masterGeneralDisplayType = [[NSMutableArray alloc]initWithObjects:
                                displayTypeLabel,
                                displayTypeDropdown,
                                displayTypeTextfield,
                                displayTypeTextfield,
                                displayTypeTextfield,
                                displayTypeTextfield,
                                displayTypeDropdown,
                                displayTypeTextfield,
                                displayTypeTextfield,
                                nil];
    
    masterGeneralKeyboardType = [[NSMutableArray alloc]initWithObjects:
                                 kbTypeNone,
                                 kbTypeNone,
                                 kbTypeAlplabet,
                                 kbTypeAlplabet,
                                 kbTypeAlplabet,
                                 kbTypeNumber,
                                 kbTypeNone,
                                 kbTypePhone,
                                 kbTypeEmail,
                                 nil];
    
    masterGeneralTextField = [[NSMutableArray alloc]initWithObjects:
                                 @"",
                                 @"",
                                 nameField_,
                                 middleNameField_,
                                 surnameField_,
                                 passportIdField_,
                                 @"",
                                 telField_,
                                 emailField_,
                                 nil];
    
    //----------------------- ADDRESS DATA -----------------------
    masterAddressTitle = [[NSMutableArray alloc]initWithObjects:
                           [Util stringWithScreenName:@"Common" labelName:@"BuildName"],
                           [Util stringWithScreenName:@"Common" labelName:@"RoomNo"],
                           [Util stringWithScreenName:@"Common" labelName:@"FloorNo"],
                           [Util stringWithScreenName:@"Common" labelName:@"AddressNo"],
                           [Util stringWithScreenName:@"Common" labelName:@"Soi"],
                           [Util stringWithScreenName:@"Common" labelName:@"Village"],
                           [Util stringWithScreenName:@"Common" labelName:@"MooNo"],
                           [Util stringWithScreenName:@"Common" labelName:@"Street"],
                           [Util stringWithScreenName:@"Common" labelName:@"Province"],
                           [Util stringWithScreenName:@"Common" labelName:@"Amphur"],
                           [Util stringWithScreenName:@"Common" labelName:@"Tambol"],
                           [Util stringWithScreenName:@"Common" labelName:@"Postcode"],
                           nil];
    
//    masterAddressValue = [[NSMutableArray alloc]initWithObjects:
//                          [ShareUserDetail retrieveDataWithStringKey:@"buildName"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"roomNo"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"floorNo"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"addressNo"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"soi"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"village"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"mooNo"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"street"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"province"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"amphur"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"tambol"],
//                          [ShareUserDetail retrieveDataWithStringKey:@"postcode"],
//    nil];
    
    masterAddressValue = [[NSMutableArray alloc]initWithObjects:
                          self.buildName,
                          self.roomNo,
                          self.floorNo,
                          self.addressNo,
                          self.soi,
                          self.village,
                          self.mooNo,
                          self.street,
                          self.province,
                          self.amphur,
                          self.tambol,
                          self.postcode,
                          nil];
    
    masterAddressPlaceHolder = [[NSMutableArray alloc]initWithObjects:
                                [Util stringWithScreenName:@"Common" labelName:@"BuildName"],
                                [Util stringWithScreenName:@"Common" labelName:@"RoomNo"],
                                [Util stringWithScreenName:@"Common" labelName:@"FloorNo"],
                                [Util stringWithScreenName:@"Common" labelName:@"AddressNo"],
                                [Util stringWithScreenName:@"Common" labelName:@"Soi"],
                                [Util stringWithScreenName:@"Common" labelName:@"Village"],
                                [Util stringWithScreenName:@"Common" labelName:@"MooNo"],
                                [Util stringWithScreenName:@"Common" labelName:@"Street"],
                                [Util stringWithScreenName:@"Common" labelName:@"Province"],
                                [Util stringWithScreenName:@"Common" labelName:@"Amphur"],
                                [Util stringWithScreenName:@"Common" labelName:@"Tambol"],
                                [Util stringWithScreenName:@"Common" labelName:@"Postcode"],
                                nil];
    
    masterAddressDisplayType = [[NSMutableArray alloc]initWithObjects:
                                displayTypeTextfield,
                                displayTypeTextfield,
                                displayTypeTextfield,
                                displayTypeTextfield,
                                displayTypeTextfield,
                                displayTypeTextfield,
                                displayTypeTextfield,
                                displayTypeTextfield,
                                displayTypeDropdown,
                                displayTypeDropdown,
                                displayTypeDropdown,
                                displayTypeTextfield,
                                nil];
    
    masterAddressKeyboardType = [[NSMutableArray alloc]initWithObjects:
                                 kbTypeAlplabet,
                                 kbTypeAlplabet,
                                 kbTypeNumber,
                                 kbTypeAlplabet,
                                 kbTypeAlplabet,
                                 kbTypeAlplabet,
                                 kbTypeNumber,
                                 kbTypeAlplabet,
                                 kbTypeNone,
                                 kbTypeNone,
                                 kbTypeNone,
                                 kbTypeNumber,
                                 nil];
    
    masterAddressTextField = [[NSMutableArray alloc]initWithObjects:
                                buildNameField_,
                                roomNoField_,
                                floorNoField_,
                                addressNoField_,
                                soiField_,
                                villageField_,
                                mooNoField_,
                                streetField_,
                                @"",
                                @"",
                                @"",
                                postcodeField_,
                                nil];
    
    //----------------------- TAX DATA -----------------------
    masterTaxTitle = [[NSMutableArray alloc]initWithObjects:
                      [Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"],
                      [Util stringWithScreenName:@"Common" labelName:@"MarryStatus"],
                      [Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"],
                      [Util stringWithScreenName:@"Common" labelName:@"SpouseNid"],
                      [Util stringWithScreenName:@"Common" labelName:@"SpouseName"],
                      [Util stringWithScreenName:@"Common" labelName:@"SpouseSurname"],
                      [Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"],
                      [Util stringWithScreenName:@"Common" labelName:@"SpousePassportId"],
                      [Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"],
                      [Util stringWithScreenName:@"Common" labelName:@"TxpFatherPin"],
                      [Util stringWithScreenName:@"Common" labelName:@"TxpMotherPin"],
                      [Util stringWithScreenName:@"Common" labelName:@"SpouseFatherPin"],
                      [Util stringWithScreenName:@"Common" labelName:@"SpouseMotherPin"],
                      [Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"],
                      [Util stringWithScreenName:@"Common" labelName:@"ChildStudy"],
                      nil];
    
//    masterTaxValue = [[NSMutableArray alloc]initWithObjects:
//                      currentTaxpayerStatus,
//                      currentMarryStatus,
//                      currentSpouseStatus,
//                      [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"spouseNid"]],
//                      [ShareUserDetail retrieveDataWithStringKey:@"spouseName"],
//                      [ShareUserDetail retrieveDataWithStringKey:@"spouseSurname"],
//                      currentSpouseBirthDate,
//                      [ShareUserDetail retrieveDataWithStringKey:@"spousePassportNo"],
//                      [ShareUserDetail retrieveDataWithStringKey:@"spouseCountryCode"],
//                      [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"txpFatherPin"]],
//                      [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"txpMotherPin"]],
//                      [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"spouseFatherPin"]],
//                      [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"spouseMotherPin"]],
//                      [ShareUserDetail retrieveDataWithStringKey:@"childNoStudy"],
//                      [ShareUserDetail retrieveDataWithStringKey:@"childStudy"],
//                      nil];

    masterTaxValue = [[NSMutableArray alloc]initWithObjects:
                      currentTaxpayerStatus,
                      currentMarryStatus,
                      currentSpouseStatus,
                      self.spouseNid,
                      self.spouseName,
                      self.spouseSurname,
                      currentSpouseBirthDate,
                      self.spousePassportId,
                      self.spouseCountry,
                      self.txpFatherPin,
                      self.txpMotherPin,
                      self.spouseMotherPin,
                      self.spouseFatherPin,
                      self.childNoStudy,
                      self.childStudy,
                      nil];
    
    masterTaxPlaceHolder = [[NSMutableArray alloc]initWithObjects:
                            [Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"],
                            [Util stringWithScreenName:@"Common" labelName:@"MarryStatus"],
                            [Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"],
                            [Util stringWithScreenName:@"Common" labelName:@"SpouseNid"],
                            [Util stringWithScreenName:@"Common" labelName:@"SpouseName"],
                            [Util stringWithScreenName:@"Common" labelName:@"SpouseSurname"],
                            [Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"],
                            [Util stringWithScreenName:@"Common" labelName:@"SpousePassportId"],
                            [Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"],
                            [Util stringWithScreenName:@"Common" labelName:@"TxpFatherPin"],
                            [Util stringWithScreenName:@"Common" labelName:@"TxpMotherPin"],
                            [Util stringWithScreenName:@"Common" labelName:@"SpouseFatherPin"],
                            [Util stringWithScreenName:@"Common" labelName:@"SpouseMotherPin"],
                            [Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"],
                            [Util stringWithScreenName:@"Common" labelName:@"ChildStudy"],
                            nil];
    
    masterTaxDisplayType = [[NSMutableArray alloc]initWithObjects:
                            displayTypeDropdown,
                            displayTypeDropdown,
                            displayTypeDropdown,
                            displayTypeTextfield,
                            displayTypeTextfield,
                            displayTypeTextfield,
                            displayTypeDropdownDate,
                            displayTypeTextfield,
                            displayTypeDropdown,
                            displayTypeTextfield,
                            displayTypeTextfield,
                            displayTypeTextfield,
                            displayTypeTextfield,
                            displayTypeTextfield,
                            displayTypeTextfield,
                            nil];
    
    masterTaxKeyboardType = [[NSMutableArray alloc]initWithObjects:
                             kbTypeNone,
                             kbTypeNone,
                             kbTypeNone,
                             kbTypeNumber,
                             kbTypeAlplabet,
                             kbTypeAlplabet,
                             kbTypeNone,
                             kbTypeNumber,
                             kbTypeNone,
                             kbTypeNumber,
                             kbTypeNumber,
                             kbTypeNumber,
                             kbTypeNumber,
                             kbTypeNumber,
                             kbTypeNumber,
                             nil];
    
    masterTaxTextfield = [[NSMutableArray alloc]initWithObjects:
                            @"",
                            @"",
                            @"",
                            spouseNidField_,
                            spouseNameField_,
                            spouseSurnameField_,
                            @"",
                            spousePassportIdField_,
                            @"",
                            txpFatherPinField_,
                            txpMotherPinField_,
                            txpFatherPinField_,
                            txpMotherPinField_,
                            childNoStudyField_,
                            childStudyField_,
                            nil];
    
}

#pragma mark - save login first delegte
- (void) responseENSaveLoginFirstService:(NSData *)data {
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        [ShareUserDetail saveShareUserDetailWithKey:@"loginFirst" text:@"0"];
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
}

#pragma mark - Textfield
-(void)hideKeyboard
{
    if(txtActiveEditing) {
        [txtActiveEditing resignFirstResponder];
    }
}

-(void)textFieldDidBeginEditing:(EtextField *)textField
{
    txtActiveEditing = textField;
}

- (BOOL)textField:(EtextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"]]) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"MiddleName"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Surname"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.surname"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"MobilePhone"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.contractNo"] integerValue]+3) {
            return NO;
        }
        
        if ([string length] == 0) {
            return YES;
        }
        
        if ((range.location == 3) || (range.location == 7))
        {
            NSString *str    = [NSString stringWithFormat:@"%@-",textField.text];
            textField.text   = str;
        }
        
        return YES;
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Email"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.email"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Passport"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.passportNo"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"BuildName"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.buildName"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"RoomNo"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.roomNo"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"FloorNo"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.floorNo"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"AddressNo"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.addressNo"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Soi"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.soi"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Village"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.village"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"MooNo"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.mooNo"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Street"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.street"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Postcode"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.postcode"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseNid"]]) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseNid"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseName"]]) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseName"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseSurname"]]) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseSurname"] integerValue]) {
            return NO;
            
        }
    } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpousePassportId"]]) {
        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spousePassportNo"] integerValue]) {
            return NO;
        }

	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"TxpFatherPin"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.txpFatherPin"] integerValue]+4) {
            return NO;
        }
        
        if ([string length] == 0) {
            return YES;
        }
        
        if ((range.location == 1) || (range.location == 6) || (range.location == 12 || (range.location == 15)))
        {
            NSString *str    = [NSString stringWithFormat:@"%@-",textField.text];
            textField.text   = str;
        }
        
        return YES;
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"TxpMotherPin"]]) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.txpMotherPin"] integerValue]+4) {
            return NO;
        }
        
        if ([string length] == 0) {
            return YES;
        }
        
        if ((range.location == 1) || (range.location == 6) || (range.location == 12 || (range.location == 15)))
        {
            NSString *str    = [NSString stringWithFormat:@"%@-",textField.text];
            textField.text   = str;
        }
        
        return YES;
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseFatherPin"]] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseFatherPin"] integerValue]+4) {
            return NO;
        }
        
        if ([string length] == 0) {
            return YES;
        }
        
        if ((range.location == 1) || (range.location == 6) || (range.location == 12 || (range.location == 15)))
        {
            NSString *str    = [NSString stringWithFormat:@"%@-",textField.text];
            textField.text   = str;
        }
        
        return YES;
        
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseMotherPin"]]) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseMotherPin"] integerValue]+4) {
            return NO;
        }
        
        if ([string length] == 0) {
            return YES;
        }
        
        if ((range.location == 1) || (range.location == 6) || (range.location == 12 || (range.location == 15)))
        {
            NSString *str    = [NSString stringWithFormat:@"%@-",textField.text];
            textField.text   = str;
        }
        
        return YES;
	} else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"]] ) {
        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.childNoStudy"] integerValue]) {
            return NO;
        }

    } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"ChildStudy"]] ) {
        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.childStudy"] integerValue]) {
            return NO;
        }
    }
    return YES;
}

-(void)textFieldDidEndEditing:(EtextField *)textField
{
    txtActiveEditing = nil;
        
        if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"]] ) {
            self.name = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"MiddleName"]] ) {
            self.middleName = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Surname"]] ) {
            self.surname = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"MobilePhone"]] ) {
            self.tel = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Email"]] ) {
            self.email = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Passport"]] ) {
            self.passportId = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"BuildName"]] ) {
            self.buildName = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"RoomNo"]] ) {
            self.roomNo = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"FloorNo"]] ) {
            self.floorNo = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"AddressNo"]] ) {
            self.addressNo = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Soi"]] ) {
            self.soi = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Village"]] ) {
            self.village = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"MooNo"]] ) {
            self.mooNo = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Street"]] ) {
            self.street = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Postcode"]] ) {
            self.postcode = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseNid"]]) {
            self.spouseNid = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseName"]]) {
            self.spouseName = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseSurname"]]) {
            self.spouseSurname = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpousePassportId"]]) {
            self.spousePassportId = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"TxpFatherPin"]]) {
            self.txpFatherPin = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"TxpMotherPin"]]) {
            self.txpMotherPin = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseFatherPin"]]) {
            self.spouseFatherPin = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseMotherPin"]]) {
            self.spouseMotherPin = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"]]) {
            self.childNoStudy = textField.text ;
            
        } else if ( [textField.identify isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"ChildStudy"]]) {
            self.childStudy = textField.text ;
            
        }
}

- (BOOL) validateField {
    
    if ([Util validateEmptyFieldWithString:self.nameTitle] && [generalPermission objectAtIndex:1]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.name] && [generalPermission objectAtIndex:2]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
//    } else if ([Util validateEmptyFieldWithString:self.middleName] && [generalPermission objectAtIndex:3]==Y) {
//        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
//        return NO;
    } else if ([Util validateEmptyFieldWithString:self.surname] && [generalPermission objectAtIndex:4]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.passportId] && [generalPermission objectAtIndex:5]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.country] && [generalPermission objectAtIndex:6]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.tel] && [generalPermission objectAtIndex:7]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.email] && [generalPermission objectAtIndex:8]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
//    } else if ([Util validateEmptyFieldWithString:self.buildName]) {
//        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
//        return NO;
//    } else if ([Util validateEmptyFieldWithString:self.roomNo]) {
//        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
//        return NO;
//    } else if ([Util validateEmptyFieldWithString:self.floorNo]) {
//        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
//        return NO;
    } else if ([Util validateEmptyFieldWithString:self.addressNo]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
//    } else if ([Util validateEmptyFieldWithString:self.soi]) {
//        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
//        return NO;
//    } else if ([Util validateEmptyFieldWithString:self.village]) {
//        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
//        return NO;
//    } else if ([Util validateEmptyFieldWithString:self.mooNo]) {
//        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
//        return NO;
//    } else if ([Util validateEmptyFieldWithString:self.street]) {
//        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
//        return NO;
    } else if ([Util validateEmptyFieldWithString:self.province]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.amphur]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.tambol]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.postcode]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.taxpayerStatus] && [taxPermission objectAtIndex:0]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.marryStatus] && [taxPermission objectAtIndex:1]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseStatus] && [taxPermission objectAtIndex:2]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseNid] && [taxPermission objectAtIndex:3]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseName] && [taxPermission objectAtIndex:4]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseSurname] && [taxPermission objectAtIndex:5]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseBirthDate] && [taxPermission objectAtIndex:6]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spousePassportId] && [taxPermission objectAtIndex:7]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseCountry] && [taxPermission objectAtIndex:8]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.txpFatherPin] && [taxPermission objectAtIndex:9]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.txpMotherPin] && [taxPermission objectAtIndex:10]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseFatherPin] && [taxPermission objectAtIndex:11]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseMotherPin] && [taxPermission objectAtIndex:12]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.childNoStudy] && [taxPermission objectAtIndex:13]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.childStudy] && [taxPermission objectAtIndex:14]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else {
        return YES;
    }
}

- (IBAction)textFieldFinished:(id)sender {
    [sender resignFirstResponder];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //-- Number of rows it should expect should be based on the section
    NSDictionary *dictionary = [dataArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"data"];
    return [array count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel * sectionHeader = [[UILabel alloc] initWithFrame:CGRectZero];
    sectionHeader.backgroundColor = [[UIColor alloc] initWithRed:109.0/255 green:110.0/255 blue:112.0/255.0 alpha:1.0];
    sectionHeader.textAlignment = UITextAlignmentCenter;
    sectionHeader.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    [sectionHeader setTextColor:[UIColor whiteColor]];
    
    if(section == 0)
    {
        sectionHeader.text = [Util stringWithScreenName:@"Profile" labelName:@"GeneralProfile"];
    }
    else if(section == 1)
    {
        sectionHeader.text = [Util stringWithScreenName:@"Profile" labelName:@"Address"];
    }
    else
    {
        sectionHeader.text = [Util stringWithScreenName:@"Profile" labelName:@"ReduceStatus"];
    }
    return sectionHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    EtextField* tf = nil ;
    EtextField* currentTextfield = nil;
    
    //-- TEXTFIELD MODEL
    textFieldModel = [Util loadViewWithNibName:@"TextFieldModel"];
    textFieldModel.frame = CGRectMake(0, 0, 320, 75);
    textFieldModel.layer.masksToBounds = YES;
    textFieldModel.pTxt.delegate = self;
    textFieldModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    textFieldModel.pTxt.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    
    if (indexPath.section == 0) {
        if ([[readyGeneralDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeDropdown]) {
            
            //-- DROPDOWN MODEL
            dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
            dropdownViewModel.pTitle.text = [readyGeneralTitle objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
            dropdownViewModel.pHintButton.hidden = YES;
            NSString *rd = [readyGeneralValue objectAtIndex:indexPath.row];
            if ([Util validateEmptyFieldWithString:rd]) {
                [dropdownViewModel.pDropdownButton setTitle:[readyGeneralValue objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            } else {
                [dropdownViewModel.pDropdownButton setTitle:rd forState:UIControlStateNormal];
            }
            [dropdownViewModel.pDropdownButton setTag:indexPath.row];
            [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
            dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [cell addSubview:dropdownViewModel];
            
        } else if ([[readyGeneralDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeDropdownDate]) {
            
            //-- DROPDOWN MODEL
            dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
            dropdownViewModel.pTitle.text = [readyGeneralTitle objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
            dropdownViewModel.pHintButton.hidden = YES;
            NSString *rd = [readyGeneralValue objectAtIndex:indexPath.row];
            if ([Util validateEmptyFieldWithString:rd]) {
                [dropdownViewModel.pDropdownButton setTitle:[readyGeneralValue objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            } else {
                [dropdownViewModel.pDropdownButton setTitle:rd forState:UIControlStateNormal];
            }
            [dropdownViewModel.pDropdownButton setTag:indexPath.row];
            [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownDatePickerClicked:) forControlEvents:UIControlEventTouchUpInside];
            dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [cell addSubview:dropdownViewModel];
            
        } else if ([[readyGeneralDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeLabel]) {
            
            //-- TEXTFIELD MODEL
            textFieldModel.pTitle.text = [readyGeneralTitle objectAtIndex:indexPath.row];
            textFieldModel.pButton.hidden = YES;
            textFieldModel.pTxt.hidden = YES;
            [textFieldModel addSubview:[FormUtil initLabelWithSubTitleText:[readyGeneralValue objectAtIndex:indexPath.row]]];
            [cell addSubview:textFieldModel];
            
        } else {
            
            //-- TEXTFIELD MODEL
            textFieldModel.pTitle.text = [readyGeneralTitle objectAtIndex:indexPath.row];
            textFieldModel.pTxt.text = [readyGeneralValue objectAtIndex:indexPath.row];
            textFieldModel.pTxt.placeholder = [readyGeneralPlaceHolder objectAtIndex:indexPath.row];
            if ([[readyGeneralKeyboardType objectAtIndex:indexPath.row] isEqualToString:kbTypeEmail]) {
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeEmailAddress;
            } else if ([[readyGeneralKeyboardType objectAtIndex:indexPath.row] isEqualToString:kbTypeNone]) {

            } else if ([[readyGeneralKeyboardType objectAtIndex:indexPath.row] isEqualToString:kbTypeNumber]) {
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
            } else if ([[readyGeneralKeyboardType objectAtIndex:indexPath.row] isEqualToString:kbTypePhone]) {
                textFieldModel.pTxt.keyboardType = UIKeyboardTypePhonePad;
            } else {
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
            }
            textFieldModel.pButton.hidden = YES;
            
            currentTextfield = [readyGeneralTextfield objectAtIndex:indexPath.row];
            tf = currentTextfield = textFieldModel.pTxt;
            tf.tag = indexPath.row;
            tf.identify = [readyGeneralTitle objectAtIndex:indexPath.row];
            [cell addSubview:textFieldModel];
        }
        
    } else if (indexPath.section == 1) {
        
        if ([[masterAddressDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeDropdown]) {
            
            //-- DROPDOWN MODEL
            dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
            dropdownViewModel.pTitle.text = [masterAddressTitle objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
            dropdownViewModel.pHintButton.hidden = YES;
            NSString *ma = [masterAddressValue objectAtIndex:indexPath.row];
            if ([Util validateEmptyFieldWithString:ma]) {
                [dropdownViewModel.pDropdownButton setTitle:[masterAddressTitle objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            } else {
                [dropdownViewModel.pDropdownButton setTitle:ma forState:UIControlStateNormal];
            }
            [dropdownViewModel.pDropdownButton setTag:indexPath.row];
            [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
            dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [cell addSubview:dropdownViewModel];
            
        } else if ([[masterAddressDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeDropdownDate]) {
            
            //-- DROPDOWN MODEL
            dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
            dropdownViewModel.pTitle.text = [masterAddressTitle objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
            dropdownViewModel.pHintButton.hidden = YES;
            NSString *ma = [masterAddressValue objectAtIndex:indexPath.row];
            if ([Util validateEmptyFieldWithString:ma]) {
                [dropdownViewModel.pDropdownButton setTitle:[masterAddressTitle objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            } else {
                [dropdownViewModel.pDropdownButton setTitle:ma forState:UIControlStateNormal];
            }
            
            [dropdownViewModel.pDropdownButton setTag:indexPath.row];
            [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownDatePickerClicked:) forControlEvents:UIControlEventTouchUpInside];
            dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [cell addSubview:dropdownViewModel];
            
        } else if ([[masterAddressDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeLabel]) {
            
            //-- TEXTFIELD MODEL
            textFieldModel.pTitle.text = [masterAddressTitle objectAtIndex:indexPath.row];
            textFieldModel.pButton.hidden = YES;
            textFieldModel.pTxt.hidden = YES;
            [textFieldModel addSubview:[FormUtil initLabelWithSubTitleText:[masterAddressValue objectAtIndex:indexPath.row]]];
            [cell addSubview:textFieldModel];
            
        } else {
            
            //-- TEXTFIELD MODEL
            textFieldModel.pTitle.text = [masterAddressTitle objectAtIndex:indexPath.row];
            textFieldModel.pTxt.text = [masterAddressValue objectAtIndex:indexPath.row];
            textFieldModel.pTxt.placeholder = [masterAddressPlaceHolder objectAtIndex:indexPath.row];
            if ([[masterAddressKeyboardType objectAtIndex:indexPath.row] isEqualToString:kbTypeEmail]) {
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeEmailAddress;
            } else if ([[masterAddressKeyboardType objectAtIndex:indexPath.row] isEqualToString:kbTypeNone]) {
                
            } else if ([[masterAddressKeyboardType objectAtIndex:indexPath.row] isEqualToString:kbTypeNumber]) {
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
            } else if ([[masterAddressKeyboardType objectAtIndex:indexPath.row] isEqualToString:kbTypePhone]) {
                textFieldModel.pTxt.keyboardType = UIKeyboardTypePhonePad;
            } else {
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
            }
            textFieldModel.pButton.hidden = YES;
            
            currentTextfield = [masterAddressTextField objectAtIndex:indexPath.row];
            tf = currentTextfield = textFieldModel.pTxt;
            tf.tag = indexPath.row;
            tf.identify = [masterAddressTitle objectAtIndex:indexPath.row];
            [cell addSubview:textFieldModel];
            
        }
        
    } else {
        
        if ([[readyTaxDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeDropdown]) {
            
            //-- DROPDOWN MODEL
            dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
            dropdownViewModel.pTitle.text = [readyTaxTitle objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
            dropdownViewModel.pHintButton.hidden = YES;
            if ([[readyTaxTitle objectAtIndex:indexPath.row] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"]]) {
                NSString *tps = [ShareUserDetail retrieveDataWithStringKey:[NSString stringWithFormat:@"%@%@", @"taxpayerHash",[readyTaxValue objectAtIndex:indexPath.row]]];
                if ([Util validateEmptyFieldWithString:tps]) {
                    [dropdownViewModel.pDropdownButton setTitle:[readyTaxPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                } else {
                    [dropdownViewModel.pDropdownButton setTitle:tps forState:UIControlStateNormal];
                }
            } else if ([[readyTaxTitle objectAtIndex:indexPath.row] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"]]) {
                NSString *ss = [ShareUserDetail retrieveDataWithStringKey:[NSString stringWithFormat:@"%@%@", @"spouseHash",[readyTaxValue objectAtIndex:indexPath.row]]];
                if ([Util validateEmptyFieldWithString:ss]) {
                    [dropdownViewModel.pDropdownButton setTitle:[readyTaxPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                } else {
                    [dropdownViewModel.pDropdownButton setTitle:ss forState:UIControlStateNormal];
                }
            } else if ([[readyTaxTitle objectAtIndex:indexPath.row] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"]]) {
                NSString *sc = [readyTaxValue objectAtIndex:indexPath.row];
                if ([Util validateEmptyFieldWithString:sc]) {
                    [dropdownViewModel.pDropdownButton setTitle:[readyTaxPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                } else {
                    [dropdownViewModel.pDropdownButton setTitle:sc forState:UIControlStateNormal];
                }
            } else {
                NSString *mh = [ShareUserDetail retrieveDataWithStringKey:[NSString stringWithFormat:@"%@%@", @"marryHash",[readyTaxValue objectAtIndex:indexPath.row]]];
                if ([Util validateEmptyFieldWithString:mh]) {
                    [dropdownViewModel.pDropdownButton setTitle:[readyTaxPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                } else {
                    [dropdownViewModel.pDropdownButton setTitle:mh forState:UIControlStateNormal];
                }
            }
            [dropdownViewModel.pDropdownButton setTag:indexPath.row];
            [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
            dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [cell addSubview:dropdownViewModel];
            
        } else if ([[readyTaxDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeDropdownDate]) {
            
            //-- DROPDOWN MODEL
            dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
            dropdownViewModel.pTitle.text = [readyTaxTitle objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
            dropdownViewModel.pHintButton.hidden = YES;
            if ([Util validateEmptyFieldWithString:[readyTaxValue objectAtIndex:indexPath.row]]) {
                [dropdownViewModel.pDropdownButton setTitle:[readyTaxPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            } else {
                [dropdownViewModel.pDropdownButton setTitle:[readyTaxValue objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            }
            [dropdownViewModel.pDropdownButton setTag:indexPath.row];
            [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownDatePickerClicked:) forControlEvents:UIControlEventTouchUpInside];
            dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [cell addSubview:dropdownViewModel];
            
        } else if ([[readyTaxDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeLabel]) {
            
            //-- TEXTFIELD MODEL
            textFieldModel.pTitle.text = [readyTaxTitle objectAtIndex:indexPath.row];
            textFieldModel.pButton.hidden = YES;
            textFieldModel.pTxt.hidden = YES;
            [textFieldModel addSubview:[FormUtil initLabelWithSubTitleText:[readyTaxValue objectAtIndex:indexPath.row]]];
            [cell addSubview:textFieldModel];
            
        } else {
            
            //-- TEXTFIELD MODEL
            textFieldModel.pTitle.text = [readyTaxTitle objectAtIndex:indexPath.row];
            textFieldModel.pTxt.text = [readyTaxValue objectAtIndex:indexPath.row];
            textFieldModel.pTxt.placeholder = [readyTaxPlaceHolder objectAtIndex:indexPath.row];
            if ([[readyTaxKeyboardType objectAtIndex:indexPath.row] isEqualToString:kbTypeEmail]) {
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeEmailAddress;
            } else if ([[readyTaxKeyboardType objectAtIndex:indexPath.row] isEqualToString:kbTypeNone]) {
                
            } else if ([[readyTaxKeyboardType objectAtIndex:indexPath.row] isEqualToString:kbTypeNumber]) {
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
            } else if ([[readyTaxKeyboardType objectAtIndex:indexPath.row] isEqualToString:kbTypePhone]) {
                textFieldModel.pTxt.keyboardType = UIKeyboardTypePhonePad;
            } else {
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
            }
            textFieldModel.pButton.hidden = YES;
            
            currentTextfield = [readyTaxTextfield objectAtIndex:indexPath.row];
            tf = currentTextfield = textFieldModel.pTxt;
            tf.tag = indexPath.row;
            tf.identify = [readyTaxTitle objectAtIndex:indexPath.row];
            [cell addSubview:textFieldModel];
        }
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    [tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    tf.delegate = self ;
    
    return cell;
}


#pragma mark - Dropdown
-(IBAction)dropdownClicked:(id)sender
{
    UIButton *button = (UIButton*) sender;
    currentButton = button;
    [self showDropDownViewWithTag:currentButton.tag Delegate:self];
}

-(void)showDropDownViewWithTag:(NSInteger)tag Delegate:(id)delegate

{
    dropDownActionSheet = [[UIActionSheet alloc] init];
    dropDownActionSheet.tag = tag;
    
    dropDownPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    dropDownPickerView.showsSelectionIndicator = YES;
    dropDownPickerView.dataSource = delegate;
    dropDownPickerView.delegate = delegate;
    
    if ([[readyGeneralTitle objectAtIndex:tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"NameTitle"]]) {
        dropDownPickerView.tag = tag;
    } else if ([[masterAddressTitle objectAtIndex:tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Province"]]) {
        dropDownPickerView.tag = tag;
    } else if ([[masterAddressTitle objectAtIndex:tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Amphur"]]) {
        dropDownPickerView.tag = tag;
    } else if ([[masterAddressTitle objectAtIndex:tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Tambol"]]) {
        dropDownPickerView.tag = tag;
    } else if ([[readyTaxTitle objectAtIndex:tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"]]) {
        dropDownPickerView.tag = tag;
        [dropDownPickerView selectRow:[[readyTaxValue objectAtIndex:tag] integerValue] inComponent:0 animated:NO];
    } else if ([[readyTaxTitle objectAtIndex:tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"]]) {
        dropDownPickerView.tag = tag;
        [dropDownPickerView selectRow:[[readyTaxValue objectAtIndex:tag] integerValue] inComponent:0 animated:NO];
    } else if ([[readyGeneralTitle objectAtIndex:tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Country"]]) {
        dropDownPickerView.tag = tag;
    } else if ([[readyTaxTitle objectAtIndex:tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"]]) {
        dropDownPickerView.tag = tag;
    } else if ([[readyTaxTitle objectAtIndex:tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"]]) {
        dropDownPickerView.tag = tag;
    } else {
        dropDownPickerView.tag = tag;
        [dropDownPickerView selectRow:[[readyTaxValue objectAtIndex:tag] integerValue] inComponent:0 animated:NO];
    }
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    [toolBar sizeToFit];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Cancel"] style:UIBarButtonItemStyleBordered target:delegate action:@selector(cancel_clicked:)];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Done"] style:UIBarButtonItemStyleBordered target:delegate action:@selector(done_clicked:)];
    
    doneBtn.tag = tag;
    
    NSArray *barItems = @[doneBtn, flexSpace, cancelBtn];
    
    [toolBar setItems:barItems animated:YES];
    
    [dropDownActionSheet addSubview:toolBar];
    [dropDownActionSheet addSubview:dropDownPickerView];
    
    [dropDownActionSheet showInView:self.view];
    [dropDownActionSheet setBounds:CGRectMake(0, 0, self.view.frame.size.width, 464)];
    
}

-(void)cancel_clicked:(UIBarButtonItem *)item;
{
    [dropDownActionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)done_clicked:(UIBarButtonItem *)item;
{
    if ([[readyGeneralTitle objectAtIndex:item.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"NameTitle"]]) {
        
    } else if ([[masterAddressTitle objectAtIndex:item.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Province"]]) {
        
    } else if ([[masterAddressTitle objectAtIndex:item.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Amphur"]]) {
        
    } else if ([[masterAddressTitle objectAtIndex:item.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Tambol"]]) {
        
    } else if ([[readyTaxTitle objectAtIndex:item.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"]]) {
        [currentButton setTitle:[ddTaxpayerHashArray objectAtIndex:[dropDownPickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
        [self setNewTaxPayerStatusSourceToTableView];
        
    } else if ([[readyTaxTitle objectAtIndex:item.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"]]) {
        [currentButton setTitle:[ddSpouseHashArray objectAtIndex:[dropDownPickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
        [self setNewSpouseStatusSourceToTableView];
        
    } else if ([[readyTaxTitle objectAtIndex:item.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"]]) {
        [currentButton setTitle:[dateFormatter stringFromDate:dropDownDatePickerView.date] forState:UIControlStateNormal];
        [self setNewSpouseBirthDateSourceToTableView];
    
    } else if ([[readyGeneralTitle objectAtIndex:item.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Country"]]) {
        
    } else if ([[readyTaxTitle objectAtIndex:item.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"]]) {
        
    } else {
        [currentButton setTitle:[ddMarryHashArray objectAtIndex:[dropDownPickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
        [self setNewMarryStatusSourceToTableView];
    }
    
    [dropDownActionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([[readyGeneralTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"NameTitle"]]) {
        return [ddNameTitleNameHashArray count];
    } else if ([[masterAddressTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Province"]]) {
        return 0;
    } else if ([[masterAddressTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Amphur"]]) {
        return 0;
    } else if ([[masterAddressTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Tambol"]]) {
        return 0;
    } else if ([[readyTaxTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"]]) {
        return [ddTaxpayerHashArray count];
    } else if ([[readyTaxTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"]]) {
        return [ddSpouseHashArray count];
    } else if ([[readyGeneralTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Country"]]) {
        return 0;
    } else if ([[readyTaxTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"]]) {
        return 0;
    } else if ([[readyTaxTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"]]) {
        return 0;
    } else {
        return [ddMarryHashArray count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([[readyGeneralTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"NameTitle"]]) {
        return [ddNameTitleNameHashArray objectAtIndex:row];
    } else if ([[masterAddressTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Province"]]) {
        return @"";
    } else if ([[masterAddressTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Amphur"]]) {
        return @"";
    } else if ([[masterAddressTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Tambol"]]) {
        return @"";
    } else if ([[readyTaxTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"]]) {
        return [ddTaxpayerHashArray objectAtIndex:row];
    } else if ([[readyTaxTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"]]) {
        return [ddSpouseHashArray objectAtIndex:row];
    } else if ([[readyGeneralTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Country"]]) {
        return @"";
    } else if ([[readyTaxTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"]]) {
        return @"";
    } else if ([[readyTaxTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"]]) {
        return @"";
    } else {
        return [ddMarryHashArray objectAtIndex:row];
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if ([[readyGeneralTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"NameTitle"]]) {
        [currentButton setTitle:[ddNameTitleNameHashArray objectAtIndex:row] forState:UIControlStateNormal];
    } else if ([[masterAddressTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Province"]]) {
        [currentButton setTitle:@"" forState:UIControlStateNormal];
    } else if ([[masterAddressTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Amphur"]]) {
        [currentButton setTitle:@"" forState:UIControlStateNormal];
    } else if ([[masterAddressTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Tambol"]]) {
        [currentButton setTitle:@"" forState:UIControlStateNormal];
    } else if ([[readyTaxTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"]]) {
        [currentButton setTitle:[ddTaxpayerHashArray objectAtIndex:row] forState:UIControlStateNormal];
    } else if ([[readyTaxTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"]]) {
        [currentButton setTitle:[ddSpouseHashArray objectAtIndex:row] forState:UIControlStateNormal];
    } else if ([[readyGeneralTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Country"]]) {
        [currentButton setTitle:@"" forState:UIControlStateNormal];
    } else if ([[readyTaxTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"]]) {
        [currentButton setTitle:@"" forState:UIControlStateNormal];
    } else if ([[readyTaxTitle objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"]]) {
        [currentButton setTitle:@"" forState:UIControlStateNormal];
    } else {
        [currentButton setTitle:[ddMarryHashArray objectAtIndex:row] forState:UIControlStateNormal];
    }
    
}

#pragma mark - Dropdown Date picker
-(IBAction)dropdownDatePickerClicked:(id)sender
{
    UIButton *button = (UIButton*) sender;
    currentButton = button;
    [self showDropDownDatePickerViewWithTag:currentButton.tag Delegate:self];
}

-(void)showDropDownDatePickerViewWithTag:(NSInteger)tag Delegate:(id)delegate

{
    dropDownActionSheet = [[UIActionSheet alloc] init];
    dropDownActionSheet.tag = tag;
    if([[readyTaxTitle objectAtIndex:tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"]])
    {
        
        // set default date 01/01/yyyy
        NSDateFormatter *formatterYear = [[NSDateFormatter alloc] init];
        [formatterYear setDateFormat:@"yyyy"];
        NSString *yearString = [formatterYear stringFromDate:[NSDate date]];
        NSString *defaulDateStr= [NSString stringWithFormat:@"%@%@",@"01/01/",yearString];
        
        NSDateFormatter *formatterDefault = [[NSDateFormatter alloc] init];
        NSDate *defaulDate = [[NSDate alloc] init];
        [formatterDefault setDateFormat:@"dd/MM/yyyy"];
        defaulDate = [formatterDefault dateFromString:defaulDateStr];
        
        
        // set max date
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *todayDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:todayDate options:0];
        dropDownDatePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
        dropDownDatePickerView.datePickerMode = UIDatePickerModeDate;
        NSLocale *locale = currentLocale;
        dropDownDatePickerView.locale = locale;
        dropDownDatePickerView.calendar = [locale objectForKey:NSLocaleCalendar];
        [dropDownDatePickerView setDate:defaulDate];
        [dropDownDatePickerView setMaximumDate:maxDate];// set max date today

        
    }
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    [toolBar sizeToFit];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Cancel"] style:UIBarButtonItemStyleBordered target:delegate action:@selector(cancel_clicked:)];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Done"] style:UIBarButtonItemStyleBordered target:delegate action:@selector(done_clicked:)];
    
    doneBtn.tag = tag;
    
    NSArray *barItems = @[doneBtn, flexSpace, cancelBtn];
    
    [toolBar setItems:barItems animated:YES];
    
    [dropDownActionSheet addSubview:toolBar];
    [dropDownActionSheet addSubview:dropDownDatePickerView];
    
    [dropDownActionSheet showInView:self.view];
    [dropDownActionSheet setBounds:CGRectMake(0, 0, self.view.frame.size.width, 464)];
    
}

- (void)dateChanged {
    [currentButton setTitle:[dateFormatter stringFromDate:dropDownDatePickerView.date] forState:UIControlStateNormal];
}


#pragma mark - Check
- (void) removeAllMasterData {
    [masterGeneralTitle removeAllObjects];
    [masterGeneralValue removeAllObjects];
    [masterGeneralPlaceHolder removeAllObjects];
    [masterGeneralKeyboardType removeAllObjects];
    [masterGeneralDisplayType removeAllObjects];
    [masterGeneralTextField removeAllObjects];
    
    [masterAddressTitle removeAllObjects];
    [masterAddressValue removeAllObjects];
    [masterAddressPlaceHolder removeAllObjects];
    [masterAddressKeyboardType removeAllObjects];
    [masterAddressDisplayType removeAllObjects];
    [masterAddressTextField removeAllObjects];
    
    [masterTaxTitle removeAllObjects];
    [masterTaxValue removeAllObjects];
    [masterTaxPlaceHolder removeAllObjects];
    [masterTaxKeyboardType removeAllObjects];
    [masterTaxDisplayType removeAllObjects];
    [masterTaxTextfield removeAllObjects];
}

- (NSString *) checkCurrentTaxpayerStatus : (NSString *) text {
    if ([text isEqualToString:[ShareUserDetail retrieveDataWithStringKey:@"taxpayerHash0"]]) {
        return @"0";
    } else if ([text isEqualToString:[ShareUserDetail retrieveDataWithStringKey:@"taxpayerHash1"]]) {
        return @"1";
    } else if ([text isEqualToString:[ShareUserDetail retrieveDataWithStringKey:@"taxpayerHash2"]]) {
        return @"2";
    } else {
        return @"3";
    }
}

- (NSString *) checkCurrentSpouseStatus : (NSString *) text {
    if ([text isEqualToString:[ShareUserDetail retrieveDataWithStringKey:@"spouseHash0"]]) {
        return @"0";
    } else {
        return @"1";
    }
}

- (NSString *) checkCurrentMarryStatus : (NSString *) text {
    if ([text isEqualToString:[ShareUserDetail retrieveDataWithStringKey:@"marryHash0"]]) {
        return @"0";
    } else if ([text isEqualToString:[ShareUserDetail retrieveDataWithStringKey:@"marryHash1"]]) {
        return @"1";
    } else if ([text isEqualToString:[ShareUserDetail retrieveDataWithStringKey:@"marryHash2"]]) {
        return @"2";
    } else {
        return @"3";
    }
}

- (void) setNewTaxPayerStatusSourceToTableView {
    
    //-- Set new data to array
    currentTaxpayerStatus = [self checkCurrentTaxpayerStatus:currentButton.currentTitle];
    
    [self removeAllMasterData];
    [self initMasterData];
    
    self.taxpayerStatus = currentButton.currentTitle;
    taxPermission = [self getTaxPermission];
    //-- set ready data
    [self setTaxReadyDataWithPermission:taxPermission];
    
    [dataArray removeAllObjects];
    [self setTableViewState];
    [self.tableView reloadData];
}

- (void) setNewSpouseStatusSourceToTableView {
    
    //-- Set new data to array
    currentSpouseStatus = [self checkCurrentSpouseStatus:currentButton.currentTitle];
    
    [self removeAllMasterData];
    [self initMasterData];
    
    self.spouseStatus = currentButton.currentTitle;
    taxPermission = [self getTaxPermission];
    //-- set ready data
    [self setTaxReadyDataWithPermission:taxPermission];
    
    [dataArray removeAllObjects];
    [self setTableViewState];
    [self.tableView reloadData];
}

- (void) setNewMarryStatusSourceToTableView {
    
    //-- Set new data to array
    currentMarryStatus = [self checkCurrentMarryStatus:currentButton.currentTitle];
    
    [self removeAllMasterData];
    [self initMasterData];
    
    self.marryStatus = currentButton.currentTitle;
    taxPermission = [self getTaxPermission];
    //-- set ready data
    [self setTaxReadyDataWithPermission:taxPermission];
    
    [dataArray removeAllObjects];
    [self setTableViewState];
    [self.tableView reloadData];
}

- (void) setNewSpouseBirthDateSourceToTableView {
    currentSpouseBirthDate = currentButton.currentTitle;
    
    [self removeAllMasterData];
    [self initMasterData];
    self.spouseBirthDate = currentButton.currentTitle;
    taxPermission = [self getTaxPermission];
    //-- set ready data
    [self setTaxReadyDataWithPermission:taxPermission];
    
    [dataArray removeAllObjects];
    [self setTableViewState];
    [self.tableView reloadData];
}

#pragma mark - call service
- (void) onSaveButtonClicked :(UIButton*)button {
    
    if ([self validateField]) {
        [self callUpdateProfileService];
    }
    
}

- (void) callUpdateProfileService {
    
    enUpdateProfileService = [[ENUpdateProfileService alloc]init];
    enUpdateProfileService.delegate = self;
    
    [enUpdateProfileService requestENUpdateProfileServiceWithNid:[ShareUserDetail retrieveDataWithStringKey:@"nid"]
                                                        version :[Util loadAppSettingWithName:@"Version"]
                                                       authenKey:[ShareUserDetail retrieveDataWithStringKey:@"authenKey"]
                                                            name:self.name
                                                         surname:self.surname
                                                            tel :self.tel
                                                          email :self.email
                                                     passportId :self.passportId
                                                        country :self.country
                                                       buildName:self.buildName
                                                          roomNo:self.roomNo
                                                         floorNo:self.floorNo
                                                       addressNo:self.addressNo
                                                             soi:self.soi
                                                         village:self.village
                                                           mooNo:self.mooNo
                                                          street:self.street
                                                          tambol:self.tambol
                                                          amphur:self.amphur
                                                        province:self.province
                                                        postCode:self.postcode
                                                  taxpayerStatus:currentTaxpayerStatus
                                                    spouseStatus:currentSpouseStatus
                                                     marryStatus:currentMarryStatus
                                                       spouseNid:self.spouseNid
                                                      spouseName:self.spouseName
                                                   spouseSurname:self.spouseSurname
                                                spouseBirthDate :self.spouseBirthDate
                                               spousePassportId :self.spousePassportId
                                                  spouseCountry :self.spouseCountry
                                                    childNoStudy:self.childNoStudy
                                                      childStudy:self.childStudy
                                                    txpFatherPin:self.txpFatherPin
                                                    txpMotherPin:self.txpMotherPin
                                                 spouseFatherPin:self.spouseFatherPin
                                                 spouseMotherPin:self.spouseMotherPin];

}

#pragma mark - Response Delegate
- (void) responseENUpdateProfileService:(NSData *)data {
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        
        [self alertResultWithTitle:@"" detail:[Util stringWithScreenName:@"Common" labelName:@"Success"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        
    }  else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
}

- (IBAction)next:(id)sender {
    [self onSaveButtonClicked:sender];
}

#pragma mark - Alert with condition
- (void) alertResultWithTitle : (NSString *)title detail:(NSString *)detail yes:(NSString *)yes {
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:title];
    [alert setMessage:detail];
    [alert setDelegate:self];
    [alert addButtonWithTitle:yes];
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        NSArray *viewControllers = [[self navigationController] viewControllers];
        for( int i=0;i<[viewControllers count];i++){
            id obj=[viewControllers objectAtIndex:i];
            if([obj isKindOfClass:[EfilingUserProfileViewController class]]){
                [[self navigationController] popToViewController:obj animated:YES];
                return;
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
