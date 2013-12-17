//
//  EfilingGeneralProfileViewController.m
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingGeneralProfileViewController.h"
#import "EfilingHomeViewController.h"
#import "TextFieldModel.h"

#import "FontUtil.h"
#import "Util.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"
#import "ReduceStatusRule.h"


@interface EfilingGeneralProfileViewController () {
    ENUpdateProfileService *enUpdateProfileService;
    ENSaveLoginFirstService *enSaveLoginFirstService;
    
    NSArray *generalProfileArray;
    NSArray *generalProfilePlaceHolder;
    NSArray *addressArray;
    NSArray *addressPlaceHolder;
    NSArray *reduceStatusArray;
    NSArray *reduceStatusPlaceHolder;
    
    TextFieldModel *textFieldModel;
}

@end

@implementation EfilingGeneralProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void) responseENSaveLoginFirstService:(NSData *)data {
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        EfilingHomeViewController *vc = [[EfilingHomeViewController alloc]initWithNibName:@"EfilingHomeViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if ([self.pFirstLogin isEqualToString:@"1"]) {
        //-- save first login
        enSaveLoginFirstService = [[ENSaveLoginFirstService alloc]init];
        enSaveLoginFirstService.delegate = self;
        [enSaveLoginFirstService requestENSaveLoginFirstServiceWithNid:[ShareUserDetail retrieveDataWithStringKey:@"nid"]];
        
    }
    //-- Initialize the dataArray
    dataArray = [[NSMutableArray alloc] init];
    
    //-- Clear data
    
    self.name = [ShareUserDetail retrieveDataWithStringKey:@"name"];
    self.surname = [ShareUserDetail retrieveDataWithStringKey:@"surname"];
    self.tel = [ShareUserDetail retrieveDataWithStringKey:@"contractNo"];
    self.email = [ShareUserDetail retrieveDataWithStringKey:@"email"];
    self.country = [ShareUserDetail retrieveDataWithStringKey:@"countryCode"];
    self.passportId = [ShareUserDetail retrieveDataWithStringKey:@"passportNo"];
    
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
    
    self.taxpayerStatus = [ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"];
    self.spouseStatus = [ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"];
    self.marryStatus = [ShareUserDetail retrieveDataWithStringKey:@"marryStatus"];
    self.spouseNid = [ShareUserDetail retrieveDataWithStringKey:@"spouseNid"];
    self.spouseName = [ShareUserDetail retrieveDataWithStringKey:@"spouseName"];
    self.spouseSurname = [ShareUserDetail retrieveDataWithStringKey:@"spouseSurname"];
    self.spouseBirthDate = [ShareUserDetail retrieveDataWithStringKey:@"spouseBirthDate"];
    self.spousePassportId = [ShareUserDetail retrieveDataWithStringKey:@"spousePassportId"];
    self.spouseCountry = [ShareUserDetail retrieveDataWithStringKey:@"spouseCountry"];
    self.childNoStudy = [ShareUserDetail retrieveDataWithStringKey:@"childNoStudy"];
    self.childStudy = [ShareUserDetail retrieveDataWithStringKey:@"childStudy"];
    self.txpFatherPin = [ShareUserDetail retrieveDataWithStringKey:@"txpFatherPin"];
    self.txpMotherPin = [ShareUserDetail retrieveDataWithStringKey:@"txpMotherPin"];
    self.spouseFatherPin = [ShareUserDetail retrieveDataWithStringKey:@"spouseFatherPin"];
    self.spouseMotherPin = [ShareUserDetail retrieveDataWithStringKey:@"spouseMotherPin"];
    
    
    //------------------------------- Value GENERAL PROFILE ----------------------------------------------------------
    
    if ([[ShareUserDetail retrieveDataWithStringKey:@"thaiNation"] isEqualToString:@"1"]) {
        
        generalProfileArray = [[NSArray alloc]initWithObjects:
                               [Util stringWithScreenName:@"Common" labelName:@"Nid"],
                               [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                               [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                               [Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
                               [Util stringWithScreenName:@"Common" labelName:@"Email"],
                               nil];
        
        generalProfilePlaceHolder = [[NSArray alloc]initWithObjects:
                                     [Util stringWithScreenName:@"Common" labelName:@"Nid"],
                                     [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                                     [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                                     [Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
                                     [Util stringWithScreenName:@"Common" labelName:@"Email"],
                                     nil];
        
    } else {
        
        generalProfileArray = [[NSArray alloc]initWithObjects:
                               [Util stringWithScreenName:@"Common" labelName:@"Nid"],
                               [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                               [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                               [Util stringWithScreenName:@"Common" labelName:@"Passport"],
                               [Util stringWithScreenName:@"Common" labelName:@"Country"],
                               [Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
                               [Util stringWithScreenName:@"Common" labelName:@"Email"],
                               nil];

        generalProfilePlaceHolder = [[NSArray alloc]initWithObjects:
                               [Util stringWithScreenName:@"Common" labelName:@"Nid"],
                               [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                               [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                               [Util stringWithScreenName:@"Common" labelName:@"Passport"],
                               [Util stringWithScreenName:@"Common" labelName:@"Country"],
                               [Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
                               [Util stringWithScreenName:@"Common" labelName:@"Email"],
                               nil];

    }
    
    NSDictionary *generalProfileDic = [NSDictionary dictionaryWithObject:generalProfileArray forKey:@"data"];
    [dataArray addObject:generalProfileDic];
    
    
    //------------------------------- Value ADDRESS ----------------------------------------------------------
    
    addressArray = [[NSArray alloc]initWithObjects:
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
    
    addressPlaceHolder = [[NSArray alloc]initWithObjects:
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
    
    NSDictionary *addressArrayDic = [NSDictionary dictionaryWithObject:addressArray forKey:@"data"];
    [dataArray addObject:addressArrayDic];
    
    
    //------------------------------- Value REDUCE STATUS ----------------------------------------------------------
    
    //--############  TEXT  ##############
    //-- Thai
    if ([[ShareUserDetail retrieveDataWithStringKey:@"thaiNation"] isEqualToString:@"1"]) {
        
        //-- Single and devorce
        if ([[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"0"] || [[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"3"]) {

            reduceStatusArray = [ReduceStatusRule rule1_thaiSingle];
            
        //-- Marry Thai
        } else if ([[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"1"]) {
            
            //-- have salary
            if ([[ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"] isEqualToString:@"1"]) {
                reduceStatusArray = [ReduceStatusRule rule3_thai_thaiSpouse_haveSalary];
            } else {
                reduceStatusArray = [ReduceStatusRule rule4_thai_thaiSpouse_noSalary];
            }
            
            
        //-- Marry Eng
        } else {
            
            //-- have salary
            if ([[ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"] isEqualToString:@"1"]) {
                reduceStatusArray = [ReduceStatusRule rule5_thai_engSpouse_haveSalary];
            } else {
                reduceStatusArray = [ReduceStatusRule rule6_thai_engSpouse_noSalary];
            }
            
        }
        
    //-- Eng
    } else {
        
        //-- Single and devorce
        if ([[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"0"] || [[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"3"]) {
            
            reduceStatusArray = [ReduceStatusRule rule2_engSingle];
            
        //-- Marry Thai
        } else if ([[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"1"]) {
            
            //-- have salary
            if ([[ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"] isEqualToString:@"1"]) {
                reduceStatusArray = [ReduceStatusRule rule7_eng_thaiSpouse_haveSalary];
            } else {
                reduceStatusArray = [ReduceStatusRule rule8_eng_thaiSpouse_noSalary];
            }
            
            
        //-- Marry Eng
        } else {
            
            //-- have salary
            if ([[ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"] isEqualToString:@"1"]) {
                reduceStatusArray = [ReduceStatusRule rule9_eng_engSpouse_haveSalary];
            } else {
                reduceStatusArray = [ReduceStatusRule rule10_eng_engSpouse_noSalary];
            }
            
        }
    }
    
    
    NSDictionary *reduceStatusArrayDic = [NSDictionary dictionaryWithObject:reduceStatusArray forKey:@"data"];
    [dataArray addObject:reduceStatusArrayDic];
    
    
    //--############  PLACE HOLDER  ##############
    //-- Thai
    if ([[ShareUserDetail retrieveDataWithStringKey:@"thaiNation"] isEqualToString:@"1"]) {
        
        //-- Single and devorce
        if ([[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"0"] || [[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"3"]) {
            
            reduceStatusPlaceHolder = [ReduceStatusRule rule1_thaiSingle];
            
            //-- Marry Thai
        } else if ([[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"1"]) {
            
            //-- have salary
            if ([[ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"] isEqualToString:@"1"]) {
                reduceStatusPlaceHolder = [ReduceStatusRule rule3_thai_thaiSpouse_haveSalary];
            } else {
                reduceStatusPlaceHolder = [ReduceStatusRule rule4_thai_thaiSpouse_noSalary];
            }
            
            
            //-- Marry Eng
        } else {
            
            //-- have salary
            if ([[ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"] isEqualToString:@"1"]) {
                reduceStatusPlaceHolder = [ReduceStatusRule rule5_thai_engSpouse_haveSalary];
            } else {
                reduceStatusPlaceHolder = [ReduceStatusRule rule6_thai_engSpouse_noSalary];
            }
            
        }
        
        //-- Eng
    } else {
        
        //-- Single and devorce
        if ([[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"0"] || [[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"3"]) {
            
            reduceStatusPlaceHolder = [ReduceStatusRule rule2_engSingle];
            
            //-- Marry Thai
        } else if ([[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"1"]) {
            
            //-- have salary
            if ([[ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"] isEqualToString:@"1"]) {
                reduceStatusPlaceHolder = [ReduceStatusRule rule7_eng_thaiSpouse_haveSalary];
            } else {
                reduceStatusPlaceHolder = [ReduceStatusRule rule8_eng_thaiSpouse_noSalary];
            }
            
            
            //-- Marry Eng
        } else {
            
            //-- have salary
            if ([[ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"] isEqualToString:@"1"]) {
                reduceStatusPlaceHolder = [ReduceStatusRule rule9_eng_engSpouse_haveSalary];
            } else {
                reduceStatusPlaceHolder = [ReduceStatusRule rule10_eng_engSpouse_noSalary];
            }
            
        }
    }
    
    
    //-- Add Tap Gesture -----------------------------------------------------
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    
    //-- Add last button
//    UIView *v = [[UIView alloc]init];
//    [v addSubview:[FormUtil initNextButtonWithTitle:@"Next"]];
//    self.tableView.tableFooterView = v;
    
}


#pragma - mark Textfield
-(void)hideKeyboard
{
    if(txtActiveEditing) {
        [txtActiveEditing resignFirstResponder];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    txtActiveEditing = textField;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if ( textField == nameField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == surnameField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.surname"] integerValue]) {
            return NO;
        }
        
	}  else if ( textField == telField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.contractNo"] integerValue]) {
            return NO;
        }
        
	}  else if ( textField == emailField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.email"] integerValue]) {
            return NO;
        }
        
//	} else if ( textField == countryField_) {
//		if (range.location == [[Util retrieveValidateConfigFromKey:@""] integerValue]) {
//            return NO;
//        }
        
	} else if ( textField == passportIdField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.passportNo"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == buildNameField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.buildName"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == roomNoField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.roomNo"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == floorNoField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.floorNo"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == addressNoField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.addressNo"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == soiField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.soi"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == villageField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.village"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == mooNoField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.mooNo"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == streetField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.street"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == tambolField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.tambol"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == amphurField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.amphur"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == provinceField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.province"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == postcodeField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.postcode"] integerValue]) {
            return NO;
        }
        
//	} else if ( textField == taxpayerStatusField_ ) {
//		if (range.location == [[Util retrieveValidateConfigFromKey:@""] integerValue]) {
//            return NO;
//        }
//        
//	} else if ( textField == spouseStatusField_ ) {
//		if (range.location == [[Util retrieveValidateConfigFromKey:@""] integerValue]) {
//            return NO;
//        }
//        
//	} else if ( textField == marryStatusField_ ) {
//		if (range.location == [[Util retrieveValidateConfigFromKey:@""] integerValue]) {
//            return NO;
//        }
//        
	} else if ( textField == spouseNidField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseNid"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == spouseNameField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseName"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == spouseSurnameField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseSurname"] integerValue]) {
            return NO;
            
//    } else if ( textField == spouseBirthDateField_ ) {
//        if (range.location == [[Util retrieveValidateConfigFromKey:@""] integerValue]) {
//            return NO;
//        }
        
    } else if ( textField == spousePassportIdField_ ) {
        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spousePassportNo"] integerValue]) {
            return NO;
        }
        
//    } else if ( textField == spouseCountryField_ ) {
//        if (range.location == [[Util retrieveValidateConfigFromKey:@""] integerValue]) {
//            return NO;
//        }
    }
        
//	} else if ( textField == childNoStudyField_ ) {
//		if (range.location == [[Util retrieveValidateConfigFromKey:@""] integerValue]) {
//            return NO;
//        }
//        
//	} else if ( textField == childStudyField_ ) {
//		if (range.location == [[Util retrieveValidateConfigFromKey:@""] integerValue]) {
//            return NO;
//        }
//        
	} else if ( textField == txpFatherPinField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.txpFatherPin"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == txpMotherPinField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.txpMotherPin"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == spouseFatherPinField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseFatherPin"] integerValue]) {
            return NO;
        }
        
	} else if ( textField == spouseMotherPinField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.spouseMotherPin"] integerValue]) {
            return NO;
        }
        
	}
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    txtActiveEditing = nil;

    if ( textField == nameField_ ) {
		self.name = textField.text ;
        
	} else if ( textField == surnameField_) {
		self.surname = textField.text ;
        
	}  else if ( textField == telField_) {
		self.tel = textField.text ;
        
	}  else if ( textField == emailField_) {
		self.email = textField.text ;
        
	} else if ( textField == countryField_) {
		self.country = textField.text ;
        
	} else if ( textField == passportIdField_ ) {
		self.passportId = textField.text ;
        
	} else if ( textField == buildNameField_ ) {
		self.buildName = textField.text ;
        
	} else if ( textField == roomNoField_ ) {
		self.roomNo = textField.text ;
        
	} else if ( textField == floorNoField_ ) {
		self.floorNo = textField.text ;
        
	} else if ( textField == addressNoField_ ) {
		self.addressNo = textField.text ;
        
	} else if ( textField == soiField_ ) {
		self.soi = textField.text ;
        
	} else if ( textField == villageField_ ) {
		self.village = textField.text ;
        
	} else if ( textField == mooNoField_ ) {
		self.mooNo = textField.text ;
        
	} else if ( textField == streetField_ ) {
		self.street = textField.text ;
        
	} else if ( textField == tambolField_ ) {
		self.tambol = textField.text ;
        
	} else if ( textField == amphurField_ ) {
		self.amphur = textField.text ;
        
	} else if ( textField == provinceField_ ) {
		self.province = textField.text ;
        
	} else if ( textField == postcodeField_ ) {
		self.postcode = textField.text ;
        
	} else if ( textField == taxpayerStatusField_ ) {
		self.taxpayerStatus = textField.text ;
        
	} else if ( textField == spouseStatusField_ ) {
		self.spouseStatus = textField.text ;
        
	} else if ( textField == marryStatusField_ ) {
		self.marryStatus = textField.text ;
        
	} else if ( textField == spouseNidField_ ) {
		self.spouseNid = textField.text ;
        
	} else if ( textField == spouseNameField_ ) {
		self.spouseName = textField.text ;
        
	} else if ( textField == spouseSurnameField_ ) {
		self.spouseSurname = textField.text ;
        
	} else if ( textField == spouseBirthDateField_ ) {
		self.spouseBirthDate = textField.text ;
        
	} else if ( textField == spousePassportIdField_ ) {
		self.spousePassportId = textField.text ;
        
	} else if ( textField == spouseCountryField_ ) {
		self.spouseCountry = textField.text ;
        
	} else if ( textField == childNoStudyField_ ) {
		self.childNoStudy = textField.text ;
        
	} else if ( textField == childStudyField_ ) {
		self.childStudy = textField.text ;
        
	} else if ( textField == txpFatherPinField_ ) {
		self.txpFatherPin = textField.text ;
        
	} else if ( textField == txpMotherPinField_ ) {
		self.txpMotherPin = textField.text ;
        
	} else if ( textField == spouseFatherPinField_ ) {
		self.spouseFatherPin = textField.text ;
        
	} else if ( textField == spouseMotherPinField_ ) {
		self.spouseMotherPin = textField.text ;
        
	}
}

#pragma mark Table view data source
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
    sectionHeader.backgroundColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    sectionHeader.textAlignment = UITextAlignmentCenter;
    sectionHeader.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];

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
	
	UITextField* tf = nil ;
    
    textFieldModel = [Util loadViewWithNibName:@"TextFieldModel"];
    textFieldModel.frame = CGRectMake(0, 0, 320, 75);
    textFieldModel.layer.masksToBounds = YES;
    textFieldModel.pTxt.delegate = self;
    textFieldModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    textFieldModel.pTxt.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    [textFieldModel.pButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
    if (indexPath.section == 0) {
        textFieldModel.pTitle.text =[generalProfileArray objectAtIndex:indexPath.row];
        
        if ([[ShareUserDetail retrieveDataWithStringKey:@"thaiNation"] isEqualToString:@"1"]) {
            
            switch ( indexPath.row ) {
                case 0: {
                    
                    textFieldModel.pTxt.hidden = YES;
                    NSString *nid = [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"nid"]];
                    [textFieldModel addSubview:[FormUtil initLabelWithSubTitleText:nid]];
                    [cell addSubview:textFieldModel];
                    
                    break ;
                } case 1: {
                    textFieldModel.pTxt.text = self.name;
                    textFieldModel.pTxt.placeholder = [generalProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = nameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                } case 2: {
//                    tf = surnameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.surname placeholder:[generalProfilePlaceHolder objectAtIndex:indexPath.row]];
//                    tf.text = [ShareUserDetail retrieveDataWithStringKey:@"surname"];
//                    [cell addSubview:surnameField_];
                    
                    textFieldModel.pTxt.text = self.surname;
                    textFieldModel.pTxt.placeholder = [generalProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = surnameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                } case 3: {
//                    tf = telField_ = [FormUtil initTextFieldKeyboardTypePhoneWithText:self.tel placeholder:[generalProfilePlaceHolder objectAtIndex:indexPath.row]];
//                    tf.text = [ShareUserDetail retrieveDataWithStringKey:@"contractNo"];
//                    [cell addSubview:telField_];

                    textFieldModel.pTxt.text = self.tel;
                    textFieldModel.pTxt.placeholder = [generalProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypePhonePad;
                    textFieldModel.pButton.hidden = YES;
                    tf = telField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                } case 4: {
//                    tf = emailField_ = [FormUtil initTextFieldKeyboardTypeEmailWithText:self.email placeholder:[generalProfilePlaceHolder objectAtIndex:indexPath.row]];
//                    tf.text = [ShareUserDetail retrieveDataWithStringKey:@"email"];
//                    [cell addSubview:emailField_];
                    
                    textFieldModel.pTxt.text = self.email;
                    textFieldModel.pTxt.placeholder = [generalProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeEmailAddress;
                    textFieldModel.pButton.hidden = YES;
                    tf = emailField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
            }
            
        } else {
                    
            switch ( indexPath.row ) {
                case 0: {
                    textFieldModel.pTxt.hidden = YES;
                    NSString *nid = [TextFormatterUtil formatIdCard:[ShareUserDetail retrieveDataWithStringKey:@"nid"]];
                    [textFieldModel addSubview:[FormUtil initLabelWithSubTitleText:nid]];
                    [cell addSubview:textFieldModel];
                    break ;
                } case 1: {
//                    tf = nameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.name placeholder:[generalProfilePlaceHolder objectAtIndex:indexPath.row]];
//                    tf.text = [ShareUserDetail retrieveDataWithStringKey:@"name"];
//                    [cell addSubview:nameField_];
                    
                    textFieldModel.pTxt.text = self.name;
                    textFieldModel.pTxt.placeholder = [generalProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = nameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                } case 2: {
//                    tf = surnameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.surname placeholder:[generalProfilePlaceHolder objectAtIndex:indexPath.row]];
//                    tf.text = [ShareUserDetail retrieveDataWithStringKey:@"surname"];
//                    [cell addSubview:surnameField_];
                    
                    textFieldModel.pTxt.text = self.surname;
                    textFieldModel.pTxt.placeholder = [generalProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = surnameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                } case 3: {
//                    tf = passportIdField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.passportId placeholder:[generalProfilePlaceHolder objectAtIndex:indexPath.row]];
//                    tf.text = [ShareUserDetail retrieveDataWithStringKey:@"passportNo"];
//                    [cell addSubview:passportIdField_];

                    textFieldModel.pTxt.text = self.passportId;
                    textFieldModel.pTxt.placeholder = [generalProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                    textFieldModel.pButton.hidden = YES;
                    tf = passportIdField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                } case 4: {
//                    tf = countryField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.country placeholder:[generalProfilePlaceHolder objectAtIndex:indexPath.row]];
//                    tf.text = [ShareUserDetail retrieveDataWithStringKey:@"countryCode"];
//                    [cell addSubview:countryField_];

                    textFieldModel.pTxt.text = self.country;
                    textFieldModel.pTxt.placeholder = [generalProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = countryField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                } case 5: {
//                    tf = telField_ = [FormUtil initTextFieldKeyboardTypePhoneWithText:self.tel placeholder:[generalProfilePlaceHolder objectAtIndex:indexPath.row]];
//                    tf.text = [ShareUserDetail retrieveDataWithStringKey:@"contractNo"];
//                    [cell addSubview:telField_];
                    
                    textFieldModel.pTxt.text = self.tel;
                    textFieldModel.pTxt.placeholder = [generalProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypePhonePad;
                    textFieldModel.pButton.hidden = YES;
                    tf = telField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                } case 6: {
//                    tf = emailField_ = [FormUtil initTextFieldKeyboardTypeEmailWithText:self.email placeholder:[generalProfilePlaceHolder objectAtIndex:indexPath.row]];
//                    tf.text = [ShareUserDetail retrieveDataWithStringKey:@"email"];
//                    [cell addSubview:emailField_];
                    
                    textFieldModel.pTxt.text = self.email;
                    textFieldModel.pTxt.placeholder = [generalProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeEmailAddress;
                    textFieldModel.pButton.hidden = YES;
                    tf = emailField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
            }
            
        }
        
    } else if (indexPath.section == 1) {
        
        textFieldModel.pTitle.text = [addressArray objectAtIndex:indexPath.row];
        switch ( indexPath.row ) {
            case 0: {
//                tf = buildNameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.buildName placeholder:[addressPlaceHolder objectAtIndex:indexPath.row]];
//                tf.text = [ShareUserDetail retrieveDataWithStringKey:@"buildName"];
//                [cell addSubview:buildNameField_];
                

                textFieldModel.pTxt.text = self.buildName;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = buildNameField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
                
            } case 1: {
//                tf = roomNoField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.roomNo placeholder:[addressPlaceHolder objectAtIndex:indexPath.row]];
//                tf.text = [ShareUserDetail retrieveDataWithStringKey:@"roomNo"];
//                [cell addSubview:roomNoField_];
                
                textFieldModel.pTxt.text = self.roomNo;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = roomNoField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
                
            } case 2: {
//                tf = floorNoField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.floorNo placeholder:[addressPlaceHolder objectAtIndex:indexPath.row]];
//                tf.text = [ShareUserDetail retrieveDataWithStringKey:@"floorNo"];
//                [cell addSubview:floorNoField_];
                
                textFieldModel.pTxt.text = self.floorNo;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = floorNoField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
                
            } case 3: {
//                tf = addressNoField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.addressNo placeholder:[addressPlaceHolder objectAtIndex:indexPath.row]];
//                tf.text = [ShareUserDetail retrieveDataWithStringKey:@"addressNo"];
//                [cell addSubview:addressNoField_];
                

                textFieldModel.pTxt.text = self.addressNo;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = addressNoField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
                
            } case 4: {
//                tf = soiField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.soi placeholder:[addressPlaceHolder objectAtIndex:indexPath.row]];
//                tf.text = [ShareUserDetail retrieveDataWithStringKey:@"soi"];
//                [cell addSubview:soiField_];
                
                textFieldModel.pTxt.text = self.soi;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = soiField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
                
            } case 5: {
//                tf = villageField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.village placeholder:[addressPlaceHolder objectAtIndex:indexPath.row]];
//                tf.text = [ShareUserDetail retrieveDataWithStringKey:@"village"];
//                [cell addSubview:villageField_];
                

                textFieldModel.pTxt.text = self.village;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = villageField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
                
            } case 6: {
//                tf = mooNoField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.mooNo placeholder:[addressPlaceHolder objectAtIndex:indexPath.row]];
//                tf.text = [ShareUserDetail retrieveDataWithStringKey:@"mooNo"];
//                [cell addSubview:mooNoField_];
                
                textFieldModel.pTxt.text = self.mooNo;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = mooNoField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
                
            } case 7: {
//                tf = streetField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.street placeholder:[addressPlaceHolder objectAtIndex:indexPath.row]];
//                tf.text = [ShareUserDetail retrieveDataWithStringKey:@"street"];
//                [cell addSubview:streetField_];
                

                textFieldModel.pTxt.text = self.street;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = streetField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
                
            } case 8: {
//                tf = provinceField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.province placeholder:[addressPlaceHolder objectAtIndex:indexPath.row]];
//                tf.text = [ShareUserDetail retrieveDataWithStringKey:@"province"];
//                [cell addSubview:provinceField_];
                
                textFieldModel.pTxt.text = self.province;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = provinceField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
                
            } case 9: {
//                tf = amphurField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.amphur placeholder:[addressPlaceHolder objectAtIndex:indexPath.row]];
//                tf.text = [ShareUserDetail retrieveDataWithStringKey:@"amphur"];
//                [cell addSubview:amphurField_];
                
                textFieldModel.pTxt.text = self.amphur;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = amphurField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
                
            } case 10: {
//                tf = tambolField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.tambol placeholder:[addressPlaceHolder objectAtIndex:indexPath.row]];
//                tf.text = [ShareUserDetail retrieveDataWithStringKey:@"tambol"];
//                [cell addSubview:tambolField_];
                

                textFieldModel.pTxt.text = self.tambol;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = tambolField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
                
            } case 11: {
//                tf = postcodeField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.postcode placeholder:[addressPlaceHolder objectAtIndex:indexPath.row]];
//                tf.text = [ShareUserDetail retrieveDataWithStringKey:@"postcode"];
//                [cell addSubview:postcodeField_];
                
                textFieldModel.pTxt.text = self.postcode;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                textFieldModel.pButton.hidden = YES;
                tf = postcodeField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
                
            }
        }
        
    } else {
        textFieldModel.pTitle.text = [reduceStatusArray objectAtIndex:indexPath.row];
        
        //-- Thai
        if ([[ShareUserDetail retrieveDataWithStringKey:@"thaiNation"] isEqualToString:@"1"]) {
            
            //-- Single and devorce
            if ([[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"0"] || [[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"3"]) {
                
                // #1
                
                switch ( indexPath.row ) {
                    case 0: {
//                        tf = taxpayerStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.taxpayerStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                        tf.text = [ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"];
//                        [cell addSubview:taxpayerStatusField_];
                        
                        textFieldModel.pTxt.text = self.taxpayerStatus;
                        textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                        textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                        textFieldModel.pButton.hidden = YES;
                        tf = taxpayerStatusField_ = textFieldModel.pTxt;
                        [cell addSubview:textFieldModel];
                        
                        break ;
                        
                    } case 1: {
//                        tf = txpFatherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.txpFatherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                        tf.text = [ShareUserDetail retrieveDataWithStringKey:@"txpFatherPin"];
//                        [cell addSubview:txpFatherPinField_];
                        
                        textFieldModel.pTxt.text = self.txpFatherPin;
                        textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                        textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                        textFieldModel.pButton.hidden = YES;
                        tf = txpFatherPinField_ = textFieldModel.pTxt;
                        [cell addSubview:textFieldModel];
                        

                        break ;
                        
                    } case 2: {
//                        tf = txpMotherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.txpMotherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                        tf.text = [ShareUserDetail retrieveDataWithStringKey:@"txpMotherPin"];
//                        [cell addSubview:txpMotherPinField_];
                        
                        textFieldModel.pTxt.text = self.txpMotherPin;
                        textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                        textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                        textFieldModel.pButton.hidden = YES;
                        tf = txpMotherPinField_ = textFieldModel.pTxt;
                        [cell addSubview:textFieldModel];
                        

                        break ;
                        
                    } case 3: {
//                        tf = childNoStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childNoStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                        tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childNoStudy"];
//                        [cell addSubview:childNoStudyField_];
                        
                        
                        textFieldModel.pTxt.text = self.childNoStudy;
                        textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                        textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                        textFieldModel.pButton.hidden = YES;
                        tf = childNoStudyField_ = textFieldModel.pTxt;
                        [cell addSubview:textFieldModel];
                        

                        break ;
                        
                    } case 4: {
//                        tf = childStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                        tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childStudy"];
//                        [cell addSubview:childStudyField_];
                        

                        textFieldModel.pTxt.text = self.childStudy;
                        textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                        textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                        textFieldModel.pButton.hidden = YES;
                        tf = childStudyField_ = textFieldModel.pTxt;
                        [cell addSubview:textFieldModel];

                        break ;
                        
                    }
                }
                
            //-- Marry Thai
            } else if ([[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"1"]) {
                
                //-- have salary
                if ([[ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"] isEqualToString:@"1"]) {
                    
                    // #3
                    switch ( indexPath.row ) {
                        case 0: {
//                            tf = taxpayerStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.taxpayerStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"];
//                            [cell addSubview:taxpayerStatusField_];
                            

                            textFieldModel.pTxt.text = self.taxpayerStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = taxpayerStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 1: {
//                            tf = marryStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.marryStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"marryStatus"];
//                            [cell addSubview:marryStatusField_];
                            

                            textFieldModel.pTxt.text = self.marryStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = marryStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                         
                        } case 2: {
//                            tf = spouseStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"];
//                            [cell addSubview:spouseStatusField_];
                            

                            textFieldModel.pTxt.text = self.spouseStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 3: {
//                            tf = spouseNidField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spouseNid placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseNid"];
//                            [cell addSubview:spouseNidField_];
                            

                            textFieldModel.pTxt.text = self.spouseNid;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNidField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 4: {
//                            tf = spouseNameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseName placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseName"];
//                            [cell addSubview:spouseNameField_];


                            textFieldModel.pTxt.text = self.spouseName;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 5: {
//                            tf = spouseSurnameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseSurname placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseSurname"];
//                            [cell addSubview:spouseSurnameField_];
                            

                            textFieldModel.pTxt.text = self.spouseSurname;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseSurnameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 6: {
//                            tf = spouseBirthDateField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseBirthDate placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseBirthDate"];
//                            [cell addSubview:spouseBirthDateField_];
                            

                            textFieldModel.pTxt.text = self.spouseBirthDate;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseBirthDateField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 7: {
//                            tf = txpFatherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.txpFatherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"txpFatherPin"];
//                            [cell addSubview:txpFatherPinField_];
                            

                            textFieldModel.pTxt.text = self.txpFatherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = txpFatherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 8: {
//                            tf = txpMotherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.txpMotherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"txpMotherPin"];
//                            [cell addSubview:txpMotherPinField_];
                            

                            textFieldModel.pTxt.text = self.txpMotherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = txpMotherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 9: {
//                            tf = childNoStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childNoStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childNoStudy"];
//                            [cell addSubview:childNoStudyField_];
                            

                            textFieldModel.pTxt.text = self.childNoStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childNoStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 10: {
//                            tf = childStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childStudy"];
//                            [cell addSubview:childStudyField_];
                            

                            textFieldModel.pTxt.text = self.childStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        }
                    }
                    
                } else {
                    
                    // #4
                    switch ( indexPath.row ) {
                        case 0: {
//                            tf = taxpayerStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.taxpayerStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"];
//                            [cell addSubview:taxpayerStatusField_];
                            

                            textFieldModel.pTxt.text = self.taxpayerStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = taxpayerStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 1: {
//                            tf = marryStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.marryStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"marryStatus"];
//                            [cell addSubview:marryStatusField_];
                            

                            textFieldModel.pTxt.text = self.marryStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = marryStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 2: {
//                            tf = spouseStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"];
//                            [cell addSubview:spouseStatusField_];
                            

                            textFieldModel.pTxt.text = self.spouseStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 3: {
//                            tf = spouseNidField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spouseNid placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseNid"];
//                            [cell addSubview:spouseNidField_];
                            

                            textFieldModel.pTxt.text = self.spouseNid;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNidField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 4: {
//                            tf = spouseNameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseName placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseName"];
//                            [cell addSubview:spouseNameField_];
                            

                            textFieldModel.pTxt.text = self.spouseName;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 5: {
//                            tf = spouseSurnameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseSurname placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseSurname"];
//                            [cell addSubview:spouseSurnameField_];
                            

                            textFieldModel.pTxt.text = self.spouseSurname;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseSurnameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 6: {
//                            tf = spouseBirthDateField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseBirthDate placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseBirthDate"];
//                            [cell addSubview:spouseBirthDateField_];
                            

                            textFieldModel.pTxt.text = self.spouseBirthDate;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseBirthDateField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 7: {
//                            tf = txpFatherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.txpFatherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"txpFatherPin"];
//                            [cell addSubview:txpFatherPinField_];
                            

                            textFieldModel.pTxt.text = self.txpFatherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = txpFatherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 8: {
//                            tf = txpMotherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.txpMotherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"txpMotherPin"];
//                            [cell addSubview:txpMotherPinField_];
                            

                            textFieldModel.pTxt.text = self.txpMotherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = txpMotherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                         
                        } case 9: {
//                            tf = spouseMotherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spouseMotherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseMotherPin"];
//                            [cell addSubview:spouseMotherPinField_];
                            

                            textFieldModel.pTxt.text = self.spouseMotherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseMotherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 10: {
//                            tf = spouseFatherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spouseFatherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseFatherPin"];
//                            [cell addSubview:spouseFatherPinField_];
                            

                            textFieldModel.pTxt.text = self.spouseFatherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseFatherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 11: {
//                            tf = childNoStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childNoStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childNoStudy"];
//                            [cell addSubview:childNoStudyField_];
                            

                            textFieldModel.pTxt.text = self.childNoStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childNoStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 12: {
//                            tf = childStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childStudy"];
//                            [cell addSubview:childStudyField_];
                            

                            textFieldModel.pTxt.text = self.childStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        }
                    }
                }
                
                
                //-- Marry Eng
            } else {
                
                //-- have salary
                if ([[ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"] isEqualToString:@"1"]) {
                    
                    // #5
                    switch ( indexPath.row ) {
                        case 0: {
//                            tf = taxpayerStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.taxpayerStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"];
//                            [cell addSubview:taxpayerStatusField_];
                            

                            textFieldModel.pTxt.text = self.taxpayerStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = taxpayerStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 1: {
//                            tf = marryStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.marryStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"marryStatus"];
//                            [cell addSubview:marryStatusField_];
                            

                            textFieldModel.pTxt.text = self.marryStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = marryStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 2: {
//                            tf = spouseStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"];
//                            [cell addSubview:spouseStatusField_];
                            

                            textFieldModel.pTxt.text = self.spouseStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 3: {
//                            tf = spouseNidField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spouseNid placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseNid"];
//                            [cell addSubview:spouseNidField_];
                            

                            textFieldModel.pTxt.text = self.spouseNid;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNidField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 4: {
//                            tf = spouseNameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseName placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseName"];
//                            [cell addSubview:spouseNameField_];
                            

                            textFieldModel.pTxt.text = self.spouseName;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 5: {
//                            tf = spouseSurnameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseSurname placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseSurname"];
//                            [cell addSubview:spouseSurnameField_];
                            

                            textFieldModel.pTxt.text = self.spouseSurname;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseSurnameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 6: {
//                            tf = spouseBirthDateField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseBirthDate placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseBirthDate"];
//                            [cell addSubview:spouseBirthDateField_];
                            

                            textFieldModel.pTxt.text = self.spouseBirthDate;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseBirthDateField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 7: {
//                            tf = txpFatherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.txpFatherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"txpFatherPin"];
//                            [cell addSubview:txpFatherPinField_];
                            

                            textFieldModel.pTxt.text = self.txpFatherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = txpFatherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 8: {
//                            tf = txpMotherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.txpMotherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"txpMotherPin"];
//                            [cell addSubview:txpMotherPinField_];
                            

                            textFieldModel.pTxt.text = self.txpMotherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = txpMotherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 9: {
//                            tf = childNoStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childNoStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childNoStudy"];
//                            [cell addSubview:childNoStudyField_];
                            

                            textFieldModel.pTxt.text = self.childNoStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childNoStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 10: {
//                            tf = childStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childStudy"];
//                            [cell addSubview:childStudyField_];
                            

                            textFieldModel.pTxt.text = self.childStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        }
                    }
                    
                } else {
                    
                    // #6
                    switch ( indexPath.row ) {
                        case 0: {
//                            tf = taxpayerStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.taxpayerStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"];
//                            [cell addSubview:taxpayerStatusField_];


                            textFieldModel.pTxt.text = self.taxpayerStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = taxpayerStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 1: {
//                            tf = marryStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.marryStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"marryStatus"];
//                            [cell addSubview:marryStatusField_];
                            

                            textFieldModel.pTxt.text = self.marryStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = marryStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 2: {
//                            tf = spouseStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"];
//                            [cell addSubview:spouseStatusField_];
                            

                            textFieldModel.pTxt.text = self.spouseStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 3: {
//                            tf = spouseNameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseName placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseName"];
//                            [cell addSubview:spouseNameField_];
                            

                            textFieldModel.pTxt.text = self.spouseName;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 4: {
//                            tf = spouseSurnameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseSurname placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseSurname"];
//                            [cell addSubview:spouseSurnameField_];
                            

                            textFieldModel.pTxt.text = self.spouseSurname;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseSurnameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 5: {
//                            tf = spouseBirthDateField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseBirthDate placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseBirthDate"];
//                            [cell addSubview:spouseBirthDateField_];
                            

                            textFieldModel.pTxt.text = self.spouseBirthDate;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseBirthDateField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                        
                        } case 6: {
//                            tf = spousePassportIdField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spousePassportId placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spousePassportId"];
//                            [cell addSubview:spousePassportIdField_];


                            textFieldModel.pTxt.text = self.spousePassportId;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spousePassportIdField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 7: {
//                            tf = spouseCountryField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseCountry placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseCountry"];
//                            [cell addSubview:spouseCountryField_];
                            

                            textFieldModel.pTxt.text = self.spouseCountry;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseCountryField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 8: {
//                            tf = txpFatherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.txpFatherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"txpFatherPin"];
//                            [cell addSubview:txpFatherPinField_];
                            

                            textFieldModel.pTxt.text = self.txpFatherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = txpFatherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 9: {
//                            tf = txpMotherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.txpMotherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"txpMotherPin"];
//                            [cell addSubview:txpMotherPinField_];
                            

                            textFieldModel.pTxt.text = self.txpMotherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = txpMotherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 10: {
//                            tf = childNoStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childNoStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childNoStudy"];
//                            [cell addSubview:childNoStudyField_];


                            textFieldModel.pTxt.text = self.childNoStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childNoStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 11: {
//                            tf = childStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childStudy"];
//                            [cell addSubview:childStudyField_];


                            textFieldModel.pTxt.text = self.childStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        }
                    }
                }
                
            }
            
            //-- Eng
        } else {
            
            //-- Single and devorce
            if ([[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"0"] || [[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"3"]) {
                
                // #2
                switch ( indexPath.row ) {
                    case 0: {
//                        tf = taxpayerStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.taxpayerStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                        tf.text = [ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"];
//                        [cell addSubview:taxpayerStatusField_];
                        

                        textFieldModel.pTxt.text = self.taxpayerStatus;
                        textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                        textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                        textFieldModel.pButton.hidden = YES;
                        tf = taxpayerStatusField_ = textFieldModel.pTxt;
                        [cell addSubview:textFieldModel];
                        
                        break ;
                        
                    } case 1: {
//                        tf = childNoStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childNoStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                        tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childNoStudy"];
//                        [cell addSubview:childNoStudyField_];
                        

                        textFieldModel.pTxt.text = self.childNoStudy;
                        textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                        textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                        textFieldModel.pButton.hidden = YES;
                        tf = childNoStudyField_ = textFieldModel.pTxt;
                        [cell addSubview:textFieldModel];
                        
                        break ;
                        
                    } case 2: {
//                        tf = childStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                        tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childStudy"];
//                        [cell addSubview:childStudyField_];
                        

                        textFieldModel.pTxt.text = self.childStudy;
                        textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                        textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                        textFieldModel.pButton.hidden = YES;
                        tf = childStudyField_ = textFieldModel.pTxt;
                        [cell addSubview:textFieldModel];
                        
                        break ;
                        
                    }
                }
                
            //-- Marry Thai
            } else if ([[ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"] isEqualToString:@"1"]) {
                
                //-- have salary
                if ([[ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"] isEqualToString:@"1"]) {
                    
                    // #7
                    switch ( indexPath.row ) {
                        case 0: {
//                            tf = taxpayerStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.taxpayerStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"];
//                            [cell addSubview:taxpayerStatusField_];
                            

                            textFieldModel.pTxt.text = self.taxpayerStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = taxpayerStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 1: {
//                            tf = marryStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.marryStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"marryStatus"];
//                            [cell addSubview:marryStatusField_];

                            

                            textFieldModel.pTxt.text = self.marryStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = marryStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 2: {
//                            tf = spouseStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"];
//                            [cell addSubview:spouseStatusField_];
                            

                            textFieldModel.pTxt.text = self.spouseStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 3: {
//                            tf = spouseNidField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spouseNid placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseNid"];
//                            [cell addSubview:spouseNidField_];

                            

                            textFieldModel.pTxt.text = self.spouseNid;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNidField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;

                        } case 4: {
//                            tf = spouseNameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseName placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseName"];
//                            [cell addSubview:spouseNameField_];
                            

                            textFieldModel.pTxt.text = self.spouseName;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 5: {
//                            tf = spouseSurnameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseSurname placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseSurname"];
//                            [cell addSubview:spouseSurnameField_];

                            

                            textFieldModel.pTxt.text = self.spouseSurname;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseSurnameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 6: {
//                            tf = spouseBirthDateField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseBirthDate placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseBirthDate"];
//                            [cell addSubview:spouseBirthDateField_];
                            

                            textFieldModel.pTxt.text = self.spouseBirthDate;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseBirthDateField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 7: {
//                            tf = spousePassportIdField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spousePassportId placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spousePassportId"];
//                            [cell addSubview:spousePassportIdField_];
                            

                            textFieldModel.pTxt.text = self.spousePassportId;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spousePassportIdField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 8: {
//                            tf = spouseCountryField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseCountry placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseCountry"];
//                            [cell addSubview:spouseCountryField_];
                            

                            textFieldModel.pTxt.text = self.spouseCountry;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseCountryField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 9: {
//                            tf = childNoStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childNoStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childNoStudy"];
//                            [cell addSubview:childNoStudyField_];
                            

                            textFieldModel.pTxt.text = self.childNoStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childNoStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 10: {
//                            tf = childStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childStudy"];
//                            [cell addSubview:childStudyField_];
                            

                            textFieldModel.pTxt.text = self.childStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        }
                    }
                    
                } else {
                    
                    // #8
                    switch ( indexPath.row ) {
                        case 0: {
//                            tf = taxpayerStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.taxpayerStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"];
//                            [cell addSubview:taxpayerStatusField_];
                            

                            textFieldModel.pTxt.text = self.taxpayerStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = taxpayerStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 1: {
//                            tf = marryStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.marryStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"marryStatus"];
//                            [cell addSubview:marryStatusField_];
                            

                            textFieldModel.pTxt.text = self.marryStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = marryStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 2: {
//                            tf = spouseStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"];
//                            [cell addSubview:spouseStatusField_];
                            

                            textFieldModel.pTxt.text = self.spouseStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 3: {
//                            tf = spouseNidField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spouseNid placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseNid"];
//                            [cell addSubview:spouseNidField_];
                            

                            textFieldModel.pTxt.text = self.spouseNid;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNidField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 4: {
//                            tf = spouseNameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseName placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseName"];
//                            [cell addSubview:spouseNameField_];
                            

                            textFieldModel.pTxt.text = self.spouseName;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 5: {
//                            tf = spouseSurnameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseSurname placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseSurname"];
//                            [cell addSubview:spouseSurnameField_];
                            

                            textFieldModel.pTxt.text = self.spouseSurname;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseSurnameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 6: {
//                            tf = spouseBirthDateField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseBirthDate placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseBirthDate"];
//                            [cell addSubview:spouseBirthDateField_];
                            

                            textFieldModel.pTxt.text = self.spouseBirthDate;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseBirthDateField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 7: {
//                            tf = spousePassportIdField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spousePassportId placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spousePassportId"];
//                            [cell addSubview:spousePassportIdField_];
                            

                            textFieldModel.pTxt.text = self.spousePassportId;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spousePassportIdField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 8: {
//                            tf = spouseCountryField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseCountry placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseCountry"];
//                            [cell addSubview:spouseCountryField_];
                            

                            textFieldModel.pTxt.text = self.spouseCountry;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseCountryField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                        
                        } case 9: {
//                            tf = spouseMotherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spouseMotherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseMotherPin"];
//                            [cell addSubview:spouseMotherPinField_];
                            

                            textFieldModel.pTxt.text = self.spouseMotherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseMotherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 10: {
//                            tf = spouseFatherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spouseFatherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseFatherPin"];
//                            [cell addSubview:spouseFatherPinField_];
                            

                            textFieldModel.pTxt.text = self.spouseFatherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseFatherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 11: {
//                            tf = childNoStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childNoStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childNoStudy"];
//                            [cell addSubview:childNoStudyField_];
                            

                            textFieldModel.pTxt.text = self.childNoStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childNoStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 12: {
//                            tf = childStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childStudy"];
//                            [cell addSubview:childStudyField_];
                            

                            textFieldModel.pTxt.text = self.childStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        }
                    }
                }
                
                
                //-- Marry Eng
            } else {
                
                //-- have salary
                if ([[ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"] isEqualToString:@"1"]) {
                    
                    // #9
                    switch ( indexPath.row ) {
                        case 0: {
//                            tf = taxpayerStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.taxpayerStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"];
//                            [cell addSubview:taxpayerStatusField_];
                            

                            textFieldModel.pTxt.text = self.taxpayerStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = taxpayerStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 1: {
//                            tf = marryStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.marryStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"marryStatus"];
//                            [cell addSubview:marryStatusField_];
                            

                            textFieldModel.pTxt.text = self.marryStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = marryStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 2: {
//                            tf = spouseStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"];
//                            [cell addSubview:spouseStatusField_];
                            

                            textFieldModel.pTxt.text = self.spouseStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 3: {
//                            tf = spouseNidField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spouseNid placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseNid"];
//                            [cell addSubview:spouseNidField_];
                            

                            textFieldModel.pTxt.text = self.spouseNid;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNidField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 4: {
//                            tf = spouseNameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseName placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseName"];
//                            [cell addSubview:spouseNameField_];
                            

                            textFieldModel.pTxt.text = self.spouseName;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 5: {
//                            tf = spouseSurnameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseSurname placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseSurname"];
//                            [cell addSubview:spouseSurnameField_];
                            

                            textFieldModel.pTxt.text = self.spouseSurname;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseSurnameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 6: {
//                            tf = spouseBirthDateField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseBirthDate placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseBirthDate"];
//                            [cell addSubview:spouseBirthDateField_];
                            

                            textFieldModel.pTxt.text = self.spouseBirthDate;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseBirthDateField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 7: {
//                            tf = spousePassportIdField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spousePassportId placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spousePassportId"];
//                            [cell addSubview:spousePassportIdField_];
                            

                            textFieldModel.pTxt.text = self.spousePassportId;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spousePassportIdField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 8: {
//                            tf = spouseCountryField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseCountry placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseCountry"];
//                            [cell addSubview:spouseCountryField_];
                            

                            textFieldModel.pTxt.text = self.spouseCountry;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseCountryField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 9: {
//                            tf = childNoStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childNoStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childNoStudy"];
//                            [cell addSubview:childNoStudyField_];
                            

                            textFieldModel.pTxt.text = self.childNoStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childNoStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 10: {
//                            tf = childStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childStudy"];
//                            [cell addSubview:childStudyField_];
                            

                            textFieldModel.pTxt.text = self.childStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        }
                    }
                    
                } else {
                    
                    // #10
                    switch ( indexPath.row ) {
                        case 0: {
//                            tf = taxpayerStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.taxpayerStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"taxpayerStatus"];
 //                            [cell addSubview:taxpayerStatusField_];
                            

                            textFieldModel.pTxt.text = self.taxpayerStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = taxpayerStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 1: {
//                            tf = marryStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.marryStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"marryStatus"];
//                            [cell addSubview:marryStatusField_];
                            

                            textFieldModel.pTxt.text = self.marryStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = marryStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 2: {
//                            tf = spouseStatusField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseStatus placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseStatus"];
//                            [cell addSubview:spouseStatusField_];
                            

                            textFieldModel.pTxt.text = self.spouseStatus;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseStatusField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 3: {
//                            tf = spouseNameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseName placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseName"];
//                            [cell addSubview:spouseNameField_];
                            

                            textFieldModel.pTxt.text = self.spouseName;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseNameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 4: {
//                            tf = spouseSurnameField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseSurname placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseSurname"];
//                            [cell addSubview:spouseSurnameField_];
                            

                            textFieldModel.pTxt.text = self.spouseSurname;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseSurnameField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 5: {
//                            tf = spouseBirthDateField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseBirthDate placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseBirthDate"];
//                            [cell addSubview:spouseBirthDateField_];
                            

                            textFieldModel.pTxt.text = self.spouseBirthDate;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseBirthDateField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 6: {
//                            tf = spousePassportIdField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.spousePassportId placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spousePassportId"];
//                            [cell addSubview:spousePassportIdField_];
                            

                            textFieldModel.pTxt.text = self.spousePassportId;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = spousePassportIdField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 7: {
//                            tf = spouseCountryField_ = [FormUtil initTextFieldKeyboardTypeTextWithText:self.spouseCountry placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"spouseCountry"];
//                            [cell addSubview:spouseCountryField_];
                            

                            textFieldModel.pTxt.text = self.spouseCountry;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                            textFieldModel.pButton.hidden = YES;
                            tf = spouseCountryField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 8: {
//                            tf = txpFatherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.txpFatherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"txpFatherPin"];
//                            [cell addSubview:txpFatherPinField_];
                            

                            textFieldModel.pTxt.text = self.txpFatherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = txpFatherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 9: {
//                            tf = txpMotherPinField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.txpMotherPin placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"txpMotherPin"];
//                            [cell addSubview:txpMotherPinField_];
                            

                            textFieldModel.pTxt.text = self.txpMotherPin;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = txpMotherPinField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 10: {
//                            tf = childNoStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childNoStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childNoStudy"];
//                            [cell addSubview:childNoStudyField_];
                            

                            textFieldModel.pTxt.text = self.childNoStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childNoStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        } case 11: {
//                            tf = childStudyField_ = [FormUtil initTextFieldKeyboardTypeNumberWithText:self.childStudy placeholder:[reduceStatusPlaceHolder objectAtIndex:indexPath.row]];
//                            tf.text = [ShareUserDetail retrieveDataWithStringKey:@"childStudy"];
//                            [cell addSubview:childStudyField_];
                            

                            textFieldModel.pTxt.text = self.childStudy;
                            textFieldModel.pTxt.placeholder = [reduceStatusPlaceHolder objectAtIndex:indexPath.row];
                            textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                            textFieldModel.pButton.hidden = YES;
                            tf = childStudyField_ = textFieldModel.pTxt;
                            [cell addSubview:textFieldModel];
                            
                            break ;
                            
                        }
                    }
                }
                
            }
        }
        
    }
    
    NSInteger sectionsAmount = [tableView numberOfSections];
    NSInteger rowsAmount = [tableView numberOfRowsInSection:[indexPath section]];
    if ([indexPath section] == sectionsAmount - 1 && [indexPath row] == rowsAmount - 1) {
        UIButton *bt = [FormUtil initNextButtonWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Save"]];
        [bt addTarget:self action:@selector(onSaveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:bt];
    }
    
    [tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    tf.delegate = self ;
    
    return cell;
}

- (void) onSaveButtonClicked :(UIButton*)button {


    if ([self validateField]) {
        
    }
    
}

- (BOOL) validateField {
    
    if ([Util validateEmptyFieldWithString:self.name]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.surname]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.passportId]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.country]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.roomNo]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.tambol]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.amphur]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.province]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.postcode]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.tel]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.email]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.taxpayerStatus]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseStatus]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.marryStatus]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseNid]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseName]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseSurname]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseBirthDate]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spousePassportId]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseCountry]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.childNoStudy]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.childStudy]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.txpFatherPin]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.txpMotherPin]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseFatherPin]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else if ([Util validateEmptyFieldWithString:self.spouseMotherPin]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    } else {
        return YES;
    }
}

- (IBAction)textFieldFinished:(id)sender {
    [sender resignFirstResponder];
}

#pragma - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma - call service
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
                                                  taxpayerStatus:self.taxpayerStatus
                                                    spouseStatus:self.spouseStatus
                                                     marryStatus:self.marryStatus
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

#pragma - Response Delegate
- (void) responseENUpdateProfileService:(NSData *)data {
    
}

@end
