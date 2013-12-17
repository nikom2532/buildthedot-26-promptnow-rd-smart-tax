//
//  EfilingRegisterConfirmViewController.h
//  RDSmartTax
//
//  Created by Noi on 12/7/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "ENRegisterConfirmService.h"

@interface EfilingRegisterConfirmViewController : KeyboardViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, ENRegisterConfirmServiceDelegate> {

NSString* buildName_ ;
NSString* roomNo_ ;
NSString* floorNo_ ;
NSString* addressNo_ ;
NSString* soi_ ;
NSString* village_ ;
NSString* mooNo_ ;
NSString* street ;
NSString* tumbol_ ;
NSString* amphur_ ;
NSString* province_ ;
NSString* postcode_ ;
//NSString* contractNo_ ;

UITextField* buildNameField_ ;
UITextField* roomNoField_ ;
UITextField* floorNoField_ ;
UITextField* addressNoField_ ;
UITextField* soiField_ ;
UITextField* villageField_ ;
UITextField* mooNoField_ ;
UITextField* streetField_ ;
UITextField* tumbonField_ ;
UITextField* amphurField_ ;
UITextField* provinceField_ ;
UITextField* postcodeField_ ;
//UITextField* contractNoField_ ;

NSMutableArray *dataArray;
UITextField *txtActiveEditing;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,copy) NSString *pNid;
@property(nonatomic,copy) NSString *pBuildName;
@property(nonatomic,copy) NSString *pRoomNo;
@property(nonatomic,copy) NSString *pFloorNo;
@property(nonatomic,copy) NSString *pAddressNo;
@property(nonatomic,copy) NSString *pSoi;
@property(nonatomic,copy) NSString *pVillage;
@property(nonatomic,copy) NSString *pMooNo;
@property(nonatomic,copy) NSString *pStreet;
@property(nonatomic,copy) NSString *pTumbol;
@property(nonatomic,copy) NSString *pAmphur;
@property(nonatomic,copy) NSString *pProvince;
@property(nonatomic,copy) NSString *pPostcode;
@property(nonatomic,copy) NSString *pContractNo;
@property(nonatomic,copy) NSString *pVersion;

- (IBAction)clicked:(id)sender;
@end
