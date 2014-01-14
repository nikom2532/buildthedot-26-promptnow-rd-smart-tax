//
//  EfilingAuthenUserViewController.m
//  RDSmartTax
//
//  Created by Noi on 12/20/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingAuthenUserViewController.h"
#import "EfilingCheckNewUserViewController.h"
#import "EfilingChangeOnlyPasswordViewController.h"
#import "ENConfirmRequestPassword.h"

#import "TextFieldModel.h"
#import "DropdownViewModel.h"

#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"

@interface EfilingAuthenUserViewController (){
    NSArray *authenThaiArray;
    NSArray *authenForeignArray;
    NSArray *authenThaiPlaceHolder;
    NSArray *authenForeignPlaceHolder;
    
    // dropdown question
    NSMutableArray *countryHashArray;
    NSString *currentCountry;
    int selectedCountry;
    NSString *defaultCountry;
    NSString *countryStr;
    NSMutableArray *countryCode;
    NSMutableArray *country;
    
    TextFieldModel *textFieldModel;
    DropdownViewModel *dropdownViewModel;
    UIPickerView *dropDownPickerView;
    UIActionSheet *dropDownActionSheet;
    UIButton *currentButton;
    
    NSDictionary *responseDataConfirmDic;
    NSString *response;
}

@end

@implementation EfilingAuthenUserViewController
@synthesize enConfirmRequestPasswordService;

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
    self.name     = @"" ;
    self.middleName     = @"" ;
	self.surname = @"" ;
    self.fatherName = @"" ;
    self.motherName = @"" ;
    self.passportNo = @"" ;
	self.countryCode = @"" ;
    currentCountry =@"";
    
    defaultCountry = [Util stringWithScreenName:@"Common" labelName:@"Country"];
    countryHashArray = [[NSMutableArray alloc]initWithObjects:[Util stringWithScreenName:@"CountryName" labelName:@"Afghanistan"],
                         [Util stringWithScreenName:@"CountryName" labelName:@"Argentina"],
                         [Util stringWithScreenName:@"CountryName" labelName:@"Australia"],
                         [Util stringWithScreenName:@"CountryName" labelName:@"Austria"],
                        nil];
    
    //------------------------------- Value Authen Thai ----------------------------------------------------------
    authenThaiArray = [[NSArray alloc]initWithObjects:
                        [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                        [Util stringWithScreenName:@"Common" labelName:@"MiddleName"],
                        [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                        [Util stringWithScreenName:@"Common" labelName:@"FatherName"],
                        [Util stringWithScreenName:@"Common" labelName:@"MotherName"],
                        nil];
    authenThaiPlaceHolder = [[NSArray alloc]initWithObjects:
                         [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                         [Util stringWithScreenName:@"Common" labelName:@"MiddleName"],
                         [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                         [Util stringWithScreenName:@"Common" labelName:@"FatherName"],
                         [Util stringWithScreenName:@"Common" labelName:@"MotherName"],
                              nil];
    
    NSDictionary *authenThaiDic = [NSDictionary dictionaryWithObject:authenThaiArray forKey:@"data"];
    [dataArray addObject:authenThaiDic];
    
    //------------------------------- Value Authen Foreign ----------------------------------------------------------
    authenForeignArray = [[NSArray alloc]initWithObjects:
                       [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                       [Util stringWithScreenName:@"Common" labelName:@"MiddleName"],
                       [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                       [Util stringWithScreenName:@"Common" labelName:@"Passport"],
                       [Util stringWithScreenName:@"Common" labelName:@"Country"],
                       nil];
    authenForeignPlaceHolder = [[NSArray alloc]initWithObjects:
                         [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                         [Util stringWithScreenName:@"Common" labelName:@"MiddleName"],
                         [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                         [Util stringWithScreenName:@"Common" labelName:@"Passport"],
                         [Util stringWithScreenName:@"Common" labelName:@"Country"],
                         nil];
    
    NSDictionary *authenForeignDic = [NSDictionary dictionaryWithObject:authenForeignArray forKey:@"data"];
    [dataArray addObject:authenForeignDic];
    
    //-- Add Tap Gesture -----------------------------------------------------
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    //passwordField_.delegate = self;
    [self getCountryNameList];

}

#pragma mark -
#pragma mark Textfield
-(void)hideKeyboard
{
    if(txtActiveEditing) {
        [txtActiveEditing resignFirstResponder];
    }
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    [UIView beginAnimations:nil context:NULL]; [UIView setAnimationDuration:0.35f]; CGRect frame = self.view.frame; frame.origin.y = -100; [self.view setFrame:frame]; [UIView commitAnimations];
    txtActiveEditing = textField;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ( textField == nameField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
        
	}else if ( textField == middleNameField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
    }else if ( textField == surnameField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
    }else if ( textField == fatherNameField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
    }else if (textField == motherNameField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
    }
    else if (textField == passportNoField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.passportNo"] integerValue]) {
            return NO;
        }
    }    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    txtActiveEditing = nil;
    if ( textField == nameField_ ) {
		self.name = textField.text ;
	}else if ( textField == middleNameField_ ) {
		self.middleName = textField.text ;
	}else if ( textField == surnameField_ ) {
		self.surname = textField.text ;
	}else if ( textField == fatherNameField_ ) {
		self.fatherName = textField.text ;
	}else if ( textField == motherNameField_ ) {
		self.motherName = textField.text ;
	}else if ( textField == passportNoField_ ) {
		self.passportNo = textField.text ;
	}else if ( textField == countryField_ ) {
		self.countryCode = textField.text ;
	}
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.buttonConfirm.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [self createHeader];
    [self setLanguage];
}
- (void) setLanguage{
    [self.buttonConfirm setTitle:[Util stringWithScreenName:@"Common" labelName:@"Confirm"] forState:UIControlStateNormal];
}
-(void) createHeader{
    self.navigationController.navigationBar.hidden = YES;
    Header *header = [Util loadViewWithNibName:@"Header"];
    header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    header.pLabel.text = [Util stringWithScreenName:@"Common" labelName:@"AuthenUer"];
    header.pLabel.font = [FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold];
    [header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    header.pRightButton.hidden = YES;
    [self.view addSubview:header];
    
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
    
    NSLog(@"%d", tag);
    if(tag == 4)
    {
        dropDownPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
        dropDownPickerView.showsSelectionIndicator = YES;
        dropDownPickerView.dataSource = delegate;
        dropDownPickerView.delegate = delegate;
        dropDownPickerView.tag = tag;
        NSLog(@"country index %d",selectedCountry);
        countryStr = [NSString stringWithFormat:@"%d",selectedCountry];
        [dropDownPickerView selectRow:selectedCountry inComponent:0 animated:NO];
    }
    
    //-- Set default dropdown
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    [toolBar sizeToFit];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Cancel"] style:UIBarButtonItemStyleBordered target:delegate action:@selector(cancel_clicked:)];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Done"] style:UIBarButtonItemStyleBordered target:delegate action:@selector(done_clicked:)];
    
    doneBtn.tag = tag;
    
    NSArray *barItems = @[doneBtn,flexSpace,cancelBtn];
    
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
    
    if([[authenForeignArray objectAtIndex:item.tag]isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"Country"]]){
        currentCountry = [country objectAtIndex:[dropDownPickerView selectedRowInComponent:0]];
        selectedCountry = [dropDownPickerView selectedRowInComponent:0];
        NSLog(@"select country %d",selectedCountry);
        [currentButton setTitle:[country objectAtIndex:[dropDownPickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
    }
    [dropDownActionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([[authenForeignArray objectAtIndex:pickerView.tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"BirthDate"]]) {
        return 0;
    }else{
        return [country count];
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
 
        return [country objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [currentButton setTitle:[country objectAtIndex:row] forState:UIControlStateNormal];
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, self.view.frame.size.width-50, 30);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        //pickerLabel.textAlignment = UITextAlignmentLeft;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    }
    [pickerLabel setText:[country objectAtIndex:row]];
    return pickerLabel;
    
}
#pragma mark - country name list
-(void)getCountryNameList{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"country" ofType:@"json"];
    NSError *error = nil; // This so that we can access the error if something goes wrong
    NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    NSDictionary *countryDic = [dic objectForKey:@"country_name"];
    
    countryCode = [[NSMutableArray alloc]init];
    country = [[NSMutableArray alloc]init];
    
    NSEnumerator *enumerator = [countryDic objectEnumerator];
    id object;
    while (object = [enumerator nextObject]) {
        [countryCode addObject:[object objectForKey:@"COUNTRY_CODE"]];
        if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
            [country addObject:[object objectForKey:@"THAI_NAME"]];
        } else {
            [country addObject:[object objectForKey:@"ENG_NAME"]];
            NSLog(@"country %@",country);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [authenThaiArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	UITextField* tf = nil ;
    textFieldModel = [Util loadViewWithNibName:@"TextFieldModel"];
    textFieldModel.frame = CGRectMake(0, 0, 320, 75);
    textFieldModel.layer.masksToBounds = YES;
    textFieldModel.pTxt.delegate = self;
    textFieldModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal];
    textFieldModel.pTxt.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    [textFieldModel.pButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    if ([self.pThaiNation isEqualToString:@"1"]) {
        textFieldModel.pTitle.text =[authenThaiArray objectAtIndex:indexPath.row];
        switch (indexPath.row) {
            case 0: {
                textFieldModel.pTxt.text = self.name;
                textFieldModel.pTxt.placeholder = [authenThaiPlaceHolder objectAtIndex:indexPath.row];
                //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = nameField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break;
            }case 1: {
                textFieldModel.pTxt.text = self.middleName;
                textFieldModel.pTxt.placeholder = [authenThaiPlaceHolder objectAtIndex:indexPath.row];
                //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = middleNameField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break;
            }
            case 2: {
                textFieldModel.pTxt.text = self.surname;
                textFieldModel.pTxt.placeholder = [authenThaiPlaceHolder objectAtIndex:indexPath.row];
                //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = surnameField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
            }
            case 3: {
                textFieldModel.pTxt.text = self.fatherName;
                textFieldModel.pTxt.placeholder = [authenThaiPlaceHolder objectAtIndex:indexPath.row];
                //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = fatherNameField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
            }
            case 4: {
                textFieldModel.pTxt.text = self.motherName;
                textFieldModel.pTxt.placeholder = [authenThaiPlaceHolder objectAtIndex:indexPath.row];
                //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = motherNameField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
            }
        }
        
    }else{
        textFieldModel.pTitle.text =[authenForeignArray objectAtIndex:indexPath.row];
        switch (indexPath.row) {
            case 0: {
                textFieldModel.pTxt.text = self.name;
                textFieldModel.pTxt.placeholder = [authenForeignPlaceHolder objectAtIndex:indexPath.row];
                //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = nameField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break;
            }case 1: {
                textFieldModel.pTxt.text = self.middleName;
                textFieldModel.pTxt.placeholder = [authenForeignPlaceHolder objectAtIndex:indexPath.row];
                //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = middleNameField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break;
            }
            case 2: {
                textFieldModel.pTxt.text = self.surname;
                textFieldModel.pTxt.placeholder = [authenForeignPlaceHolder objectAtIndex:indexPath.row];
                //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = surnameField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
            }
            case 3: {
                textFieldModel.pTxt.text = self.passportNo;
                textFieldModel.pTxt.placeholder = [authenForeignPlaceHolder objectAtIndex:indexPath.row];
                //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = passportNoField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
            }
            case 4: {
                //-- DROPDOWN MODEL
                dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
                dropdownViewModel.pTitle.text = [Util stringWithScreenName:@"Common" labelName:@"Country"];
                dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal];
                dropdownViewModel.pHintButton.hidden = YES;
                dropdownViewModel.pDropdownButton.titleLabel.font
                = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
                if ([Util validateEmptyFieldWithString:currentCountry]) {
                    [dropdownViewModel.pDropdownButton setTitle:[authenForeignPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                } else {
                    [dropdownViewModel.pDropdownButton setTitle:currentCountry forState:UIControlStateNormal];
                }
                
                dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [dropdownViewModel.pDropdownButton setTag:indexPath.row];
                [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:dropdownViewModel];
                
                break ;

            }
        }

    
    }
    
   //    if ([indexPath section] == sectionsAmount - 1 && [indexPath row] == rowsAmount - 1) {
//        UIButton *bt = [FormUtil initNextButtonWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Save"]];
//        [bt addTarget:self action:@selector(onSaveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:bt];
//    }
    
    cell.backgroundColor = [UIColor clearColor];
    [tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    tf.delegate = self ;
    return cell;
}
- (IBAction)textFieldFinished:(id)sender {
    //[sender resignFirstResponder];
}

- (IBAction)onButtonConfirmClicked:(id)sender {
    if ([self validateField] == YES) {
        [self callConfirmRequestPasswordService];
        
    }else{

    }
}
- (BOOL) validateField {
        currentCountry = [countryCode objectAtIndex:selectedCountry];
    NSLog(@"curent country %@",currentCountry);
        if ([self.pThaiNation isEqualToString:@"1"]) {
            if([Util validateEmptyFieldWithString:self.name]){
                NSLog(@"name empty");
                [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"nameEmpty"]];
                return NO;
            }else if([Util validateEmptyFieldWithString:self.surname]){
                NSLog(@"surname empty");
                [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"surnameEmpty"]];
                return NO;
            
            }else if([Util validateEmptyFieldWithString:self.fatherName]){
                NSLog(@"fathername empty");
                [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"fatherNameEmpty"]];
                return NO;
                
            }else if([Util validateEmptyFieldWithString:self.motherName]){
                NSLog(@"mothername empty");
                [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"motherNameEmpty"]];
                return NO;
            }else{
                return YES;
            }
        }else{
            if([Util validateEmptyFieldWithString:self.name]){
                NSLog(@"name empty");
                [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"nameEmpty"]];
                return NO;
            }else if([Util validateEmptyFieldWithString:self.surname]){
                NSLog(@"surname empty");
                [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"surnameEmpty"]];
                return NO;
            }else if([Util validateEmptyFieldWithString:self.passportNo]){
                NSLog(@"passport empty");
                [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"passportNoEmpty"]];
                return NO;
                
            }else if([Util validateEmptyFieldWithString:[NSString stringWithFormat:@"%@",currentCountry]]){
                [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"countryCodeEmpty"]];
                return NO;
            }else{
                return YES;
            }

        
        }
    
    
}
#pragma - call service
- (void) callConfirmRequestPasswordService{
    enConfirmRequestPasswordService = [[ENConfirmRequestPassword alloc]init];
    enConfirmRequestPasswordService.delegate = self;
    NSLog(@"\n call enConfirmRequestPasswordService");
    if ([self.pThaiNation isEqualToString:@"1"]) {
        [enConfirmRequestPasswordService requestENConfirmRequestPasswordService:self.pNid
                                                                           name:self.name
                                                                        surName:self.surname
                                                                      birthDate:self.pBirthDate
                                                                     fatherName:self.fatherName
                                                                     motherName:self.motherName
                                                                     passportNo:@""
                                                                    countryCode:@""];
    }else{
        [enConfirmRequestPasswordService requestENConfirmRequestPasswordService:self.pNid
                                                                           name:self.name
                                                                        surName:self.surname
                                                                      birthDate:self.pBirthDate
                                                                     fatherName:@""
                                                                     motherName:@""
                                                                     passportNo:self.passportNo
                                                                    countryCode:currentCountry];
    }
    
}

-(void) responseENConfirmRequestPasswordService:(NSDictionary *)data{
    NSDictionary *dic = data;
    NSLog(@"response : %@", dic);
      if([[dic objectForKey:@"responseCode"]isEqualToString:@"0"]){
        if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"SUCCESS"]) {
            EfilingChangeOnlyPasswordViewController *vc = [[EfilingChangeOnlyPasswordViewController alloc]initWithNibName:@"EfilingChangeOnlyPasswordViewController" bundle:nil];
            vc.pNid = self.pNid;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if([[dic objectForKey:@"responseStatus"] isEqualToString:@"ERROR"]) {
            //        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
            [self alertResultWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] detail:[Util stringWithScreenName:@"Common" labelName:@"Failure"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        }
      }else{
          [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseMessage"]];
      }
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

            for( int i=0;i<[viewControllers count];i++){
                id obj=[viewControllers objectAtIndex:i];
                if([obj isKindOfClass:[EfilingCheckNewUserViewController class]]){
                    [[self navigationController] popToViewController:obj animated:YES];
                    return;
                }
            }
    }
}
#pragma - Back button
-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
