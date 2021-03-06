//
//  EfilingPersonalProfileViewController.m
//  RDSmartTax
//
//  Created by fone on 12/22/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingPersonalProfileViewController.h"
#import "EfilingHomeViewController.h"

#import "TextFieldModel.h"
#import "DropdownViewModel.h"
#import "ButtonModel.h"
#import "CustomTemplateModel.h"
#import "EcheckBox.h"

#import "FontUtil.h"
#import "Util.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"
#import "JLString.h"
#import "TextFormatterUtil.h"

@interface EfilingPersonalProfileViewController () {
    NSIndexPath *currentIndexPath;
    NSMutableDictionary *indexPathDic;
    //--view
    CGPoint    m_originalRootView;
    CGRect     m_scrollViewFrame;
    
    //-- master val
    NSMutableArray *masterGeneralTitle;
    NSMutableArray *masterGeneralValue;
    NSMutableArray *masterGeneralPlaceHolder;
    NSMutableArray *masterGeneralKeyboardType;
    NSMutableArray *masterGeneralDisplayType;
    NSMutableArray *masterGeneralTextField;
    NSMutableArray *masterGeneralIdentity;
    
    NSMutableArray *masterAddressTitle;
    NSMutableArray *masterAddressValue;
    NSMutableArray *masterAddressPlaceHolder;
    NSMutableArray *masterAddressKeyboardType;
    NSMutableArray *masterAddressDisplayType;
    NSMutableArray *masterAddressTextField;
    NSMutableArray *masterAddressIdentity;
    
    NSMutableArray *masterTaxTitle;
    NSMutableArray *masterTaxValue;
    NSMutableArray *masterTaxPlaceHolder;
    NSMutableArray *masterTaxKeyboardType;
    NSMutableArray *masterTaxDisplayType;
    NSMutableArray *masterTaxTextfield;
    NSMutableArray *masterTaxIdentity;
    
    //-- current data
    int currentRule;
    NSString *currentCountryIndex;
    NSString *currentSpouseCountryIndex;
    NSString *currentThaiNation;
    NSString *currentTaxpayerStatus;
    NSString *currentSpouseStatus;
    NSString *currentMarryStatus;
    NSString *currentSpouseBirthDate;
    NSString *currentProvinceIndex;
    NSString *currentAmphurIndex;
    NSString *currentTambolIndex;
    NSLocale *currentLocale;
    NSDateFormatter* dateFormatter;
    NSString *isCurrentCustomTemplate;
    NSString *spouseBirthDateToService;
    
    NSMutableArray *ddTaxpayerHashArray;
    NSMutableArray *ddSpouseHashArray;
    NSMutableArray *ddMarryHashArray;
    NSMutableArray *ddCountryNameArray;
    NSMutableArray *ddCountryCodeArray;

    //-- provine amphur tambol
    NSMutableArray *ddProvinceId;
    NSMutableArray *ddProvinceName;
    NSMutableArray *ddAmphurId;
    NSMutableArray *ddAmphurName;
    NSMutableArray *ddTambolId;
    NSMutableArray *ddTambolName;
    NSMutableArray *ddTambol;
    
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
    NSMutableArray *readyGeneralIdentity;
    
    NSMutableArray *readyTaxTitle;
    NSMutableArray *readyTaxValue;
    NSMutableArray *readyTaxPlaceHolder;
    NSMutableArray *readyTaxKeyboardType;
    NSMutableArray *readyTaxDisplayType;
    NSMutableArray *readyTaxTextfield;
    NSMutableArray *readyTaxIdentity;
    NSMutableArray *customTemplateArray;
    
    //-- model
    TextFieldModel *textFieldModel;
    DropdownViewModel *dropdownViewModel;
    ButtonModel *buttonModel;
    CustomTemplateModel *customTemplateModel;
    
    //-- dropdown
    UIPickerView *dropDownPickerView;
    UIActionSheet *dropDownActionSheet;
    EcheckBox *currentButton;
    
    UIDatePicker *dropDownDatePickerView;
    
    NSDictionary *readyGeneralDic;
    NSDictionary *masterAddressDic;
    NSDictionary *readyTaxDic;
    NSDictionary *customTemplateDic;
    
    NSMutableDictionary *dataDropdown;
    
    NSMutableArray *arrayETextField;
    
    int currentSection;
    int currentIndex;
    NSString *isTF;
    
}

@end

@implementation EfilingPersonalProfileViewController

@synthesize enUpdateProfileService;
@synthesize enGetAmphur;
@synthesize enGetProvince;

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    // kb - remember original location root view --------------------------
    m_originalRootView = self.view.frame.origin;
    
    // kb - remember original frame -----------------------
    m_scrollViewFrame = self.scrollView.frame;
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([Util isInternetConnect]) {
        //-- get province
//        enGetProvince = [[ENGetProvince alloc]init];
//        enGetProvince.delegate = self;
//        [enGetProvince requestENGetProvince];
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
    }
    
    //-- set button label
    [buttonModel.pButton setTitle:[Util stringWithScreenName:@"Common" labelName:@"Save"] forState:UIControlStateNormal];
}

#pragma mark - KeyBoard Delegate
// kb -
-(void)keyBoardWasShown:(NSNotification*)aNotification{
    
    NSDictionary* keyboardInfo = [aNotification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardRect = [keyboardFrameBegin CGRectValue];
    CGFloat frameMargin = 0;
    CGPoint focusTextPoint = [txtActiveEditing convertPoint:txtActiveEditing.bounds.origin toView:nil];
    CGFloat textfieldHeight = focusTextPoint.y + txtActiveEditing.bounds.size.height;
    CGFloat windowHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    if((windowHeight - textfieldHeight) < keyboardRect.size.height )
    {
        frameMargin = (keyboardRect.size.height - (windowHeight - textfieldHeight)) + 10;
        
        if(frameMargin < 0){
            frameMargin = 0;
        }
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame= CGRectMake(self.view.frame.origin.x,
                                    self.view.frame.origin.y - frameMargin,
                                    self.view.frame.size.width,
                                    self.view.frame.size.height);
    }];
}
//- Called when The UIKeyboardWillHideNotification is sent
-(void)keyboardWillBeHidden:(NSNotification *)aNotification{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(m_originalRootView.x,
                                     m_originalRootView.y,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }];
    if (txtActiveEditing) {
        [txtActiveEditing resignFirstResponder];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    indexPathDic = [[NSMutableDictionary alloc]init];

    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    //-- add footer
    buttonModel = [Util loadViewWithNibName:@"ButtonModel"];
    [buttonModel.pButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [buttonModel.pButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    self.tableView.tableFooterView = buttonModel;
    
    ddProvinceId = [[NSMutableArray alloc]init];
    ddProvinceName = [[NSMutableArray alloc]init];
    ddAmphurId = [[NSMutableArray alloc]init];
    ddAmphurName = [[NSMutableArray alloc]init];
    ddTambolId = [[NSMutableArray alloc]init];
    ddTambolName = [[NSMutableArray alloc]init];
    ddTambol = [[NSMutableArray alloc]init];
    
    arrayETextField = [[NSMutableArray alloc]init];
    
    dataDropdown = [[NSMutableDictionary alloc]init];
    //-- set table view
    
    
    self.navigationController.navigationBar.hidden = YES;
    //-- Header
    self.header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.font = [FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold];
    self.header.pLabel.text = [Util stringWithScreenName:@"Profile" labelName:@"ProfileTitle"];
    [self.header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.header.pRightButton.hidden = YES;
    [self.pHeaderView addSubview:self.header];
    
    //-- init data
    Y = [NSNumber numberWithBool:YES];
    N = [NSNumber numberWithBool:NO];
    
    //-- set current
    currentThaiNation = [ShareUserDetail retrieveDataWithStringKey:@"thaiNation"];
    currentTaxpayerStatus = [ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"];
    currentSpouseStatus = [ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"];
    currentMarryStatus = [ShareUserDetail retrieveDataWithStringKey:@"marryStatus"];
    currentSpouseBirthDate = [Util convertYearToBackSlashWithStringDate:[ShareUserDetail retrieveDataWithStringKey:@"spouseBirthDate"]];
    
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
    [self initFirstVariable];
    [self initTextfield];
    [self initMasterData];
    
    //-- Initialize the dataArray
    dataArray = [[NSMutableArray alloc] init];
    
    //-- init dropdown
    [self initDropdownData];
    
    //-- init country dd
    for (int i = 0; i<[ddCountryCodeArray count]; i++) {

        if ([[NSString stringWithFormat:@"%@", [ddCountryCodeArray objectAtIndex:i]] isEqualToString:[ShareUserDetail retrieveDataWithStringKey:@"countryCode"]]) {
            currentCountryIndex = [NSString stringWithFormat:@"%d",i];
        } else {
            currentCountryIndex = [NSString stringWithFormat:@"%d",0];
        }
    }
    for (int j = 0; j<[ddCountryCodeArray count]; j++) {
        if ([[NSString stringWithFormat:@"%@", [ddCountryCodeArray objectAtIndex:j]] isEqualToString:[ShareUserDetail retrieveDataWithStringKey:@"spouseCountryCode"]]) {
            currentSpouseCountryIndex = [NSString stringWithFormat:@"%d",j];
        } else {
            currentSpouseCountryIndex = [NSString stringWithFormat:@"%d",0];
        }
    }
    
    //-- get general permission
    readyGeneralTitle = [[NSMutableArray alloc]init];
    readyGeneralValue = [[NSMutableArray alloc]init];
    readyGeneralPlaceHolder = [[NSMutableArray alloc]init];
    readyGeneralKeyboardType = [[NSMutableArray alloc]init];
    readyGeneralDisplayType = [[NSMutableArray alloc]init];
    readyGeneralTextfield = [[NSMutableArray alloc]init];
    readyGeneralIdentity = [[NSMutableArray alloc]init];
    generalPermission = [self getGeneralPermission];
    [self setGeneralReadyDataWithPermission:generalPermission];
    
    //-- get tax permission
    readyTaxTitle = [[NSMutableArray alloc]init];
    readyTaxValue = [[NSMutableArray alloc]init];
    readyTaxPlaceHolder = [[NSMutableArray alloc]init];
    readyTaxKeyboardType = [[NSMutableArray alloc]init];
    readyTaxDisplayType = [[NSMutableArray alloc]init];
    readyTaxTextfield = [[NSMutableArray alloc]init];
    readyTaxIdentity = [[NSMutableArray alloc]init];
    taxPermission = [self getTaxPermission];
    [self setTaxReadyDataWithPermission:taxPermission];
    
    //-- init custom template
    customTemplateArray = [[NSMutableArray alloc]initWithObjects:@"", nil];
    
    //-- set state
    [self setTableViewSection];
    
    
    //-- kb - Add Tap Gesture -----------------------------------------------------
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardWillBeHidden:)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    
    //-- kb - Keyboard Notification -----------------------------------------------
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (NSLocale *) checkLocale {
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        return [[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"];
    } else {
        return [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    }
}

#pragma mark - ready data
- (void) setTableViewSection {
    readyGeneralDic = [NSDictionary dictionaryWithObject:readyGeneralTitle forKey:@"data"];
    [dataArray addObject:readyGeneralDic];
    masterAddressDic = [NSDictionary dictionaryWithObject:masterAddressTitle forKey:@"data"];
    [dataArray addObject:masterAddressDic];
    readyTaxDic = [NSDictionary dictionaryWithObject:readyTaxTitle forKey:@"data"];
    [dataArray addObject:readyTaxDic];
    
    //-- custom template
    customTemplateDic = [NSDictionary dictionaryWithObject:customTemplateArray forKey:@"data"];
    [dataArray addObject:customTemplateDic];
}
- (void) setGeneralReadyDataWithPermission : (NSMutableArray *) permiss {
    
    for (int i = 0; i < [permiss count];i++) {
        if ([permiss objectAtIndex:i]==Y) {
            [readyGeneralTitle addObject:[masterGeneralTitle objectAtIndex:i]];
            [readyGeneralValue addObject:[masterGeneralValue objectAtIndex:i]];
            [readyGeneralPlaceHolder addObject:[masterGeneralPlaceHolder objectAtIndex:i]];
            [readyGeneralKeyboardType addObject:[masterGeneralKeyboardType objectAtIndex:i]];
            [readyGeneralDisplayType addObject:[masterGeneralDisplayType objectAtIndex:i]];
            [readyGeneralTextfield addObject:[masterGeneralTextField objectAtIndex:i]];
            [readyGeneralIdentity addObject:[masterGeneralIdentity objectAtIndex:i]];
        }
    }
    
}

- (void) setTaxReadyDataWithPermission : (NSMutableArray *) permiss {
    
    for (int i = 0; i < [permiss count];i++) {
        if ([permiss objectAtIndex:i]==Y) {
            [readyTaxTitle addObject:[masterTaxTitle objectAtIndex:i]];
            [readyTaxValue addObject:[masterTaxValue objectAtIndex:i]];
            [readyTaxPlaceHolder addObject:[masterTaxPlaceHolder objectAtIndex:i]];
            [readyTaxKeyboardType addObject:[masterTaxKeyboardType objectAtIndex:i]];
            [readyTaxDisplayType addObject:[masterTaxDisplayType objectAtIndex:i]];
            [readyTaxTextfield addObject:[masterTaxTextfield objectAtIndex:i]];
            [readyTaxIdentity addObject:[masterTaxIdentity objectAtIndex:i]];
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
- (void) logAllValue {
    NSLog(@"\n\n-------START LOG----------\n\n");
    NSLog(@"nid > %@",self.nid);
    NSLog(@"nameTitle > %@",self.nameTitle);
    NSLog(@"name > %@",self.name);
    NSLog(@"middleName > %@",self.middleName);
    NSLog(@"surname > %@",self.surname);
    NSLog(@"tel > %@",self.tel);
    NSLog(@"email > %@",self.email);
    NSLog(@"country > %@",currentCountryIndex);
    NSLog(@"passportId > %@",self.passportId);
    
    NSLog(@"buildName > %@",self.buildName);
    NSLog(@"roomNo > %@",self.roomNo);
    NSLog(@"floorNo > %@",self.floorNo);
    NSLog(@"addressNo > %@",self.addressNo);
    NSLog(@"soi > %@",self.soi);
    NSLog(@"village > %@",self.village);
    NSLog(@"mooNo > %@",self.mooNo);
    NSLog(@"street > %@",self.street);
    NSLog(@"tambol > %@",self.tambol);
    NSLog(@"amphur > %@",self.amphur);
    NSLog(@"province > %@",self.province);
    NSLog(@"postcode > %@",self.postcode);
    
    NSLog(@"taxpayerStatus > %@",currentTaxpayerStatus);
    
    NSLog(@"marryStatus > %@",currentMarryStatus);
    
    NSLog(@"spouseStatus > %@",currentSpouseStatus);
    
    NSLog(@"spouseNid > %@",self.spouseNid);
    NSLog(@"spouseName > %@",self.spouseName);
    NSLog(@"spouseSurname > %@",self.spouseSurname);
    NSLog(@"spouseBirthDate > %@",spouseBirthDateToService);
    NSLog(@"spousePassportId > %@",self.spousePassportId);
    NSLog(@"spouseCountry > %@",currentSpouseCountryIndex);
    NSLog(@"txpFatherPin > %@",self.txpFatherPin);
    NSLog(@"txpMotherPin > %@",self.txpMotherPin);
    NSLog(@"spouseFatherPin > %@",self.spouseFatherPin);
    NSLog(@"spouseMotherPin > %@",self.spouseMotherPin);
    NSLog(@"childNoStudy > %@",self.childNoStudy);
    NSLog(@"childStudy > %@",self.childStudy);
    NSLog(@"\n\n--------END LOG---------\n\n");
}
#pragma mark - MASTER DATA
- (void) initFirstVariable {
    
    //-- get current custom template
    isCurrentCustomTemplate = @"Y"; // in phase 2 if you get custom template flag, replace that data to this val
    
    //-- general
    self.nid = [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"nid"]];
    self.nameTitle = [ShareUserDetail retrieveDataWithStringKey:@"titleName"];
    
//    self.nid = [TextFormatterUtil formatIdCard:@"1809900273568"];
//    self.nameTitle = @"นางสาว";
    
    self.name = [ShareUserDetail retrieveDataWithStringKey:@"name"];
    self.middleName = [ShareUserDetail retrieveDataWithStringKey:@"middleName"];
    self.surname = [ShareUserDetail retrieveDataWithStringKey:@"surname"];
    self.tel = [TextFormatterUtil formatHomeNo:[ShareUserDetail retrieveDataWithStringKey:@"contractNo"]];
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
    self.spouseBirthDate = currentSpouseBirthDate;
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
    
    ddTaxpayerHashArray = [[NSMutableArray alloc]initWithObjects:[ShareUserDetail retrieveDataWithStringKey:@"taxpayerHash0"],
                           [ShareUserDetail retrieveDataWithStringKey:@"taxpayerHash1"],
                           [ShareUserDetail retrieveDataWithStringKey:@"taxpayerHash2"],
                           [ShareUserDetail retrieveDataWithStringKey:@"taxpayerHash3"],nil];
    
    ddSpouseHashArray = [[NSMutableArray alloc]initWithObjects:[ShareUserDetail retrieveDataWithStringKey:@"spouseHash0"],
                         [ShareUserDetail retrieveDataWithStringKey:@"spouseHash1"],nil];
    
    ddMarryHashArray = [[NSMutableArray alloc]initWithObjects:[ShareUserDetail retrieveDataWithStringKey:@"marryHash0"],
                        [ShareUserDetail retrieveDataWithStringKey:@"marryHash1"],
                        [ShareUserDetail retrieveDataWithStringKey:@"marryHash2"],
                        [ShareUserDetail retrieveDataWithStringKey:@"marryHash3"], nil];
    
    ddCountryCodeArray = [[NSMutableArray alloc]init];
    ddCountryNameArray = [[NSMutableArray alloc]init];
    [self getCountryNameList];
}

#pragma mark - country name list
-(void)getCountryNameList{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"country" ofType:@"json"];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    NSDictionary *countryDic = [dic objectForKey:@"country_name"];
    
    NSEnumerator *enumerator = [countryDic objectEnumerator];
    id object;
    while (object = [enumerator nextObject]) {
        [ddCountryCodeArray addObject:[object objectForKey:@"COUNTRY_CODE"]];
        if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
            [ddCountryNameArray addObject:[object objectForKey:@"THAI_NAME"]];
        } else {
            [ddCountryNameArray addObject:[object objectForKey:@"ENG_NAME"]];
        }
    }
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
    
    masterGeneralValue = [[NSMutableArray alloc]initWithObjects:
                          self.nid,
                          self.nameTitle,
                          self.name,
                          self.middleName,
                          self.surname,
                          self.passportId,
                          self.country,
                          self.tel,
                          self.email,
                          nil];
    
    masterGeneralPlaceHolder = [[NSMutableArray alloc]initWithObjects:
                                @"",
                                @"",
                                [Util loadPlaceholder:@"name"],
                                [Util loadPlaceholder:@"middleName"],
                                [Util loadPlaceholder:@"surname"],
                                [Util loadPlaceholder:@"passportNo"],
                                [Util loadPlaceholder:@"countryCode"],
                                [Util loadPlaceholder:@"contractNo"],
                                [Util loadPlaceholder:@"email"],
                                nil];
    
    masterGeneralDisplayType = [[NSMutableArray alloc]initWithObjects:
                                displayTypeLabel,
                                displayTypeLabel,
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
    
    masterGeneralIdentity = [[NSMutableArray alloc]initWithObjects:
                             @"nid",
                             @"titleName",
                             @"name",
                             @"middleName",
                             @"surname",
                             @"passportNo",
                             @"countryCode",
                             @"contractNo",
                             @"email",
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
                                [Util loadPlaceholder:@"buildName"],
                                [Util loadPlaceholder:@"roomNo"],
                                [Util loadPlaceholder:@"floorNo"],
                                [Util loadPlaceholder:@"addressNo"],
                                [Util loadPlaceholder:@"soi"],
                                [Util loadPlaceholder:@"village"],
                                [Util loadPlaceholder:@"mooNo"],
                                [Util loadPlaceholder:@"street"],
                                [Util loadPlaceholder:@"province"],
                                [Util loadPlaceholder:@"amphur"],
                                [Util loadPlaceholder:@"tambol"],
                                [Util loadPlaceholder:@"postcode"],
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
                                 kbTypeAlplabet,
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
    
    masterAddressIdentity = [[NSMutableArray alloc]initWithObjects:
                             @"buildName",
                             @"roomNo",
                             @"floorNo",
                             @"addressNo",
                             @"soi",
                             @"village",
                             @"mooNo",
                             @"street",
                             @"province",
                             @"amphur",
                             @"tambol",
                             @"postcode",
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
                      self.spouseFatherPin,
                      self.spouseMotherPin,
                      self.childNoStudy,
                      self.childStudy,
                      nil];
    
    masterTaxPlaceHolder = [[NSMutableArray alloc]initWithObjects:
                            [Util loadPlaceholder:@"taxpayerStatus"],
                            [Util loadPlaceholder:@"marryStatus"],
                            [Util loadPlaceholder:@"spouseStatus"],
                            [Util loadPlaceholder:@"spouseNid"],
                            [Util loadPlaceholder:@"spouseName"],
                            [Util loadPlaceholder:@"spouseSurname"],
                            [Util loadPlaceholder:@"spouseBirthDate"],
                            [Util loadPlaceholder:@"spousePassportNo"],
                            [Util loadPlaceholder:@"spouseCountryCode"],
                            [Util loadPlaceholder:@"txpFatherPin"],
                            [Util loadPlaceholder:@"txpMotherPin"],
                            [Util loadPlaceholder:@"spouseFatherPin"],
                            [Util loadPlaceholder:@"spouseMotherPin"],
                            [Util loadPlaceholder:@"childNoStudy"],
                            [Util loadPlaceholder:@"childStudy"],
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
    
    masterTaxIdentity = [[NSMutableArray alloc]initWithObjects:
                         @"taxpayerStatus",
                         @"marryStatus",
                         @"spouseStatus",
                         @"spouseNid",
                         @"spouseName",
                         @"spouseSurname",
                         @"spouseBirthDate",
                         @"spousePassportId",
                         @"spouseCountry",
                         @"txpFatherPin",
                         @"txpMotherPin",
                         @"spouseFatherPin",
                         @"spouseMotherPin",
                         @"childNoStudy",
                         @"childStudy",
                         nil];
}

#pragma mark - save login first delegte
- (void) responseENSaveLoginFirstService:(NSDictionary *)data {
    NSDictionary *dic = data;
    
    if ([[dic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        [ShareUserDetail saveShareUserDetailWithKey:@"loginFirst" text:@"0"];
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseMessage"]];
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
    
    if ( [textField.identify isEqualToString:@"name"]) {
        
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"middleName"] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.middleName"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"surname"] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.surname"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"contractNo"] ) {
        
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.mobileNo"] integerValue]+2) {
            return NO;
        }
        
        if ([string length] == 0) {
            return YES;
        }
        
        if ((range.location == 2) || (range.location == 7))
        {
            NSString *str    = [NSString stringWithFormat:@"%@-",textField.text];
            textField.text   = str;
        }
        
        return YES;
        
	} else if ( [textField.identify isEqualToString:@"email"] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.email"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"passportNo"] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.passportNo"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"buildName"] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.buildName"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"roomNo"] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.roomNo"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"floorNo"] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.floorNo"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"addressNo"] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.addressNo"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"soi"] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.soi"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"village"] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.village"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"mooNo"] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.mooNo"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"street"] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.street"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"postcode"] ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.postcode"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"spouseNid"]) {
        
//        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseNid"] integerValue]) {
        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseNid"] integerValue]+4) {
            return NO;
        }
        
        if ([string length] == 0) {
            return YES;
        }
        
        if ((range.location == 1) || (range.location == 6) || (range.location == 12 || (range.location == 15))) {
            NSString *str    = [NSString stringWithFormat:@"%@-",textField.text];
            textField.text   = str;
        }
        
        return YES;
        
	} else if ( [textField.identify isEqualToString:@"spouseName"]) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseName"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"spouseSurname"]) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseSurname"] integerValue]) {
            return NO;
            
        }
    } else if ( [textField.identify isEqualToString:@"spousePassportId"]) {
        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spousePassportNo"] integerValue]) {
            return NO;
        }
        
	} else if ( [textField.identify isEqualToString:@"txpFatherPin"] ) {
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
        
	} else if ( [textField.identify isEqualToString:@"txpMotherPin"]) {
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
        
	} else if ( [textField.identify isEqualToString:@"spouseFatherPin"] ) {
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
        
	} else if ( [textField.identify isEqualToString:@"spouseMotherPin"]) {
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
	} else if ( [textField.identify isEqualToString:@"childNoStudy"] ) {
        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.childNoStudy"] integerValue]) {
            return NO;
        }
        
    } else if ( [textField.identify isEqualToString:@"childStudy"] ) {
        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.childStudy"] integerValue]) {
            return NO;
        }
    }
    return YES;
}

-(void)textFieldDidEndEditing:(EtextField *)textField
{
    txtActiveEditing = nil;
    
    if ( [textField.identify isEqualToString:@"name"] ) {
        self.name = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"middleName"] ) {
        self.middleName = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"surname"] ) {
        self.surname = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"contractNo"] ) {
        self.tel = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"email"] ) {
        self.email = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"passportNo"] ) {
        self.passportId = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"buildName"] ) {
        self.buildName = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"roomNo"] ) {
        self.roomNo = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"floorNo"] ) {
        self.floorNo = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"addressNo"] ) {
        self.addressNo = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"soi"] ) {
        self.soi = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"village"] ) {
        self.village = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"mooNo"] ) {
        self.mooNo = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"street"] ) {
        self.street = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"postcode"] ) {
        self.postcode = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"spouseNid"]) {
        self.spouseNid = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"spouseName"]) {
        self.spouseName = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"spouseSurname"]) {
        self.spouseSurname = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"spousePassportId"]) {
        self.spousePassportId = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"txpFatherPin"]) {
        self.txpFatherPin = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"txpMotherPin"]) {
        self.txpMotherPin = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"spouseFatherPin"]) {
        self.spouseFatherPin = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"spouseMotherPin"]) {
        self.spouseMotherPin = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"childNoStudy"]) {
        self.childNoStudy = textField.text ;
        
    } else if ( [textField.identify isEqualToString:@"childStudy"]) {
        self.childStudy = textField.text ;
        
    }
    
    [self removeAllMasterData];
    [self initMasterData];
    
    generalPermission = [self getGeneralPermission];
    [self setGeneralReadyDataWithPermission:generalPermission];
    
    taxPermission = [self getTaxPermission];
    [self setTaxReadyDataWithPermission:taxPermission];
}

#pragma mark - alert
- (void) alertUtilWithTitle : (NSString *) title msg : (NSString *) msg {
    UIAlertView *tryMeAlertview = [[UIAlertView alloc] initWithTitle: title
                                                             message: msg
                                                            delegate: self
                                                   cancelButtonTitle: [Util stringWithScreenName:@"Common" labelName:@"Ok"]
                                                   otherButtonTitles: nil];
    
    [tryMeAlertview show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        //--focus
        isTF = @"Y";
        
        //---------- general --------------------------------------------
        if ([Util validateEmptyFieldWithString:self.name] && [generalPermission objectAtIndex:2]==Y) {
            [self becomeFirstResponderTextFieldWithIdentify:@"name" section:@"0"];
            
        } else if ([Util validateEmptyFieldWithString:self.surname] && [generalPermission objectAtIndex:4]==Y) {
            [self becomeFirstResponderTextFieldWithIdentify:@"surname" section:@"0"];
            
        } else if ([Util validateEmptyFieldWithString:self.passportId] && [generalPermission objectAtIndex:5]==Y) {
            [self becomeFirstResponderTextFieldWithIdentify:@"passportNo" section:@"0"];

        } else if ([Util validateEmptyFieldWithString:self.country] && [generalPermission objectAtIndex:6]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"countryCode" section:@"0"];
            isTF = @"N";
            
        } else if ([Util validateEmptyFieldWithString:self.tel] && [generalPermission objectAtIndex:7]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"contractNo" section:@"0"];

            
        } else if ([Util validateContractNumberWithString:self.tel] && [generalPermission objectAtIndex:7]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"contractNo" section:@"0"];

            
        } else if ([Util validateEmptyFieldWithString:self.email] && [generalPermission objectAtIndex:8]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"email" section:@"0"];

            
        } else if (![Util validateEmail:self.email] && [generalPermission objectAtIndex:8]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"email" section:@"0"];

            
            //---------- address --------------------------------------------
        } else if ([Util validateEmptyFieldWithString:self.addressNo]) {

            [self becomeFirstResponderTextFieldWithIdentify:@"addressNo" section:@"1"];

            
        } else if ([Util validateEmptyFieldWithString:self.province]) {

            [self becomeFirstResponderTextFieldWithIdentify:@"province" section:@"1"];
            isTF = @"N";

            
        } else if ([Util validateEmptyFieldWithString:self.amphur]) {

            [self becomeFirstResponderTextFieldWithIdentify:@"amphur" section:@"1"];
            isTF = @"N";

            
        } else if ([Util validateEmptyFieldWithString:self.tambol]) {

            [self becomeFirstResponderTextFieldWithIdentify:@"tambol" section:@"1"];
            isTF = @"N";

            
        } else if ([Util validateEmptyFieldWithString:self.postcode]) {

            [self becomeFirstResponderTextFieldWithIdentify:@"postcode" section:@"1"];

            
            //---------- tax --------------------------------------------
        } else if ([Util validateEmptyFieldWithString:self.taxpayerStatus] && [taxPermission objectAtIndex:0]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"taxpayerStatus" section:@"2"];
            isTF = @"N";

            
        } else if ([Util validateEmptyFieldWithString:self.marryStatus] && [taxPermission objectAtIndex:1]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"marryStatus" section:@"2"];
            isTF = @"N";

            
        } else if ([Util validateEmptyFieldWithString:self.spouseStatus] && [taxPermission objectAtIndex:2]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"spouseStatus" section:@"2"];
            isTF = @"N";

            
        } else if ([Util validateEmptyFieldWithString:self.spouseNid] && [taxPermission objectAtIndex:3]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"spouseNid" section:@"2"];

            
        } else if ([Util validateIDCardWithString:self.spouseNid] && [taxPermission objectAtIndex:3]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"spouseNid" section:@"2"];

            
        } else if ([Util validateEmptyFieldWithString:self.spouseName] && [taxPermission objectAtIndex:4]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"spouseName" section:@"2"];

            
        } else if ([Util validateEmptyFieldWithString:self.spouseSurname] && [taxPermission objectAtIndex:5]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"spouseSurname" section:@"2"];

            
        } else if ([Util validateEmptyFieldWithString:self.spouseBirthDate] && [taxPermission objectAtIndex:6]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"spouseBirthDate" section:@"2"];
            isTF = @"N";

            
        } else if ([Util validateEmptyFieldWithString:self.spousePassportId] && [taxPermission objectAtIndex:7]==Y) {

            [self becomeFirstResponderTextFieldWithIdentify:@"spousePassportId" section:@"2"];
            
        } else if ([Util validateEmptyFieldWithString:self.spouseCountry] && [taxPermission objectAtIndex:8]==Y) {
  
            [self becomeFirstResponderTextFieldWithIdentify:@"spouseCountry" section:@"2"];
            isTF = @"N";

            
        } else if ([Util validateEmptyFieldWithString:self.txpFatherPin] && [taxPermission objectAtIndex:9]==Y) {
  
            [self becomeFirstResponderTextFieldWithIdentify:@"txpFatherPin" section:@"2"];
  
            
        } else if ([Util validateIDCardWithString:self.txpFatherPin] && [taxPermission objectAtIndex:9]==Y) {
  
            [self becomeFirstResponderTextFieldWithIdentify:@"txpFatherPin" section:@"2"];
  
            
        } else if ([Util validateEmptyFieldWithString:self.txpMotherPin] && [taxPermission objectAtIndex:10]==Y) {
  
            [self becomeFirstResponderTextFieldWithIdentify:@"txpMotherPin" section:@"2"];
  
            
        } else if ([Util validateIDCardWithString:self.txpMotherPin] && [taxPermission objectAtIndex:10]==Y) {
  
            [self becomeFirstResponderTextFieldWithIdentify:@"txpMotherPin" section:@"2"];
  
            
        } else if ([Util validateEmptyFieldWithString:self.spouseFatherPin] && [taxPermission objectAtIndex:11]==Y) {
  
            [self becomeFirstResponderTextFieldWithIdentify:@"spouseFatherPin" section:@"2"];
  
            
        } else if ([Util validateIDCardWithString:self.spouseFatherPin] && [taxPermission objectAtIndex:11]==Y) {
  
            [self becomeFirstResponderTextFieldWithIdentify:@"spouseFatherPin" section:@"2"];
  
            
        } else if ([Util validateEmptyFieldWithString:self.spouseMotherPin] && [taxPermission objectAtIndex:12]==Y) {
  
            [self becomeFirstResponderTextFieldWithIdentify:@"spouseMotherPin" section:@"2"];
  
            
        } else if ([Util validateIDCardWithString:self.spouseMotherPin] && [taxPermission objectAtIndex:12]==Y) {
  
            [self becomeFirstResponderTextFieldWithIdentify:@"spouseMotherPin" section:@"2"];
  
            
        } else if ([Util validateEmptyFieldWithString:self.childNoStudy] && [taxPermission objectAtIndex:13]==Y) {
  
            [self becomeFirstResponderTextFieldWithIdentify:@"childNoStudy" section:@"2"];
  
            
        } else if ([Util validateEmptyFieldWithString:self.childStudy] && [taxPermission objectAtIndex:14]==Y) {
  
            [self becomeFirstResponderTextFieldWithIdentify:@"childStudy" section:@"2"];
  
            
        }
    }
}

#pragma mark - FOCUS
- (void) becomeFirstResponderTextFieldWithIdentify : (NSString *) identify section:(NSString *)section {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[[indexPathDic objectForKey:identify] intValue] inSection:[section intValue]];
    currentSection = [section intValue];
    currentIndex = [[indexPathDic objectForKey:identify] intValue];

    [self.tableView scrollToRowAtIndexPath:indexPath
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:YES];

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentIndex inSection:currentSection];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    if ([isTF isEqualToString:@"Y"]) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            UIView *view = [cell.subviews objectAtIndex:0];
            TextFieldModel *contentview = [view.subviews objectAtIndex:1];
            
            EtextField *tempEText;
            tempEText = contentview.pTxt;
            
            [tempEText becomeFirstResponder];
            
        } else {
            TextFieldModel *contentview = [cell.subviews objectAtIndex:1];
            
            EtextField *tempEText;
            tempEText = contentview.pTxt;
            
            [tempEText becomeFirstResponder];
            
        }
    }
}
/*
#pragma mark - validateField
- (BOOL) validateField {
    
    //---------- general --------------------------------------------
    if ([Util validateEmptyFieldWithString:self.name] && [generalPermission objectAtIndex:2]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"nameEmpty"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.surname] && [generalPermission objectAtIndex:4]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"surnameEmpty"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.passportId] && [generalPermission objectAtIndex:5]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"passportNoEmpty"]];

        return NO;

    } else if ([Util validateEmptyFieldWithString:self.country] && [generalPermission objectAtIndex:6]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"countryCodeEmpty"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.tel] && [generalPermission objectAtIndex:7]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"contractNoEmpty"]];

        return NO;
    
    } else if ([Util validateContractNumberWithString:self.tel] && [generalPermission objectAtIndex:7]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"contractNoWrong"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.email] && [generalPermission objectAtIndex:8]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"emailEmpty"]];

        return NO;
        
    } else if (![Util validateEmail:self.email] && [generalPermission objectAtIndex:8]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"emailWrong"]];

        return NO;
        
    //---------- address --------------------------------------------
    } else if ([Util validateEmptyFieldWithString:self.addressNo]) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"addressNoEmpty"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.province]) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"provinceEmpty"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.amphur]) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"amphurEmpty"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.tambol]) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"tambolEmpty"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.postcode]) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"postcodeEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"postcode" section:@"1"];
        return NO;
    
    //---------- tax --------------------------------------------
    } else if ([Util validateEmptyFieldWithString:self.taxpayerStatus] && [taxPermission objectAtIndex:0]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"taxpayerStatusEmpty"]];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.marryStatus] && [taxPermission objectAtIndex:1]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"marryStatusEmpty"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseStatus] && [taxPermission objectAtIndex:2]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseStatusEmpty"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseNid] && [taxPermission objectAtIndex:3]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseNidEmpty"]];

        return NO;
    
    } else if ([Util validateIDCardWithString:self.spouseNid] && [taxPermission objectAtIndex:3]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseNidWrong"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseName] && [taxPermission objectAtIndex:4]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseNameEmpty"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseSurname] && [taxPermission objectAtIndex:5]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseSurnameEmpty"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseBirthDate] && [taxPermission objectAtIndex:6]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseBirthDateEmpty"]];


        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spousePassportId] && [taxPermission objectAtIndex:7]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spousePassportNoEmpty"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseCountry] && [taxPermission objectAtIndex:8]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseCountryCodeEmpty"]];


        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.txpFatherPin] && [taxPermission objectAtIndex:9]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"txpFatherPinEmpty"]];

        return NO;
        
    } else if ([Util validateIDCardWithString:self.txpFatherPin] && [taxPermission objectAtIndex:9]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"txpFatherPinWrong"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.txpMotherPin] && [taxPermission objectAtIndex:10]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"txpMotherPinEmpty"]];

        return NO;
        
    } else if ([Util validateIDCardWithString:self.txpMotherPin] && [taxPermission objectAtIndex:10]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"txpMotherPinWrong"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseFatherPin] && [taxPermission objectAtIndex:11]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseFatherPinEmpty"]];

        return NO;
      
    } else if ([Util validateIDCardWithString:self.spouseFatherPin] && [taxPermission objectAtIndex:11]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseFatherPinWrong"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseMotherPin] && [taxPermission objectAtIndex:12]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseMotherPinEmpty"]];

        return NO;
        
    } else if ([Util validateIDCardWithString:self.spouseMotherPin] && [taxPermission objectAtIndex:12]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseMotherPinWrong"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.childNoStudy] && [taxPermission objectAtIndex:13]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"childNoStudyEmpty"]];

        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.childStudy] && [taxPermission objectAtIndex:14]==Y) {
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"childStudyEmpty"]];

        return NO;
        
    } else {
        
        return YES;
    }

}
 */

#pragma mark - validateField
- (BOOL) validateField {
    
    //--focus
    isTF = @"Y";
    
    //---------- general --------------------------------------------
    if ([Util validateEmptyFieldWithString:self.name] && [generalPermission objectAtIndex:2]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"nameEmpty"]];
        //--focus
        [self becomeFirstResponderTextFieldWithIdentify:@"name" section:@"0"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.surname] && [generalPermission objectAtIndex:4]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"surnameEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"surname" section:@"0"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.passportId] && [generalPermission objectAtIndex:5]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"passportNoEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"passportNo" section:@"0"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.country] && [generalPermission objectAtIndex:6]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"countryCodeEmpty"]];
        //--focus
        [self becomeFirstResponderTextFieldWithIdentify:@"countryCode" section:@"0"];
        isTF = @"N";
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.tel] && [generalPermission objectAtIndex:7]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"contractNoEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"contractNo" section:@"0"];
        return NO;
        
    } else if ([Util validateContractNumberWithString:self.tel] && [generalPermission objectAtIndex:7]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"contractNoWrong"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"contractNo" section:@"0"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.email] && [generalPermission objectAtIndex:8]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"emailEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"email" section:@"0"];
        return NO;
        
    } else if (![Util validateEmail:self.email] && [generalPermission objectAtIndex:8]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"emailWrong"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"email" section:@"0"];
        return NO;
        
        //---------- address --------------------------------------------
    } else if ([Util validateEmptyFieldWithString:self.addressNo]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"addressNoEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"addressNo" section:@"1"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.province]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"provinceEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"province" section:@"1"];
        isTF = @"N";
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.amphur]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"amphurEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"amphur" section:@"1"];
        isTF = @"N";
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.tambol]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"tambolEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"tambol" section:@"1"];
        isTF = @"N";
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.postcode]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"postcodeEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"postcode" section:@"1"];
        return NO;
        
        //---------- tax --------------------------------------------
    } else if ([Util validateEmptyFieldWithString:self.taxpayerStatus] && [taxPermission objectAtIndex:0]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"taxpayerStatusEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"taxpayerStatus" section:@"2"];
        isTF = @"N";
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.marryStatus] && [taxPermission objectAtIndex:1]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"marryStatusEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"marryStatus" section:@"2"];
        isTF = @"N";
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseStatus] && [taxPermission objectAtIndex:2]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseStatusEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"spouseStatus" section:@"2"];
        isTF = @"N";
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseNid] && [taxPermission objectAtIndex:3]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseNidEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"spouseNid" section:@"2"];
        return NO;
        
    } else if ([Util validateIDCardWithString:self.spouseNid] && [taxPermission objectAtIndex:3]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseNidWrong"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"spouseNid" section:@"2"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseName] && [taxPermission objectAtIndex:4]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseNameEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"spouseName" section:@"2"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseSurname] && [taxPermission objectAtIndex:5]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseSurnameEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"spouseSurname" section:@"2"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseBirthDate] && [taxPermission objectAtIndex:6]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseBirthDateEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"spouseBirthDate" section:@"2"];
        isTF = @"N";
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spousePassportId] && [taxPermission objectAtIndex:7]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spousePassportNoEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"spousePassportId" section:@"2"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseCountry] && [taxPermission objectAtIndex:8]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseCountryCodeEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"spouseCountry" section:@"2"];
        isTF = @"N";
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.txpFatherPin] && [taxPermission objectAtIndex:9]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"txpFatherPinEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"txpFatherPin" section:@"2"];
        return NO;
        
    } else if ([Util validateIDCardWithString:self.txpFatherPin] && [taxPermission objectAtIndex:9]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"txpFatherPinWrong"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"txpFatherPin" section:@"2"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.txpMotherPin] && [taxPermission objectAtIndex:10]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"txpMotherPinEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"txpMotherPin" section:@"2"];
        return NO;
        
    } else if ([Util validateIDCardWithString:self.txpMotherPin] && [taxPermission objectAtIndex:10]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"txpMotherPinWrong"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"txpMotherPin" section:@"2"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseFatherPin] && [taxPermission objectAtIndex:11]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseFatherPinEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"spouseFatherPin" section:@"2"];
        return NO;
        
    } else if ([Util validateIDCardWithString:self.spouseFatherPin] && [taxPermission objectAtIndex:11]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseFatherPinWrong"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"spouseFatherPin" section:@"2"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.spouseMotherPin] && [taxPermission objectAtIndex:12]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseMotherPinEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"spouseMotherPin" section:@"2"];
        return NO;
        
    } else if ([Util validateIDCardWithString:self.spouseMotherPin] && [taxPermission objectAtIndex:12]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"spouseMotherPinWrong"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"spouseMotherPin" section:@"2"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.childNoStudy] && [taxPermission objectAtIndex:13]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"childNoStudyEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"childNoStudy" section:@"2"];
        return NO;
        
    } else if ([Util validateEmptyFieldWithString:self.childStudy] && [taxPermission objectAtIndex:14]==Y) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"childStudyEmpty"]];
        [self becomeFirstResponderTextFieldWithIdentify:@"childStudy" section:@"2"];
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
    return 90;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel * sectionHeader = [[UILabel alloc] initWithFrame:CGRectZero];
    sectionHeader.backgroundColor = [[UIColor alloc] initWithRed:109.0/255 green:110.0/255 blue:112.0/255.0 alpha:1.0];
    sectionHeader.textAlignment = UITextAlignmentCenter;
    sectionHeader.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    [sectionHeader setTextColor:[UIColor whiteColor]];
    
    if(section == 0) {
        sectionHeader.text = [Util stringWithScreenName:@"Profile" labelName:@"GeneralProfile"];
    }
    else if(section == 1) {
        sectionHeader.text = [Util stringWithScreenName:@"Profile" labelName:@"Address"];
    }
    else if(section == 2) {
        sectionHeader.text = [Util stringWithScreenName:@"Profile" labelName:@"ReduceStatus"];
    }
    else {
        sectionHeader.text = [Util stringWithScreenName:@"Profile" labelName:@"TemplateTitle"];
    }
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = indexPath.row;
    
    EtextField* tf = nil ;
    EtextField* currentTextfield = nil;
    
    //-- TEXTFIELD MODEL
    textFieldModel = [Util loadViewWithNibName:@"TextFieldModel"];
    textFieldModel.layer.masksToBounds = YES;
    textFieldModel.pTxt.delegate = self;
    textFieldModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal];
    textFieldModel.pTxt.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    
    if (indexPath.section == 0) {
        
        //-- focus
        [indexPathDic setObject:[NSString stringWithFormat:@"%d", indexPath.row] forKey:[readyGeneralIdentity objectAtIndex:indexPath.row]];
        
        if ([[readyGeneralDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeDropdown]) {
            
            //-- DROPDOWN MODEL
            dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
            dropdownViewModel.pDropdownButton.identify = [readyGeneralIdentity objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.text = [readyGeneralTitle objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal];
            dropdownViewModel.pHintButton.hidden = YES;
            NSString *rd = [readyGeneralValue objectAtIndex:indexPath.row];
            if ([Util validateEmptyFieldWithString:[NSString stringWithFormat:@"%@",rd]]) {
                [dropdownViewModel.pDropdownButton setTitle:[readyGeneralPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            } else {
                [dropdownViewModel.pDropdownButton setTitle:[NSString stringWithFormat:@"%@",rd] forState:UIControlStateNormal];
            }
            
            [dropdownViewModel.pDropdownButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
            
            
            [dropdownViewModel.pDropdownButton setTag:indexPath.row];
            [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
            dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            
            [cell addSubview:dropdownViewModel];
            
        } else if ([[readyGeneralDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeDropdownDate]) {
            
            //-- DROPDOWN MODEL
            dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
            dropdownViewModel.pDropdownButton.identify = [readyGeneralIdentity objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.text = [readyGeneralTitle objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal];
            dropdownViewModel.pHintButton.hidden = YES;
            NSString *rd = [readyGeneralValue objectAtIndex:indexPath.row];
            if ([Util validateEmptyFieldWithString:[NSString stringWithFormat:@"%@",rd]]) {
                [dropdownViewModel.pDropdownButton setTitle:[readyGeneralPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            } else {
                [dropdownViewModel.pDropdownButton setTitle:[NSString stringWithFormat:@"%@",rd] forState:UIControlStateNormal];
            }
            [dropdownViewModel.pDropdownButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
            [dropdownViewModel.pDropdownButton setTag:indexPath.row];
            [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownDatePickerClicked:) forControlEvents:UIControlEventTouchUpInside];
            dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [cell addSubview:dropdownViewModel];
            
        } else if ([[readyGeneralDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeLabel]) {
            
            //-- TEXTFIELD MODEL
            textFieldModel.pTitle.text = [readyGeneralTitle objectAtIndex:indexPath.row];
            textFieldModel.pButton.hidden = YES;
            textFieldModel.pTxt.hidden = YES;
            textFieldModel.pTextfieldLine.hidden = NO;
            textFieldModel.pTxt.identify = [readyGeneralIdentity objectAtIndex:indexPath.row];
            
            [textFieldModel addSubview:[FormUtil initLabelWithSubTitleText:[readyGeneralValue objectAtIndex:indexPath.row]]];
            [cell addSubview:textFieldModel];
            
        } else {
            
            //-- TEXTFIELD MODEL
            textFieldModel.pTxt.tag = indexPath.row;
            textFieldModel.pTxt.identify = [readyGeneralIdentity objectAtIndex:indexPath.row];
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
//                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
            }
            textFieldModel.pButton.hidden = YES;
            
            currentTextfield = [readyGeneralTextfield objectAtIndex:indexPath.row];
            tf = currentTextfield = textFieldModel.pTxt;
            tf.tag = indexPath.row;
            tf.identify = [readyGeneralIdentity objectAtIndex:indexPath.row];
            [arrayETextField addObject:tf];
        
            [cell addSubview:textFieldModel];
        }
        
    } else if (indexPath.section == 1) {
        
        [indexPathDic setObject:[NSString stringWithFormat:@"%d", indexPath.row] forKey:[masterAddressIdentity objectAtIndex:indexPath.row]];
        
        if ([[masterAddressDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeDropdown]) {
            
            //-- DROPDOWN MODEL
            dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
            dropdownViewModel.pDropdownButton.identify = [masterAddressIdentity objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.text = [masterAddressTitle objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal];
            dropdownViewModel.pHintButton.hidden = YES;
            NSString *ma = [masterAddressValue objectAtIndex:indexPath.row];
            if ([Util validateEmptyFieldWithString:[NSString stringWithFormat:@"%@",ma]]) {
                [dropdownViewModel.pDropdownButton setTitle:[masterAddressPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            } else {
                [dropdownViewModel.pDropdownButton setTitle:[NSString stringWithFormat:@"%@",ma] forState:UIControlStateNormal];
            }
            [dropdownViewModel.pDropdownButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
            [dropdownViewModel.pDropdownButton setTag:indexPath.row];
            [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
            dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [cell addSubview:dropdownViewModel];
            
        } else if ([[masterAddressDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeDropdownDate]) {
            
            //-- DROPDOWN MODEL
            dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
            dropdownViewModel.pDropdownButton.identify = [masterAddressIdentity objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.text = [masterAddressTitle objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal];
            dropdownViewModel.pHintButton.hidden = YES;
            NSString *ma = [masterAddressValue objectAtIndex:indexPath.row];
            if ([Util validateEmptyFieldWithString:[NSString stringWithFormat:@"%@",ma]]) {
                [dropdownViewModel.pDropdownButton setTitle:[masterAddressPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            } else {
                [dropdownViewModel.pDropdownButton setTitle:[NSString stringWithFormat:@"%@",ma] forState:UIControlStateNormal];
            }
            [dropdownViewModel.pDropdownButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
            [dropdownViewModel.pDropdownButton setTag:indexPath.row];
            [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownDatePickerClicked:) forControlEvents:UIControlEventTouchUpInside];
            dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [cell addSubview:dropdownViewModel];
            
        } else if ([[masterAddressDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeLabel]) {
            
            //-- TEXTFIELD MODEL
            textFieldModel.pTxt.identify = [masterAddressIdentity objectAtIndex:indexPath.row];
            textFieldModel.pTitle.text = [masterAddressTitle objectAtIndex:indexPath.row];
            textFieldModel.pButton.hidden = YES;
            textFieldModel.pTxt.hidden = YES;
            textFieldModel.pTextfieldLine.hidden = NO;
            [textFieldModel addSubview:[FormUtil initLabelWithSubTitleText:[masterAddressValue objectAtIndex:indexPath.row]]];
            [cell addSubview:textFieldModel];
            
        } else {
            
            //-- TEXTFIELD MODEL
            textFieldModel.pTxt.identify = [masterAddressIdentity objectAtIndex:indexPath.row];
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
//                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
            }
            textFieldModel.pButton.hidden = YES;
            
            currentTextfield = [masterAddressTextField objectAtIndex:indexPath.row];
            tf = currentTextfield = textFieldModel.pTxt;
            tf.tag = indexPath.row;
            tf.identify = [masterAddressIdentity objectAtIndex:indexPath.row];
            [arrayETextField addObject:tf];
            
            [cell addSubview:textFieldModel];
            
        }
        
    } else if (indexPath.section == 2) {
        
        [indexPathDic setObject:[NSString stringWithFormat:@"%d", indexPath.row] forKey:[readyTaxIdentity objectAtIndex:indexPath.row]];
        
        if ([[readyTaxDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeDropdown]) {
            
            //-- DROPDOWN MODEL
            dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
            dropdownViewModel.pDropdownButton.identify = [readyTaxIdentity objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.text = [readyTaxTitle objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal];
            dropdownViewModel.pHintButton.hidden = YES;
            if ([[readyTaxTitle objectAtIndex:indexPath.row] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"]]) {
                NSString *tps = [ddTaxpayerHashArray objectAtIndex:[currentTaxpayerStatus intValue]];
                if ([Util validateEmptyFieldWithString:[NSString stringWithFormat:@"%@",tps]]) {
                    [dropdownViewModel.pDropdownButton setTitle:[readyTaxPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                } else {
                    [dropdownViewModel.pDropdownButton setTitle:[NSString stringWithFormat:@"%@",tps] forState:UIControlStateNormal];
                }
            } else if ([[readyTaxTitle objectAtIndex:indexPath.row] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"]]) {
                NSString *ss = [ShareUserDetail retrieveDataWithStringKey:[NSString stringWithFormat:@"%@%@", @"spouseHash",[readyTaxValue objectAtIndex:indexPath.row]]];
                if ([Util validateEmptyFieldWithString:[NSString stringWithFormat:@"%@",ss]]) {
                    [dropdownViewModel.pDropdownButton setTitle:[readyTaxPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                } else {
                    [dropdownViewModel.pDropdownButton setTitle:[NSString stringWithFormat:@"%@",ss] forState:UIControlStateNormal];
                }
            } else if ([[readyTaxTitle objectAtIndex:indexPath.row] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"]]) {
                NSString *sc = [readyTaxValue objectAtIndex:indexPath.row];
                if ([Util validateEmptyFieldWithString:[NSString stringWithFormat:@"%@",sc]]) {
                    [dropdownViewModel.pDropdownButton setTitle:[readyTaxPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                } else {
                    [dropdownViewModel.pDropdownButton setTitle:[NSString stringWithFormat:@"%@",sc] forState:UIControlStateNormal];
                }
            } else {
                NSString *mh = [ShareUserDetail retrieveDataWithStringKey:[NSString stringWithFormat:@"%@%@", @"marryHash",[readyTaxValue objectAtIndex:indexPath.row]]];
                if ([Util validateEmptyFieldWithString:[NSString stringWithFormat:@"%@",mh]]) {
                    [dropdownViewModel.pDropdownButton setTitle:[readyTaxPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                } else {
                    [dropdownViewModel.pDropdownButton setTitle:[NSString stringWithFormat:@"%@",mh] forState:UIControlStateNormal];
                }
            }
            [dropdownViewModel.pDropdownButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
            [dropdownViewModel.pDropdownButton setTag:indexPath.row];
            [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
            dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [cell addSubview:dropdownViewModel];
            
        } else if ([[readyTaxDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeDropdownDate]) {
            
            //-- DROPDOWN MODEL
            dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
            dropdownViewModel.pDropdownButton.identify = [readyTaxIdentity objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.text = [readyTaxTitle objectAtIndex:indexPath.row];
            dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal];
            dropdownViewModel.pHintButton.hidden = YES;
            if ([Util validateEmptyFieldWithString:[readyTaxValue objectAtIndex:indexPath.row]]) {
                [dropdownViewModel.pDropdownButton setTitle:[readyTaxPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            } else {
                [dropdownViewModel.pDropdownButton setTitle:[readyTaxValue objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            }
            [dropdownViewModel.pDropdownButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
            [dropdownViewModel.pDropdownButton setTag:indexPath.row];
            [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownDatePickerClicked:) forControlEvents:UIControlEventTouchUpInside];
            dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [cell addSubview:dropdownViewModel];
            
        } else if ([[readyTaxDisplayType objectAtIndex:indexPath.row] isEqualToString:displayTypeLabel]) {
            
            //-- TEXTFIELD MODEL
            textFieldModel.pTxt.identify = [readyTaxIdentity objectAtIndex:indexPath.row];
            textFieldModel.pTitle.text = [readyTaxTitle objectAtIndex:indexPath.row];
            textFieldModel.pButton.hidden = YES;
            textFieldModel.pTxt.hidden = YES;
            textFieldModel.pTextfieldLine.hidden = NO;
            [textFieldModel addSubview:[FormUtil initLabelWithSubTitleText:[readyTaxValue objectAtIndex:indexPath.row]]];
            [cell addSubview:textFieldModel];
            
        } else {
            
            //-- TEXTFIELD MODEL
            textFieldModel.pTxt.identify = [readyTaxIdentity objectAtIndex:indexPath.row];
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
//                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
            }
            textFieldModel.pButton.hidden = YES;
            
            currentTextfield = [readyTaxTextfield objectAtIndex:indexPath.row];
            tf = currentTextfield = textFieldModel.pTxt;
            tf.tag = indexPath.row;
            tf.identify = [readyTaxIdentity objectAtIndex:indexPath.row];
            [arrayETextField addObject:tf];
            
            [cell addSubview:textFieldModel];
        }
        
    } else {
        
        customTemplateModel = [Util loadViewWithNibName:@"CustomTemplateModel"];
        customTemplateModel.pCustomText.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
        customTemplateModel.pDefaultText.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
        customTemplateModel.pDefaultText.text = [Util stringWithScreenName:@"Profile" labelName:@"DefaultTemplate"];
        customTemplateModel.pCustomText.text = [Util stringWithScreenName:@"Profile" labelName:@"CustomTemplate"];
        [customTemplateModel.pDefaultButton addTarget:self action:@selector(defaultButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [customTemplateModel.pCustomButton addTarget:self action:@selector(customButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([isCurrentCustomTemplate isEqualToString:@"N"]) {
            [self selectDefaultTemplate];
        } else {
            [self selectCustomTemplate];
        }
        [cell addSubview:customTemplateModel];
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    [tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    tf.delegate = self ;
    
    
    return cell;
}
#pragma mark - Custom template
-(IBAction)defaultButtonClicked:(id)sender {
    [self selectDefaultTemplate];
}

-(IBAction)customButtonClicked:(id)sender {
    [self selectCustomTemplate];
}

- (void) selectDefaultTemplate {
    isCurrentCustomTemplate = @"N";
    [customTemplateModel.pDefaultButton setImage:[UIImage imageNamed:@"icon_verify.png"] forState:UIControlStateNormal];
    [customTemplateModel.pCustomButton setImage:[UIImage imageNamed:@"icon_unverify.png"] forState:UIControlStateNormal];
}

- (void) selectCustomTemplate {
    isCurrentCustomTemplate = @"Y";
    [customTemplateModel.pDefaultButton setImage:[UIImage imageNamed:@"icon_unverify.png"] forState:UIControlStateNormal];
    [customTemplateModel.pCustomButton setImage:[UIImage imageNamed:@"icon_verify.png"] forState:UIControlStateNormal];
}

#pragma mark - Dropdown
-(IBAction)dropdownClicked:(id)sender
{
    JLLog(@"dropdown Clicked");
    EcheckBox *button = (EcheckBox*) sender;
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
    
    if ([@"countryCode" isEqualToString:currentButton.identify]) {
        dropDownPickerView.tag = tag;
        [dropDownPickerView selectRow:[currentCountryIndex intValue] inComponent:0 animated:NO];
    } else if ([@"province" isEqualToString:currentButton.identify]) {
        dropDownPickerView.tag = tag;
        [dropDownPickerView selectRow:[currentProvinceIndex intValue] inComponent:0 animated:NO];
    } else if ([@"amphur" isEqualToString:currentButton.identify]) {
        dropDownPickerView.tag = tag;
        [dropDownPickerView selectRow:[currentAmphurIndex intValue] inComponent:0 animated:NO];
    } else if ([@"tambol" isEqualToString:currentButton.identify]) {
        if (![currentAmphurIndex isEqualToString:@""]) {
            [self getTambolList:[ddTambol objectAtIndex:[currentAmphurIndex intValue]]];
        }
        dropDownPickerView.tag = tag;
        [dropDownPickerView selectRow:[currentTambolIndex intValue] inComponent:0 animated:NO];
    } else if ([@"taxpayerStatus" isEqualToString:currentButton.identify]) {
        dropDownPickerView.tag = tag;
        [dropDownPickerView selectRow:[currentTaxpayerStatus intValue] inComponent:0 animated:NO];
    } else if ([@"spouseStatus" isEqualToString:currentButton.identify]) {
        dropDownPickerView.tag = tag;
        [dropDownPickerView selectRow:[currentSpouseStatus intValue] inComponent:0 animated:NO];
    } else if ([@"spouseBirthDate" isEqualToString:currentButton.identify]) {
        dropDownPickerView.tag = tag;
    } else if ([@"spouseCountry" isEqualToString:currentButton.identify]) {
        dropDownPickerView.tag = tag;
        [dropDownPickerView selectRow:[currentSpouseCountryIndex intValue] inComponent:0 animated:NO];
    } else {
        dropDownPickerView.tag = tag;
        [dropDownPickerView selectRow:[currentMarryStatus intValue] inComponent:0 animated:NO];
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
    
    if ([@"province" isEqualToString:currentButton.identify]) {
        
        currentProvinceIndex = [NSString stringWithFormat:@"%d", [dropDownPickerView selectedRowInComponent:0]];
        [currentButton setTitle:[ddProvinceName objectAtIndex:[currentProvinceIndex intValue]] forState:UIControlStateNormal];
        [self setNewProvinceSourceToTableView];
        
        [self callAmphurService];

    } else if ([@"amphur" isEqualToString:currentButton.identify]) {
        
        currentAmphurIndex = [NSString stringWithFormat:@"%d", [dropDownPickerView selectedRowInComponent:0]];
        [currentButton setTitle:[ddAmphurName objectAtIndex:[currentAmphurIndex intValue]] forState:UIControlStateNormal];
        [self getTambolList:[ddTambol objectAtIndex:[currentAmphurIndex intValue]]];
        [self setNewAmphurSourceToTableView];
        
    } else if ([@"tambol" isEqualToString:currentButton.identify]) {
        
        currentTambolIndex = [NSString stringWithFormat:@"%d", [dropDownPickerView selectedRowInComponent:0]];
        [currentButton setTitle:[ddTambolName objectAtIndex:[currentTambolIndex intValue]] forState:UIControlStateNormal];
        [self setNewTambolSourceToTableView];
        
    } else if ([@"taxpayerStatus" isEqualToString:currentButton.identify]) {
        
        currentTaxpayerStatus = [NSString stringWithFormat:@"%d", [dropDownPickerView selectedRowInComponent:0]];
        [currentButton setTitle:[ddTaxpayerHashArray objectAtIndex:[currentTaxpayerStatus intValue]] forState:UIControlStateNormal];
        [self setNewTaxPayerStatusSourceToTableView];
        
    } else if ([@"spouseStatus" isEqualToString:currentButton.identify]) {
        
        currentSpouseStatus = [NSString stringWithFormat:@"%d", [dropDownPickerView selectedRowInComponent:0]];
        [currentButton setTitle:[ddSpouseHashArray objectAtIndex:[currentSpouseStatus intValue]] forState:UIControlStateNormal];
        [self setNewSpouseStatusSourceToTableView];
        
    } else if ([@"spouseBirthDate" isEqualToString:currentButton.identify]) {
        currentSpouseBirthDate = [dateFormatter stringFromDate:dropDownDatePickerView.date];
        [currentButton setTitle:[dateFormatter stringFromDate:dropDownDatePickerView.date] forState:UIControlStateNormal];
        [self setNewSpouseBirthDateSourceToTableView];
        
    } else if ([@"countryCode" isEqualToString:currentButton.identify]) {
        currentCountryIndex = [NSString stringWithFormat:@"%d", [dropDownPickerView selectedRowInComponent:0]];
        [currentButton setTitle:[ddCountryNameArray objectAtIndex:[currentCountryIndex intValue]] forState:UIControlStateNormal];
        [self setNewCountrySourceToTableView];
        
    } else if ([@"spouseCountry" isEqualToString:currentButton.identify]) {
        currentSpouseCountryIndex = [NSString stringWithFormat:@"%d", [dropDownPickerView selectedRowInComponent:0]];
        [currentButton setTitle:[ddCountryNameArray objectAtIndex:[currentSpouseCountryIndex intValue]] forState:UIControlStateNormal];
        [self setNewSpouseCountrySourceToTableView];
        
    } else {
        currentMarryStatus = [NSString stringWithFormat:@"%d", [dropDownPickerView selectedRowInComponent:0]];
        [currentButton setTitle:[ddMarryHashArray objectAtIndex:[currentMarryStatus intValue]] forState:UIControlStateNormal];
        [self setNewMarryStatusSourceToTableView];
    }
    
    [dropDownActionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if ([@"province" isEqualToString:currentButton.identify]) {
        return [ddProvinceName count];
    } else if ([@"amphur" isEqualToString:currentButton.identify]) {
        return [ddAmphurName count];
    } else if ([@"tambol" isEqualToString:currentButton.identify]) {
        return [ddTambolName count];
    } else if ([@"taxpayerStatus" isEqualToString:currentButton.identify]) {
        return [ddTaxpayerHashArray count];
    } else if ([@"spouseStatus" isEqualToString:currentButton.identify]) {
        return [ddSpouseHashArray count];
    } else if ([@"countryCode" isEqualToString:currentButton.identify]) {
        return [ddCountryNameArray count];
    } else if ([@"spouseBirthDate" isEqualToString:currentButton.identify]) {
        return 0;
    } else if ([@"spouseCountry" isEqualToString:currentButton.identify]) {
        return [ddCountryNameArray count];
    } else {
        return [ddMarryHashArray count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if ([@"province" isEqualToString:currentButton.identify]) {
        return [ddProvinceName objectAtIndex:row];
    } else if ([@"amphur" isEqualToString:currentButton.identify]) {
        return [ddAmphurName objectAtIndex:row];
    } else if ([@"tambol" isEqualToString:currentButton.identify]) {
        return [ddTambolName objectAtIndex:row];
    } else if ([@"taxpayerStatus" isEqualToString:currentButton.identify]) {
        return [ddTaxpayerHashArray objectAtIndex:row];
    } else if ([@"spouseStatus" isEqualToString:currentButton.identify]) {
        return [ddSpouseHashArray objectAtIndex:row];
    } else if ([@"countryCode" isEqualToString:currentButton.identify]) {
        return [ddCountryNameArray objectAtIndex:row];
    } else if ([@"spouseBirthDate" isEqualToString:currentButton.identify]) {
        return @"";
    } else if ([@"spouseCountry" isEqualToString:currentButton.identify]) {
        return [ddCountryNameArray objectAtIndex:row];
    } else {
        return [ddMarryHashArray objectAtIndex:row];
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, self.view.frame.size.width-50, 30);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        //pickerLabel.textAlignment = UITextAlignmentRight;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    }
    
    if ([@"province" isEqualToString:currentButton.identify]) {
        [pickerLabel setText:[ddProvinceName objectAtIndex:row]];
    } else if ([@"amphur" isEqualToString:currentButton.identify]) {
        [pickerLabel setText:[ddAmphurName objectAtIndex:row]];
    } else if ([@"tambol" isEqualToString:currentButton.identify]) {
        [pickerLabel setText:[ddTambolName objectAtIndex:row]];
    } else if ([@"taxpayerStatus" isEqualToString:currentButton.identify]) {
        [pickerLabel setText:[ddTaxpayerHashArray objectAtIndex:row]];
    } else if ([@"spouseStatus" isEqualToString:currentButton.identify]) {
        [pickerLabel setText:[ddSpouseHashArray objectAtIndex:row]];
    } else if ([@"countryCode" isEqualToString:currentButton.identify]) {
        [pickerLabel setText:[ddCountryNameArray objectAtIndex:row]];
    } else if ([@"spouseBirthDate" isEqualToString:currentButton.identify]) {
        [pickerLabel setText:[readyGeneralTitle objectAtIndex:row]];
    } else if ([@"spouseCountry" isEqualToString:currentButton.identify]) {
        [pickerLabel setText:[ddCountryNameArray objectAtIndex:row]];
    } else {
        [pickerLabel setText:[ddMarryHashArray objectAtIndex:row]];
    }
    
    
    return pickerLabel;
    
}
#pragma mark - Dropdown Date picker
-(IBAction)dropdownDatePickerClicked:(id)sender
{
    EcheckBox *button = (EcheckBox*) sender;
    currentButton = button;
    [self showDropDownDatePickerViewWithTag:currentButton.tag Delegate:self];
}

-(void)showDropDownDatePickerViewWithTag:(NSInteger)tag Delegate:(id)delegate

{
    dropDownActionSheet = [[UIActionSheet alloc] init];
    dropDownActionSheet.tag = tag;
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
    
    if([currentSpouseBirthDate isEqualToString:@""]){
        // set default date 01/01/yyyy
        
        NSDateFormatter *formatterDefault = [[NSDateFormatter alloc] init];
        NSDate *defaulDate = [[NSDate alloc] init];
        [formatterDefault setDateFormat:@"dd/MM/yyyy"];
        
        NSDateFormatter *formatterYear = [[NSDateFormatter alloc] init];
        [formatterYear setDateFormat:@"yyyy"];
        
        if ([@"T" isEqualToString:[Util loadAppSettingWithName:@"AppLanguage"]]) {
            [formatterYear setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
        }
        NSString *yearString = [formatterYear stringFromDate:[NSDate date]];
        NSString *defaulDateStr= [NSString stringWithFormat:@"%@%@",@"01/01/",yearString];
        NSLog(@"default date str%@",defaulDateStr);
        defaulDate = [formatterDefault dateFromString:defaulDateStr];
        NSLog(@"default date %@",defaulDate);
        
        [dropDownDatePickerView setDate:defaulDate];
        [dropDownDatePickerView setMaximumDate:maxDate];
        //[dropDownDatePickerView addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
        dropDownDatePickerView.tag = tag;
        
    } else {
        NSDateFormatter *formatterSelectDate = [[NSDateFormatter alloc] init];
        
        if ([@"T" isEqualToString:[Util loadAppSettingWithName:@"AppLanguage"]]) {
            [formatterSelectDate setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
        } else {
            [formatterSelectDate setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        }
        
        NSDate *selectDate = [[NSDate alloc] init];
        [formatterSelectDate setDateFormat:@"dd/MM/yyyy"];
        NSLog(@"curent date %@",currentSpouseBirthDate);
        selectDate = [formatterSelectDate dateFromString:currentSpouseBirthDate];
        NSLog(@"select date %@",selectDate);
        [dropDownDatePickerView setDate:selectDate];
        [dropDownDatePickerView setMaximumDate:maxDate];
    }
    
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    [toolBar sizeToFit];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Cancel"] style:UIBarButtonItemStyleBordered target:delegate action:@selector(cancel_clicked:)];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Done"] style:UIBarButtonItemStyleBordered target:delegate action:@selector(done_clicked:)];
    
    doneBtn.tag = tag;
    cancelBtn.tag = tag;
    
    NSArray *barItems = @[doneBtn, flexSpace, cancelBtn];
    
    [toolBar setItems:barItems animated:YES];
    
    [dropDownActionSheet addSubview:toolBar];
    [dropDownActionSheet addSubview:dropDownDatePickerView];
    
    [dropDownActionSheet showInView:self.view];
    [dropDownActionSheet setBounds:CGRectMake(0, 0, self.view.frame.size.width, 464)];
    
}

- (void)dateChanged {

}


#pragma mark - Check
- (void) removeAllMasterData {
    [masterGeneralTitle removeAllObjects];
    [masterGeneralValue removeAllObjects];
    [masterGeneralPlaceHolder removeAllObjects];
    [masterGeneralKeyboardType removeAllObjects];
    [masterGeneralDisplayType removeAllObjects];
    [masterGeneralTextField removeAllObjects];
    [masterGeneralIdentity removeAllObjects];
    
    [readyGeneralTitle removeAllObjects];
    [readyGeneralValue removeAllObjects];
    [readyGeneralPlaceHolder removeAllObjects];
    [readyGeneralKeyboardType removeAllObjects];
    [readyGeneralDisplayType removeAllObjects];
    [readyGeneralTextfield removeAllObjects];
    [readyGeneralIdentity removeAllObjects];
    
    [masterAddressTitle removeAllObjects];
    [masterAddressValue removeAllObjects];
    [masterAddressPlaceHolder removeAllObjects];
    [masterAddressKeyboardType removeAllObjects];
    [masterAddressDisplayType removeAllObjects];
    [masterAddressTextField removeAllObjects];
    [masterAddressIdentity removeAllObjects];
    
    [masterTaxTitle removeAllObjects];
    [masterTaxValue removeAllObjects];
    [masterTaxPlaceHolder removeAllObjects];
    [masterTaxKeyboardType removeAllObjects];
    [masterTaxDisplayType removeAllObjects];
    [masterTaxTextfield removeAllObjects];
    [masterTaxIdentity removeAllObjects];
    
    [readyTaxTitle removeAllObjects];
    [readyTaxValue removeAllObjects];
    [readyTaxPlaceHolder removeAllObjects];
    [readyTaxKeyboardType removeAllObjects];
    [readyTaxDisplayType removeAllObjects];
    [readyTaxTextfield removeAllObjects];
    [readyTaxIdentity removeAllObjects];
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

- (void) setNewProvinceSourceToTableView {
    [self removeAllMasterData];
    
    self.province = [ddProvinceName objectAtIndex:[currentProvinceIndex intValue]];
    [self initMasterData];
    
    taxPermission = [self getTaxPermission];
    [self setTaxReadyDataWithPermission:taxPermission];
    
    generalPermission = [self getGeneralPermission];
    [self setGeneralReadyDataWithPermission:generalPermission];
    
    [dataArray removeAllObjects];
    [self setTableViewSection];
    [self.tableView reloadData];
}

- (void) setNewAmphurSourceToTableView {
    [self removeAllMasterData];
    
    self.amphur = [ddAmphurName objectAtIndex:[currentAmphurIndex intValue]];
    [self initMasterData];
    
    taxPermission = [self getTaxPermission];
    [self setTaxReadyDataWithPermission:taxPermission];
    
    generalPermission = [self getGeneralPermission];
    [self setGeneralReadyDataWithPermission:generalPermission];
    
    [dataArray removeAllObjects];
    [self setTableViewSection];
    [self.tableView reloadData];
}

- (void) setNewTambolSourceToTableView {
    [self removeAllMasterData];
    
    self.tambol = [ddTambolName objectAtIndex:[currentTambolIndex intValue]];
    [self initMasterData];
    
    taxPermission = [self getTaxPermission];
    [self setTaxReadyDataWithPermission:taxPermission];
    
    generalPermission = [self getGeneralPermission];
    [self setGeneralReadyDataWithPermission:generalPermission];
    
    [dataArray removeAllObjects];
    [self setTableViewSection];
    [self.tableView reloadData];
}

- (void) setNewTaxPayerStatusSourceToTableView {
    
    //-- Set new data to array
    [self removeAllMasterData];
    self.taxpayerStatus = currentButton.currentTitle;
    [self initMasterData];
    
    taxPermission = [self getTaxPermission];
    [self setTaxReadyDataWithPermission:taxPermission];
    
    generalPermission = [self getGeneralPermission];
    [self setGeneralReadyDataWithPermission:generalPermission];
    
    [dataArray removeAllObjects];
    [self setTableViewSection];
    [self.tableView reloadData];
}

- (void) setNewSpouseStatusSourceToTableView {
    
    //-- Set new data to array
    [self removeAllMasterData];
    self.spouseStatus = currentButton.currentTitle;
    [self initMasterData];
    
    taxPermission = [self getTaxPermission];
    [self setTaxReadyDataWithPermission:taxPermission];
    
    generalPermission = [self getGeneralPermission];
    [self setGeneralReadyDataWithPermission:generalPermission];
    
    [dataArray removeAllObjects];
    [self setTableViewSection];
    [self.tableView reloadData];
}

- (void) setNewMarryStatusSourceToTableView {
    
    //-- Set new data to array
    [self removeAllMasterData];
    self.marryStatus = currentButton.currentTitle;
    [self initMasterData];
    
    taxPermission = [self getTaxPermission];
    [self setTaxReadyDataWithPermission:taxPermission];
    
    generalPermission = [self getGeneralPermission];
    [self setGeneralReadyDataWithPermission:generalPermission];
    
    [dataArray removeAllObjects];
    [self setTableViewSection];
    [self.tableView reloadData];
}

- (void) setNewSpouseCountrySourceToTableView {
    [self removeAllMasterData];
    
    self.spouseCountry = [ddCountryNameArray objectAtIndex:[currentSpouseCountryIndex intValue]];
    [self initMasterData];
    taxPermission = [self getTaxPermission];
    [self setTaxReadyDataWithPermission:taxPermission];
    
    generalPermission = [self getGeneralPermission];
    [self setGeneralReadyDataWithPermission:generalPermission];
    
    [dataArray removeAllObjects];
    [self setTableViewSection];
    [self.tableView reloadData];
}

- (void) setNewCountrySourceToTableView {
    [self removeAllMasterData];
    
    self.country = [ddCountryNameArray objectAtIndex:[currentCountryIndex intValue]];
    [self initMasterData];
    taxPermission = [self getTaxPermission];
    [self setTaxReadyDataWithPermission:taxPermission];
    
    generalPermission = [self getGeneralPermission];
    [self setGeneralReadyDataWithPermission:generalPermission];
    
    [dataArray removeAllObjects];
    [self setTableViewSection];
    [self.tableView reloadData];
}

- (void) setNewSpouseBirthDateSourceToTableView {
    currentSpouseBirthDate = currentButton.currentTitle;
    
    [self removeAllMasterData];
    self.spouseBirthDate = currentButton.currentTitle;
    [self initMasterData];
    taxPermission = [self getTaxPermission];
    [self setTaxReadyDataWithPermission:taxPermission];
    
    generalPermission = [self getGeneralPermission];
    [self setGeneralReadyDataWithPermission:generalPermission];
    
    [dataArray removeAllObjects];
    [self setTableViewSection];
    [self.tableView reloadData];
}

#pragma mark - call service
- (void) onSaveButtonClicked :(UIButton*)button {
    
    if ([self validateField]) {

        if ([Util isInternetConnect]) {

            [self callUpdateProfileService];
            
        } else {
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
        }
    }
    
}

- (NSString *) checkGeneralPermissionWithIndex : (int) index val: (NSString *) val {
    if ([generalPermission objectAtIndex:index]==Y) {
        return val;
    } else {
        return @"";
    }
}

- (NSString *) checkTaxPermissionWithIndex : (int) index val: (NSString *) val {
    if ([taxPermission objectAtIndex:index]==Y) {
        return val;
    } else {
        return @"";
    }
}

- (void) callUpdateProfileService {
    
        enUpdateProfileService = [[ENUpdateProfileService alloc]init];
        enUpdateProfileService.delegate = self;
    
        spouseBirthDateToService = @"";
        if (![currentSpouseBirthDate isEqualToString:@""]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
            NSDate *date = [dateFormatter dateFromString: currentSpouseBirthDate];
            if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"E"]) {
                [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
            }
            [dateFormatter setDateFormat:@"ddMMyyyy"];
            spouseBirthDateToService = [dateFormatter stringFromDate:date];

        }
    
        [self logAllValue];
    
        [enUpdateProfileService requestENUpdateProfileServiceWithNid:[ShareUserDetail retrieveDataWithStringKey:@"nid"]
                                                           authenKey:[ShareUserDetail retrieveDataWithStringKey:@"authenKey"]
                                                           nameTitle:self.nameTitle
                                                                name:[self checkGeneralPermissionWithIndex:2 val:self.name]
                                                          middleName:[self checkGeneralPermissionWithIndex:3 val:self.middleName]
                                                             surname:[self checkGeneralPermissionWithIndex:4 val:self.surname]
                                                                tel :[self checkGeneralPermissionWithIndex:7 val:[TextFormatterUtil removeMinusSignFromString:self.tel]]
                                                              email :[self checkGeneralPermissionWithIndex:8 val:self.email]
                                                         passportId :[self checkGeneralPermissionWithIndex:5 val:self.passportId]
                                                            country :[self checkGeneralPermissionWithIndex:6 val:currentCountryIndex]
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
                                                      taxpayerStatus:[self checkTaxPermissionWithIndex:0 val:currentTaxpayerStatus]
                                                        spouseStatus:[self checkTaxPermissionWithIndex:2 val:currentSpouseStatus]
                                                         marryStatus:[self checkTaxPermissionWithIndex:1 val:currentMarryStatus]
                                                           spouseNid:[self checkTaxPermissionWithIndex:3 val:[TextFormatterUtil removeMinusSignFromString:self.spouseNid]]
                                                          spouseName:[self checkTaxPermissionWithIndex:4 val:self.spouseName]
                                                       spouseSurname:[self checkTaxPermissionWithIndex:5 val:self.spouseSurname]
                                                    spouseBirthDate :[self checkTaxPermissionWithIndex:6 val:spouseBirthDateToService]
                                                   spousePassportId :[self checkTaxPermissionWithIndex:7 val:self.spousePassportId]
                                                      spouseCountry :[self checkTaxPermissionWithIndex:8 val:currentSpouseCountryIndex]
                                                        childNoStudy:[self checkTaxPermissionWithIndex:13 val:self.childNoStudy]
                                                          childStudy:[self checkTaxPermissionWithIndex:14 val:self.childStudy]
                                                        txpFatherPin:[self checkTaxPermissionWithIndex:9 val:[TextFormatterUtil removeMinusSignFromString:self.txpFatherPin]]
                                                        txpMotherPin:[self checkTaxPermissionWithIndex:10 val:[TextFormatterUtil removeMinusSignFromString:self.txpMotherPin]]
                                                     spouseFatherPin:[self checkTaxPermissionWithIndex:11 val:[TextFormatterUtil removeMinusSignFromString:self.spouseFatherPin]]
                                                     spouseMotherPin:[self checkTaxPermissionWithIndex:12 val:[TextFormatterUtil removeMinusSignFromString:self.spouseMotherPin]]];
    
    
}

#pragma mark - Response Delegate
- (void) responseENUpdateProfileService:(NSDictionary *)data {
    NSDictionary *dic = data;
    
    if ([[dic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
        [self alertResultWithTitle:@"" detail:[Util stringWithScreenName:@"Common" labelName:@"Success"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        
    }  else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseMessage"]];
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
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UISCROLLVIEW DELEGATE
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self hideKeyboard];
}

#pragma mark - SET Data Dropdown
-(void)setDataDropDownWithData:(NSString*)dataDD Identify:(NSString*)identify
{
    [dataDropdown setObject:dataDD forKey:identify];
}

#pragma mark - get province

- (void) responseENGetProvince:(NSDictionary *)data {
    NSDictionary *dic = data;
    if ([[dic objectForKey:@"responseCode"]isEqualToString:@"0"]) {
        NSDictionary *province = [dic objectForKey:@"province"];
        
        NSEnumerator *enumerator = [province objectEnumerator];
        id object;
        while (object = [enumerator nextObject]) {
            [ddProvinceId addObject:[object objectForKey:@"provinceID"]];
            if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
                [ddProvinceName addObject:[object objectForKey:@"provinceName"]];
            } else {
                [ddProvinceName addObject:[object objectForKey:@"provinceName"]];
            }
        }
        
        [self setProvinceDefault];
        
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseMessage"]];
    }
}

- (void) setProvinceDefault {
    for (int i = 0; i < [ddProvinceName count]; i++) {
        if ([[NSString stringWithFormat:@"%@",[ddProvinceName objectAtIndex:i]] isEqualToString:[ShareUserDetail retrieveDataWithStringKey:@"province"]]) {
            currentProvinceIndex = [NSString stringWithFormat:@"%d",i];
        }
    }
    //-- call province
    if (![currentProvinceIndex isEqualToString:@""]) {
        [self callAmphurService];
    }
}

#pragma mark - get amphur
- (void) callAmphurService {
    if ([Util isInternetConnect]) {
        enGetAmphur = [[ENGetAmphur alloc]init];
        enGetAmphur.delegate = self;
        [enGetAmphur requestENGetAmphur:[ddProvinceId objectAtIndex:[currentProvinceIndex intValue]]];
        
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
    }
}

- (void) responseENGetAmphur:(NSDictionary *)data {
    NSDictionary *dic = data;
    if ([[dic objectForKey:@"responseCode"]isEqualToString:@"0"]) {
        
        NSDictionary *amphur = [dic objectForKey:@"amphur"];
        NSEnumerator *enumerator1 = [amphur objectEnumerator];
        
        [ddAmphurId removeAllObjects];
        [ddTambol removeAllObjects];
        [ddAmphurName removeAllObjects];
        id object1;
        while (object1 = [enumerator1 nextObject]) {
            [ddAmphurId addObject:[object1 objectForKey:@"amphurID"]];
            [ddTambol addObject:[object1 objectForKey:@"tambol"]];
            if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
                [ddAmphurName addObject:[object1 objectForKey:@"amphurName"]];
            } else {
                [ddAmphurName addObject:[object1 objectForKey:@"amphurName"]];
            }
        }
        
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseMessage"]];
    }
}

- (void) getTambolList : (NSMutableArray *) mArray {
    
    [ddTambolId removeAllObjects];
    [ddTambolName removeAllObjects];
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    dic = [mArray mutableCopy];
    
    id object2;
    NSEnumerator *enumerator2 = [dic objectEnumerator];

    while (object2 = [enumerator2 nextObject]) {
        [ddTambolId addObject:[object2 objectForKey:@"tambolID"]];
        if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
            [ddTambolName addObject:[object2 objectForKey:@"tambolName"]];
        } else {
            [ddTambolName addObject:[object2 objectForKey:@"tambolName"]];
        }
    }
}




@end

