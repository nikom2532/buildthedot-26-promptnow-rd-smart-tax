//
//  EfilingRegisterConfirmViewController.m
//  RDSmartTax
//
//  Created by Noi on 12/7/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingRegisterConfirmViewController.h"
#import "EfilingValidatePasswordViewController.h"
#import "EfilingCheckNewUserViewController.h"

#import "TextFieldModel.h"
#import "DatePickerModel.h"
#import "DropdownViewModel.h"

#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"

@interface EfilingRegisterConfirmViewController (){
    ENRegisterConfirmService *enRegisterConfirmService;
    NSLocale *currentLocale;
    
    // dropdown question
    NSMutableArray *provinceHashArray;
    NSMutableArray *amphurHashArray;
    NSMutableArray *tambonHashArray;
    
    NSString *defaultQuestion;
    NSString *currentQuestion;

    
    NSArray *addressArray;
    NSArray *addressPlaceHolder;
    
    TextFieldModel *textFieldModel;
    DatePickerModel *datePickerModel;
    DropdownViewModel *dropdownViewModel;
    UIPickerView *dropDownPickerView;
    UIActionSheet *dropDownActionSheet;
    UIButton *currentButton;
    NSString *response;
}

@end

@implementation EfilingRegisterConfirmViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    dataArray = [[NSMutableArray alloc] init];
    //------------------------------- Value Login Detail ----------------------------------------------------------
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
                    @"",
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
                          [Util stringWithScreenName:@"Common" labelName:@"Postcode"],nil];
    
    NSDictionary *addressArrayDic = [NSDictionary dictionaryWithObject:addressArray forKey:@"data"];
    [dataArray addObject:addressArrayDic];
    
    //-- Add Tap Gesture -----------------------------------------------------
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    // disable gap at the top of tableview
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createHeader];
}
-(void) createHeader{
    self.navigationController.navigationBar.hidden = YES;
    Header *header = [Util loadViewWithNibName:@"Header"];
    header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    header.pLabel.text = [Util stringWithScreenName:@"Login" labelName:@"ForgetPassword"];
    [header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    header.pRightButton.hidden = YES;
    [self.view addSubview:header];
    
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
    
    if ( textField == buildNameField_ ) {
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
        
	} else if ( textField ==  tumbonField_) {
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
        
    }
    //    else if ( textField == contractNoField_ ) {
    //        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.contractNo"] integerValue]) {
    //            return NO;
    //        }
    //    }
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    txtActiveEditing = nil;
    if ( textField == buildNameField_ ) {
		self.pBuildName = textField.text ;
        
	} else if ( textField == roomNoField_ ) {
		self.pRoomNo = textField.text ;
        
	} else if ( textField == floorNoField_ ) {
		self.pFloorNo = textField.text ;
        
	} else if ( textField == addressNoField_ ) {
		self.pAddressNo = textField.text ;
        
	} else if ( textField == soiField_ ) {
		self.pSoi = textField.text ;
        
	} else if ( textField == villageField_ ) {
		self.pVillage = textField.text ;
        
	} else if ( textField == mooNoField_ ) {
		self.pMooNo = textField.text ;
        
	} else if ( textField == streetField_ ) {
		self.pStreet = textField.text ;
        
	} else if ( textField == tumbonField_ ) {
		self.pTumbol = textField.text ;
        
	} else if ( textField == amphurField_ ) {
		self.pAmphur = textField.text ;
        
	} else if ( textField == provinceField_ ) {
		self.pProvince = textField.text ;
        
	} else if ( textField == postcodeField_ ) {
		self.pPostcode = textField.text ;
        
	}
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    sectionHeader.backgroundColor = [[UIColor alloc] initWithRed:109.0/255 green:110.0/255 blue:112.0/255.0 alpha:1.0];
    sectionHeader.textAlignment = UITextAlignmentCenter;
    sectionHeader.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    [sectionHeader setTextColor:[UIColor whiteColor]];
    if(section == 0)
    {
        sectionHeader.text = [Util stringWithScreenName:@"Profile" labelName:@"Address"];
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
        textFieldModel.pTitle.text =[addressArray objectAtIndex:indexPath.row];
        switch ( indexPath.row ) {
            case 0: {
                textFieldModel.pTxt.text = self.pBuildName;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = buildNameField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
                
            } case 1: {
                textFieldModel.pTxt.text = self.pRoomNo;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = roomNoField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
                
            } case 2: {
                textFieldModel.pTxt.text = self.pFloorNo;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = floorNoField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
                
            } case 3: {
                textFieldModel.pTxt.text = self.pAddressNo;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = addressNoField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
                
            } case 4: {
                textFieldModel.pTxt.text = self.pSoi;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = soiField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
                
            } case 5: {
                textFieldModel.pTxt.text = self.pVillage;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = villageField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
                
            } case 6: {
                textFieldModel.pTxt.text = self.pMooNo;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = mooNoField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
                
            } case 7: {
                textFieldModel.pTxt.text = self.pStreet;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = streetField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
                
            } case 8: {
                textFieldModel.pTxt.text = self.pProvince;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = provinceField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
                
            } case 9: {
                textFieldModel.pTxt.text = self.pAmphur;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = amphurField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
                
            } case 10: {
                textFieldModel.pTxt.text = self.pTumbol;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = tumbonField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
                
            } case 11: {
                textFieldModel.pTxt.text = self.pPostcode;
                textFieldModel.pTxt.placeholder = [addressPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                textFieldModel.pButton.hidden = YES;
                tf = postcodeField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
                
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
- (IBAction)textFieldFinished:(id)sender {
    [sender resignFirstResponder];
}
- (void) onSaveButtonClicked :(UIButton*)button {
    if ([self validateField] == YES) {
        
        [self callRegisterConfirmService];
    }
    //    NSLog(@"\n password : %@", self.password);
    //    NSLog(@"\n confirmpassword : %@", self.confirmPassword);
    //    NSLog(@"\n email : %@", self.email);
    //    NSLog(@"\n birthdate : %@", self.birthDate);
    //    NSLog(@"\n questionId : %@", self.questionId);
    //    NSLog(@"\n answer : %@", self.answer);
    //    NSLog(@"\n name : %@", self.name);
    //    NSLog(@"\n surname : %@", self.surname);
    //    NSLog(@"\n father : %@", self.fatherName);
    //    NSLog(@"\n mother : %@", self.motherName);
    //    NSLog(@"\n telephone : %@", self.telephone);
}

- (BOOL) validateField {
    if([Util validateEmptyFieldWithString:self.pAddressNo]){
        NSLog(@"address not corect");
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    }else if([Util validateEmptyFieldWithString:self.pMooNo]){
        NSLog(@"moo not corect");
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    }else if([Util validateEmptyFieldWithString:self.pTumbol]){
        NSLog(@"tumbol not corect");
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    }else if([Util validateEmptyFieldWithString:self.pAmphur]){
        NSLog(@"amphur not corect");
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    }else if([Util validateEmptyFieldWithString:self.pProvince]){
        NSLog(@"province not corect");
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    }else if([Util validateEmptyFieldWithString:self.pPostcode]){
        NSLog(@"postcode not corect");
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    }else{
        return YES;
    }
}
#pragma - Response delegate
- (void) responseENRegisterConfirmService:(NSData *)data{
    
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    NSLog(@"response : %@", dic);
    NSString *result= @"ERROR";
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        [responseDataDic objectForKey:@"name"];
        [responseDataDic objectForKey:@"surname"];
        [responseDataDic objectForKey:@"buildName"];
        [responseDataDic objectForKey:@"roomNo"];
        [responseDataDic objectForKey:@"floorNo"];
        [responseDataDic objectForKey:@"addressNo"];
        [responseDataDic objectForKey:@"soi"];
        [responseDataDic objectForKey:@"village"];
        [responseDataDic objectForKey:@"mooNo"];
        [responseDataDic objectForKey:@"street"];
        [responseDataDic objectForKey:@"tambol"];
        [responseDataDic objectForKey:@"amphur"];
        [responseDataDic objectForKey:@"province"];
        [responseDataDic objectForKey:@"postcode"];
        
        response = @"Success";
         [self alertResultWithTitle:@"" detail:[Util stringWithScreenName:@"Common" labelName:@"Success"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        
    }
    if([[dic objectForKey:@"responseStatus"] isEqualToString:@"ERROR"]) {
        response = @"Fail";
        [self alertResultWithTitle:@"" detail:[dic objectForKey:@"responseError"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
    }
    
}
#pragma - call service
- (void) callRegisterConfirmService{
    enRegisterConfirmService = [[ENRegisterConfirmService alloc]init];
    enRegisterConfirmService.delegate = self;
    NSLog(@"\n call enRegisterConfirmService");
    NSLog(@"pNid %@",self.pNid);
    NSLog(@"pContract %@",self.pContractNo);
    [enRegisterConfirmService requestENRegisterConfirmService:self.pNid
                                                    buildName:self.pBuildName
                                                       roomNo:self.pRoomNo
                                                      floorNo:self.pRoomNo
                                                    addressNo:self.pAddressNo
                                                          soi:self.pSoi
                                                      village:self.pVillage
                                                        mooNo:self.pMooNo
                                                       street:self.pStreet
                                                       tambon:self.pTumbol
                                                       amphur:self.pAmphur
                                                     province:self.pProvince
                                                     postCode:self.pPostcode
                                                   contractNo:self.pContractNo];
    
}
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

        if([response isEqualToString:@"Success"]){
            for( int i=0;i<[viewControllers count];i++){
                id obj=[viewControllers objectAtIndex:i];
                if([obj isKindOfClass:[EfilingValidatePasswordViewController class]]){
                    [[self navigationController] popToViewController:obj animated:YES];
                    EfilingValidatePasswordViewController *vc = [[EfilingValidatePasswordViewController alloc]initWithNibName:@"EfilingValidatePasswordViewController" bundle:nil];
                    vc.pIdCard = self.pNid;
                    return;
                }
            }
        }else{
            for( int i=0;i<[viewControllers count];i++){
                id obj=[viewControllers objectAtIndex:i];
                if([obj isKindOfClass:[EfilingCheckNewUserViewController class]]){
                    [[self navigationController] popToViewController:obj animated:YES];
                    return;
                }
            }

        
        }
    }
}
#pragma - Back button
-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

