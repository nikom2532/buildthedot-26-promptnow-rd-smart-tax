//
//  EfilingRegisterSaveViewController.m
//  RDSmartTax
//
//  Created by Noi on 12/7/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingRegisterSaveViewController.h"
#import "EfilingRegisterConfirmViewController.h"

#import "TextFieldModel.h"
#import "DropdownViewModel.h"
#import "Header.h"
#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"



@interface EfilingRegisterSaveViewController (){
    ENRegisterSaveService *enRegisterSaveService;
    
    NSLocale *currentLocale;
    NSDateFormatter* dateFormatter;
    
    NSArray *loginDetailArray;
    NSArray *loginDetailPlaceHolder;
    NSArray *forgetPasswordArray;
    NSArray *forgetPasswordPlaceHolder;
    NSArray *userProfileArray;
    NSArray *userProfilePlaceHolder;
    NSDictionary *responseDataConfirmDic;
    
    // dropdown question
    NSMutableArray *questionHashArray;
    NSString *defaultQuestion;
    
    // dropdown country
    NSMutableArray *countryHashArray;
    NSString *defaultCountry;
    
    // dropdown question
    NSString *currentQuestion;
    NSString *currentDate;
    NSString * currentCountry;
    int questionIndex;
    int countryIndex;
    
    TextFieldModel *textFieldModel;
    DropdownViewModel *dropdownViewModel;
    UIPickerView *dropDownPickerView;
    UIActionSheet *dropDownActionSheet;
    UIButton *currentButton;
    
    UIDatePicker *dropDownDatePickerView;
    
    NSMutableArray *questionId;
    NSMutableArray *question;
    
    int maxLength;
    
    BOOL isCallMoi;
    
    NSString *response;
}


@end

@implementation EfilingRegisterSaveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (NSLocale *) checkLocale {
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        return [[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"];
    } else {
        return [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //-- Check locale
    currentLocale = [self checkLocale];
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSLog(@"format %u",dateFormatter.dateStyle);
    [dateFormatter setLocale:currentLocale];
    
    isCallMoi = NO;
    
    //test
    self.pNid = @"1234567890123";
    self.pThaiNation = @"1"; // test
    
    dataArray = [[NSMutableArray alloc] init];
    
	self.password  = @"" ;
    self.confirmPassword  = @"" ;
    
    self.email = @"" ;
    self.birthDate  = @"" ;
    self.questionId = @"" ;
    self.answer = @"" ;
    
    self.name     = @"" ;
	self.surname = @"" ;
    self.telephone = @"" ;
    self.telephoneExtension = @"" ;
    self.mobile = @"" ;
    self.fatherName = @"" ;
    self.motherName = @"" ;
    self.passportNo = @"" ;
	self.countryCode = @"" ;
    
    currentDate = @"";
    currentQuestion = @"";
    currentCountry =@"";
    
    // max length telephone
    maxLength = [[Util retrieveValidateConfigFromKey:@"rd.length.contractNo"] integerValue]+2;
    
    //------------------------------- Country Array ----------------------------------------------------------
    defaultCountry = [Util stringWithScreenName:@"Common" labelName:@"Country"];
    countryHashArray = [[NSMutableArray alloc]initWithObjects:[Util stringWithScreenName:@"CountryName" labelName:@"Afghanistan"],
                        [Util stringWithScreenName:@"CountryName" labelName:@"Argentina"],
                        [Util stringWithScreenName:@"CountryName" labelName:@"Australia"],
                        [Util stringWithScreenName:@"CountryName" labelName:@"Austria"],
                        nil];
    

    
    //------------------------------- Value Login Detail ----------------------------------------------------------
    loginDetailArray = [[NSArray alloc]initWithObjects:
                       [Util stringWithScreenName:@"Common" labelName:@"Nid"],
                       [Util stringWithScreenName:@"Common" labelName:@"Password"],
                       [Util stringWithScreenName:@"Common" labelName:@"PasswordAgain"],
                        nil];
    loginDetailPlaceHolder = [[NSArray alloc]initWithObjects:
                              [Util stringWithScreenName:@"Common" labelName:@"Nid"],
                              [Util stringWithScreenName:@"Common" labelName:@"Password"],
                              [Util stringWithScreenName:@"Common" labelName:@"PasswordAgain"],
                              nil];
    
    NSDictionary *loginDetailDic = [NSDictionary dictionaryWithObject:loginDetailArray forKey:@"data"];
    [dataArray addObject:loginDetailDic];
    
    //------------------------------- Value Forget Password ----------------------------------------------------------
    
    forgetPasswordArray = [[NSArray alloc]initWithObjects:
                           [Util stringWithScreenName:@"Common" labelName:@"Email"],
                           [Util stringWithScreenName:@"Common" labelName:@"BirthDate"],
                           [Util stringWithScreenName:@"Common" labelName:@"Question"],
                           [Util stringWithScreenName:@"Common" labelName:@"Answer"],
                           nil];
    forgetPasswordPlaceHolder = [[NSArray alloc]initWithObjects:
                             [Util stringWithScreenName:@"Common" labelName:@"Email"],
                             [Util stringWithScreenName:@"Common" labelName:@"BirthDate"],
                             [Util stringWithScreenName:@"Common" labelName:@"Question"],
                             [Util stringWithScreenName:@"Common" labelName:@"Answer"],                                 nil];
    
    NSDictionary *forgetPasswordDic = [NSDictionary dictionaryWithObject:forgetPasswordArray forKey:@"data"];
    [dataArray addObject:forgetPasswordDic];
    
    //------------------------------- Value User Profile ----------------------------------------------------------
    
    if ([self.pThaiNation isEqualToString:@"1"]) {
        
        userProfileArray = [[NSArray alloc]initWithObjects:
                            [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                            [Util stringWithScreenName:@"Common" labelName:@"MiddleName"],
                            [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                            [Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
//                            [Util stringWithScreenName:@"Common" labelName:@"Extension"],
                            //[Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
                            [Util stringWithScreenName:@"Common" labelName:@"FatherName"],
                            [Util stringWithScreenName:@"Common" labelName:@"MotherName"],
                            nil];
        userProfilePlaceHolder = [[NSArray alloc]initWithObjects:
                                  [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                                  [Util stringWithScreenName:@"Common" labelName:@"MiddleName"],
                                  [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                                  [Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
//                                  [Util stringWithScreenName:@"Common" labelName:@"Extension"],
                                  //[Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
                                  [Util stringWithScreenName:@"Common" labelName:@"FatherName"],
                                  [Util stringWithScreenName:@"Common" labelName:@"MotherName"],
                                  nil];
        
    } else {
        userProfileArray = [[NSArray alloc]initWithObjects:
                            [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                            [Util stringWithScreenName:@"Common" labelName:@"MiddleName"],
                            [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                            [Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
//                            [Util stringWithScreenName:@"Common" labelName:@"Extension"],
                            //[Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
                            [Util stringWithScreenName:@"Common" labelName:@"Passport"],
                            [Util stringWithScreenName:@"Common" labelName:@"Country"],
                            nil];
        userProfilePlaceHolder = [[NSArray alloc]initWithObjects:
                                  [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                                  [Util stringWithScreenName:@"Common" labelName:@"MiddleName"],
                                  [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                                  [Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
//                                  [Util stringWithScreenName:@"Common" labelName:@"Extension"],
                                  //[Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
                                  [Util stringWithScreenName:@"Common" labelName:@"Passport"],
                                  [Util stringWithScreenName:@"Common" labelName:@"Country"],
                                  nil];
    }
    
    NSDictionary *userProfileDic = [NSDictionary dictionaryWithObject:userProfileArray forKey:@"data"];
    [dataArray addObject:userProfileDic];
    
    [passwordField_ setSecureTextEntry:YES];
    [passwordField_ setPlaceholder:@"4-digits"];
    //-- Add Tap Gesture -----------------------------------------------------
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
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
    //-- Move up view
    
//  [UIView beginAnimations:nil context:NULL]; [UIView setAnimationDuration:0.35f]; CGRect frame = self.view.frame; frame.origin.y = -100; [self.view setFrame:frame]; [UIView commitAnimations];
    txtActiveEditing = textField;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ( textField == passwordField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.password"] integerValue]) {
            return NO;
        }
        
	}else if ( textField == confirmPasswordField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.password"] integerValue]) {
            return NO;
        }
    }else if ( textField == emailField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.email"] integerValue]) {
            return NO;
        }
    }else if (textField == telephoneField_) {
		if (range.location == maxLength) {
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
    }
//    else if (textField == mobileField_) {
//		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.contractNo"] integerValue]) {
//            return NO;
//        }
//    }
    else if (textField == nameField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
    }else if (textField == middleNameField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
    }else if (textField == surnameField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.surname"] integerValue]) {
            return NO;
        }
    }else if (textField == motherNameField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
    }else if (textField == fatherNameField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
    }else if (textField == passportNoField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.passportNo"] integerValue]) {
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
	}else if ( textField == middleNameField_ ) {
		self.midleName = textField.text ;
	}else if ( textField == surnameField_ ) {
		self.surname = textField.text ;
	} else if ( textField == birthDateField_ ) {
		self.birthDate = textField.text ;
	}else if ( textField == passportNoField_ ) {
		self.passportNo = textField.text ;
	}else if ( textField == countryCodeField_ ) {
		self.countryCode = textField.text ;
	}else if ( textField == fatherNameField_ ) {
		self.fatherName = textField.text ;
	}else if ( textField == motherNameField_ ) {
		self.motherName = textField.text ;
	}else if ( textField == telephoneField_ ) {
		self.telephone = textField.text ;
//	}else if ( textField == telephoneExtensionField_ ) {
//		self.telephoneExtension = textField.text ;
	}else if ( textField == mobileField_ ) {
		self.mobile = textField.text ;
	}else if ( textField == passwordField_ ) {
		self.password = textField.text ;
	}else if ( textField == confirmPasswordField_ ) {
		self.confirmPassword = textField.text ;
	}else if ( textField == answerField_ ) {
		self.answer = textField.text ;
	}else if ( textField == emailField_ ) {
		self.email = textField.text ;
	}
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getQuestionList];
    [self createHeader];
}
-(void) createHeader{
    self.navigationController.navigationBar.hidden = YES;
    Header *header = [Util loadViewWithNibName:@"Header"];
    header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    header.pLabel.text = [Util stringWithScreenName:@"Common" labelName:@"Register"];
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
    [currentButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [self showDropDownViewWithTag:currentButton.tag Delegate:self];
}

-(void)showDropDownViewWithTag:(NSInteger)tag Delegate:(id)delegate

{
    dropDownActionSheet = [[UIActionSheet alloc] init];
    dropDownActionSheet.tag = tag;
    
    NSLog(@"%d", tag);
    if(tag == 2)
    {
        dropDownPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
        dropDownPickerView.showsSelectionIndicator = YES;
        dropDownPickerView.dataSource = delegate;
        dropDownPickerView.delegate = delegate;
        dropDownPickerView.tag = tag;
        NSLog(@"question index %d",questionIndex);
        [dropDownPickerView selectRow:questionIndex inComponent:0 animated:NO];

    }else if(tag == 6){
        dropDownPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
        dropDownPickerView.showsSelectionIndicator = YES;
        dropDownPickerView.dataSource = delegate;
        dropDownPickerView.delegate = delegate;
        dropDownPickerView.tag = tag;
        NSLog(@"country index %d",countryIndex);
        [dropDownPickerView selectRow:countryIndex inComponent:0 animated:NO];

    }
    //-- Set default dropdown
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
    [dropDownActionSheet addSubview:dropDownPickerView];
    
    [dropDownActionSheet showInView:self.view];
    [dropDownActionSheet setBounds:CGRectMake(0, 0, self.view.frame.size.width, 464)];
    
}

-(void)cancel_clicked:(UIBarButtonItem *)item;
{
    NSLog(@"tag %d",item.tag);
    [dropDownActionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(void)done_clicked:(UIBarButtonItem *)item;
{
    NSLog(@"item %ld",(long)item.tag);

    if (item.tag == 1) {
        currentDate = [dateFormatter stringFromDate:dropDownDatePickerView.date];
        [currentButton setTitle:[dateFormatter stringFromDate:dropDownDatePickerView.date] forState:UIControlStateNormal];
        NSLog(@"birthdate : %@", currentDate);

    }else if(item.tag == 2){
        currentQuestion = [question objectAtIndex:[dropDownPickerView selectedRowInComponent:0]];
        [currentButton setTitle:[question objectAtIndex:[dropDownPickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
        // set select index question
        questionIndex = [dropDownPickerView selectedRowInComponent:0];
    }else if(item.tag == 6){
        currentCountry = [countryHashArray objectAtIndex:[dropDownPickerView selectedRowInComponent:0]];
        [currentButton setTitle:[countryHashArray objectAtIndex:[dropDownPickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
        // set select index question
        countryIndex = [dropDownPickerView selectedRowInComponent:0];

         NSLog(@"country no%d",countryIndex);
         NSLog(@"current country : %@", currentCountry);
    }

    [dropDownActionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return 0;
    }else if(pickerView.tag == 2){
        return [question count];
    }else{
        return [countryHashArray count];
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return 0;
    }else if(pickerView.tag == 2){
        NSLog(@"index title for row %@",[question objectAtIndex:row]);
        return [question objectAtIndex:row];

    }else{
        NSLog(@"index title for row %@",[countryHashArray objectAtIndex:row]);

        return [countryHashArray objectAtIndex:row];
    }
}

//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    if(pickerView.tag == 2){
//        NSLog(@"index didSelectRow %@",[question objectAtIndex:row]);
//        [currentButton setTitle:[question objectAtIndex:row] forState:UIControlStateNormal];
//        
//    }else{
//         NSLog(@"index didSelectRow %@",[countryHashArray objectAtIndex:row]);
//        [currentButton setTitle:[countryHashArray objectAtIndex:row] forState:UIControlStateNormal];
//    }
//    
//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, self.view.frame.size.width-50, 30);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        //pickerLabel.textAlignment = UITextAlignmentLeft;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    }
    
    if(pickerView.tag == 2){
        [pickerLabel setText:[question objectAtIndex:row]];
    }else{
        [pickerLabel setText:[countryHashArray objectAtIndex:row]];
    }
    return pickerLabel;
    
}
#pragma mark - hint button
-(IBAction)onHintButtonClicked:(id)sender
{
    [Util alertUtilWithTitle:@"Hint" msg:@"รายละเอียดทางกฎหมาย"];
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
    
    dropDownDatePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    dropDownDatePickerView.datePickerMode = UIDatePickerModeDate;
    NSLocale *locale = currentLocale;
    dropDownDatePickerView.locale = locale;
    dropDownDatePickerView.calendar = [locale objectForKey:NSLocaleCalendar];
    
    // set max date
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *todayDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:todayDate options:0];
    
    if([[forgetPasswordArray objectAtIndex:tag] isEqualToString:[Util stringWithScreenName:@"Common" labelName:@"BirthDate"]])
    {
        if([currentDate isEqualToString:@""]){
            
            
            NSDateFormatter *formatterDefault = [[NSDateFormatter alloc] init];
            NSDateFormatter *formatterYear = [[NSDateFormatter alloc] init];
            // set default date 01/01/yyyy
            if ([@"T" isEqualToString:[Util loadAppSettingWithName:@"AppLanguage"]]) {
                [formatterYear setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
            }
            NSDate *defaulDate = [[NSDate alloc] init];
            [formatterDefault setDateFormat:@"dd/MM/yyyy"];
            [formatterYear setDateFormat:@"yyyy"];
            
            //NSString *year = [formatterYear stringFromDate:date];
            
            
            NSString *yearString = [formatterYear stringFromDate:[NSDate date]];
            NSString *defaulDateStr= [NSString stringWithFormat:@"%@%@",@"01/01/",yearString];
            NSLog(@"default date str%@",defaulDateStr);
            defaulDate = [formatterDefault dateFromString:defaulDateStr];
             NSLog(@"default date %@",defaulDate);
            
            [dropDownDatePickerView setDate:defaulDate];
            [dropDownDatePickerView setMaximumDate:maxDate];// set max date today
            
            
            //[dropDownDatePickerView addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
            dropDownDatePickerView.tag = tag;

        }else{
            NSDateFormatter *formatterSelectDate = [[NSDateFormatter alloc] init];
            
            if ([@"T" isEqualToString:[Util loadAppSettingWithName:@"AppLanguage"]]) {
                [formatterSelectDate setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
            } else {
                [formatterSelectDate setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            }

            NSDate *selectDate = [[NSDate alloc] init];
            [formatterSelectDate setDateFormat:@"dd/MM/yyyy"];
            
            selectDate = [formatterSelectDate dateFromString:currentDate];
            NSLog(@"current date %@",currentDate);
            NSLog(@"select date %@",selectDate);
            [dropDownDatePickerView setDate:selectDate];
            [dropDownDatePickerView setMaximumDate:maxDate];
        }
        
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
    [dropdownViewModel.pDropdownButton setTitle:[dateFormatter stringFromDate:dropDownDatePickerView.date] forState:UIControlStateNormal];

}

#pragma mark - set new source
- (void) setNewSourceToArray {
    //-- Set new data to array
    currentQuestion = [self selectedQuestion:dropdownViewModel.pDropdownButton.currentTitle];
    NSLog(@"current qestion %@",currentQuestion);
}
#pragma mark - Selected question
- (NSString *) selectedQuestion : (NSString *) text {
    if ([text isEqualToString:[Util stringWithScreenName:@"ForgetPassword" labelName:@"Question1"]]) {
        return @"0";
    } else if ([text isEqualToString:[Util stringWithScreenName:@"ForgetPassword" labelName:@"Question2"]]) {
        return @"1";
    } else {
        return @"2";
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dataArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dictionary = [dataArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"data"];
    //NSLog(@"\ncount > %ld", (unsigned long)[array count]);
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
        sectionHeader.text = [Util stringWithScreenName:@"Register" labelName:@"LoginInfo"];
    }
    else if(section == 1)
    {
        sectionHeader.text = [Util stringWithScreenName:@"Register" labelName:@"ForgetPasswordInfo"];
    }
    else
    {
        sectionHeader.text = [Util stringWithScreenName:@"Register" labelName:@"PersonalInfo"];
    }
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
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
    textFieldModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal];
    textFieldModel.pTxt.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    [textFieldModel.pButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];

    
    if (indexPath.section == 0) {
        textFieldModel.pTitle.text =[loginDetailArray objectAtIndex:indexPath.row];
        switch ( indexPath.row ) {
            case 0: {
                textFieldModel.pTxt.hidden = YES;
                textFieldModel.pButton.hidden = YES;
                textFieldModel.pTextfieldLine.hidden = YES;
                NSString *nid = [TextFormatterUtil formatIdCard:self.pNid];
                //textFieldModel.pTxt.text = nid;
                [textFieldModel addSubview:[FormUtil initLabelWithSubTitleText:nid]];
                [cell addSubview:textFieldModel];
                break ;
            }
            case 1: {
                textFieldModel.pTxt.text = self.password;
                textFieldModel.pTxt.placeholder = [loginDetailPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pTxt.secureTextEntry = YES;
                tf = passwordField_ = textFieldModel.pTxt;
                [textFieldModel.pButton addTarget:self action:@selector(onHintButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [textFieldModel.pButton setImage:[UIImage imageNamed:@"icon_hint.png"] forState:UIControlStateNormal];
                [cell addSubview:textFieldModel];
                
                break ;
            }
            case 2: {
                textFieldModel.pTxt.text = self.confirmPassword;
                textFieldModel.pTxt.placeholder = [loginDetailPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pTxt.secureTextEntry = YES;
                tf = confirmPasswordField_ = textFieldModel.pTxt;
                [textFieldModel.pButton addTarget:self action:@selector(onHintButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [textFieldModel.pButton setImage:[UIImage imageNamed:@"icon_hint.png"] forState:UIControlStateNormal];
                [cell addSubview:textFieldModel];
                break ;
            }
                
        }
    } else if (indexPath.section == 1) {
        textFieldModel.pTitle.text = [forgetPasswordArray objectAtIndex:indexPath.row];

        switch (indexPath.row) {
                
            case 0: {
                textFieldModel.pTxt.text = self.email;
                textFieldModel.pTxt.placeholder = [forgetPasswordPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = emailField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];

                break ;
            }
            case 1: {
                
                //-- DROPDOWN MODEL
                dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
                dropdownViewModel.pTitle.text = [forgetPasswordArray objectAtIndex:indexPath.row];
                dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal];
                dropdownViewModel.pHintButton.hidden = YES;
                dropdownViewModel.pDropdownButton.titleLabel.font
                = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
                if ([Util validateEmptyFieldWithString:currentDate]) {
                    [dropdownViewModel.pDropdownButton setTitle:[forgetPasswordPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                } else {
                    [dropdownViewModel.pDropdownButton setTitle:currentDate forState:UIControlStateNormal];
                }
                dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [dropdownViewModel.pDropdownButton setTag:indexPath.row];
                [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownDatePickerClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:dropdownViewModel];
                
                break ;


            }
            case 2: {
                
                //-- DROPDOWN MODEL
                dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
                dropdownViewModel.pTitle.text = [Util stringWithScreenName:@"Common" labelName:@"Question"];
                dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal];
                dropdownViewModel.pHintButton.hidden = YES;
                dropdownViewModel.pDropdownButton.titleLabel.font
                = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
                if ([Util validateEmptyFieldWithString:currentQuestion]) {
                    [dropdownViewModel.pDropdownButton setTitle:[forgetPasswordPlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                } else {
                    [dropdownViewModel.pDropdownButton setTitle:currentQuestion forState:UIControlStateNormal];
                }
                
                dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [dropdownViewModel.pDropdownButton setTag:indexPath.row];
                [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:dropdownViewModel];
                
                break ;
            }
            case 3: {
                textFieldModel.pTxt.text = self.answer;
                textFieldModel.pTxt.placeholder = [forgetPasswordPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = answerField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
            }
        }
    } else {
        textFieldModel.pTitle.text = [userProfileArray objectAtIndex:indexPath.row];
        if ([self.pThaiNation isEqualToString:@"1"]) {
            
            switch ( indexPath.row ) {
                case 0: {
                    textFieldModel.pTxt.text = self.name;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = nameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];

                    break ;
                }
                case 1: {
                    textFieldModel.pTxt.text = self.midleName;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = middleNameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 2: {
                    textFieldModel.pTxt.text = self.surname;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = surnameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];

                    break ;
                }
                case 3: {
                    textFieldModel.pTxt.text = self.telephone;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                    textFieldModel.pButton.hidden = YES;
                    tf = telephoneField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];

                    break ;
                }
//                case 4: {
//                    textFieldModel.pTxt.text = self.telephoneExtension;
//                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
//                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
//                    textFieldModel.pButton.hidden = YES;
//                    tf = telephoneExtensionField_ = textFieldModel.pTxt;
//                    [cell addSubview:textFieldModel];
//    
//                    break ;
//                }
//                case 5: {
//                    textFieldModel.pTxt.text = self.mobile;
//                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
//                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
//                    textFieldModel.pButton.hidden = YES;
//                    tf = mobileField_ = textFieldModel.pTxt;
//                    [cell addSubview:textFieldModel];
//                    
//                    break ;
//                }
                case 4: {
                    textFieldModel.pTxt.text = self.fatherName;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = fatherNameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 5: {
                    textFieldModel.pTxt.text = self.motherName;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = motherNameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];

                    break ;
                }
            }
        }else{
            textFieldModel.pTitle.text = [userProfileArray objectAtIndex:indexPath.row];
            switch ( indexPath.row ) {
                case 0: {
                    textFieldModel.pTxt.text = self.name;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = nameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 1: {
                    textFieldModel.pTxt.text = self.midleName;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = middleNameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 2: {
                    textFieldModel.pTxt.text = self.surname;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = surnameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 3: {
                    textFieldModel.pTxt.text = self.telephone;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                    textFieldModel.pButton.hidden = YES;
                    tf = telephoneField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;

                }
//                case 4: {
//                    textFieldModel.pTxt.text = self.telephoneExtension;
//                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
//                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
//                    textFieldModel.pButton.hidden = YES;
//                    tf = telephoneExtensionField_ = textFieldModel.pTxt;
//                    [cell addSubview:textFieldModel];
//                    
//                    break ;
//                }
////                case 5: {
//                    textFieldModel.pTxt.text = self.mobile;
//                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
//                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
//                    textFieldModel.pButton.hidden = YES;
//                    tf = mobileField_ = textFieldModel.pTxt;
//                    [cell addSubview:textFieldModel];
//                    
//                    break ;
//                }
                case 4: {
                    textFieldModel.pTxt.text = self.passportNo;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = passportNoField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    break ;
                }
                case 5: {
                    //-- DROPDOWN MODEL
                    dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
                    dropdownViewModel.pTitle.text = [Util stringWithScreenName:@"Common" labelName:@"Country"];
                    dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal];
                    dropdownViewModel.pHintButton.hidden = YES;
                    dropdownViewModel.pDropdownButton.titleLabel.font
                    = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
                    if ([Util validateEmptyFieldWithString:currentCountry]) {
                        [dropdownViewModel.pDropdownButton setTitle:[userProfilePlaceHolder objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                    } else {
                        [dropdownViewModel.pDropdownButton setTitle:currentCountry forState:UIControlStateNormal];
                    }
                    
                    dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    [dropdownViewModel.pDropdownButton setTag:indexPath.row];
                    [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:dropdownViewModel];
                    
                    break ;                }
                    
            }
        }
        
    }
//    NSInteger sectionsAmount = [tableView numberOfSections];
//    NSInteger rowsAmount = [tableView numberOfRowsInSection:[indexPath section]];
//    if ([indexPath section] == sectionsAmount - 1 && [indexPath row] == rowsAmount - 1) {
//        UIButton *bt = [FormUtil initNextButtonWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Save"]];
//        [bt addTarget:self action:@selector(onSaveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:bt];
//    }
//    NSInteger sectionsAmount = [tableView numberOfSections];
//    NSInteger rowsAmount = [tableView numberOfRowsInSection:[indexPath section]];
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
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//
//    UIButton * b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [b setTitle:@"Submit" forState:UIControlStateNormal];
//    [b addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.tableView.tableFooterView = b;
//
//    return self.tableView.tableFooterView;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 30.0; // return your button's height
//}

- (IBAction)textFieldFinished:(id)sender {
    //[sender resignFirstResponder];
}

- (void) onSaveButtonClicked :(UIButton*)button {
//    if ([self validateField] == YES) {
//        
//        [self callRegisterSaveService];
//    }
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

    NSLog(@"telephone %@",[TextFormatterUtil removeMinusSignFromString:self.telephone]);
    NSLog(@"select date %@",currentDate);
    if([self.pThaiNation isEqualToString: @"1"]){
        if([Util validatePasswordIsEqualConfirmPassword:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"Password field not match ");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"Password field not match"];
            return NO;
        }else if([Util validatePasswordIsEmpty:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"Password field must be 8 character ");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"Password field must be 8 character"];
            return NO;
        }else if([Util validatePasswordIsExceptWord:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"Password field must not be password ");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"Password field must not be password"];
            return NO;
        }
        else if([Util validateEmptyFieldWithString:self.email]){
            NSLog(@"email not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"email not corect"];
            return NO;
        }
        else if(![Util validateEmail:self.email]){
            NSLog(@"email not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"email not corect"];
            return NO;
        }
        else if([Util validateEmptyFieldWithString:currentDate]){
            NSLog(@"birthdate not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }
        else if([Util validateEmptyFieldWithString:currentQuestion]){
            NSLog(@"question not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }
        else if([Util validateEmptyFieldWithString:self.answer]){
            NSLog(@"answer not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"answer not corect"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.name]){
            NSLog(@"name not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"name not corect"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.surname]){
            NSLog(@"surname not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"surname not corect"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.telephone]){
            NSLog(@"telephone not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"telephone not corect"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.fatherName]){
            NSLog(@"fathername not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"fathername not corect"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.motherName]){
            NSLog(@"mothername not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"mothername not corect"];
            return NO;
        }else{
            return YES;
        }
    }else{
        
        if([Util validatePasswordIsEqualConfirmPassword:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"Password field not match ");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"Password field not match"];
            return NO;
        }else if([Util validatePasswordIsEmpty:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"Password field must be 8 character ");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"Password field must be 8 character"];
            return NO;
        }else if([Util validatePasswordIsExceptWord:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"Password field must not be password ");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"Password field must not be password"];
            return NO;
        }
        else if([Util validateEmptyFieldWithString:self.email]){
            NSLog(@"email not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"email not corect"];
            return NO;
        }
        else if(![Util validateEmail:self.email]){
            NSLog(@"email not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"email not corect"];
            return NO;
        }
        else if([Util validateEmptyFieldWithString:currentDate]){
            NSLog(@"birthdate not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"birthdate not corect"];
            return NO;
        }else if([Util validateEmptyFieldWithString:currentQuestion]){
            NSLog(@"question not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"question not corect"];
            return NO;
        }
        else if([Util validateEmptyFieldWithString:self.answer]){
            NSLog(@"answer not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"answer not corect"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.name]){
            NSLog(@"name not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"name not corect"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.midleName]){
            NSLog(@"name not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"middle name not corect"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.surname]){
            NSLog(@"surname not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"surname not corect"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.telephone]){
            NSLog(@"telephone not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"telephone not corect"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.passportNo]){
            NSLog(@"passport not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"passport not corect"];
            return NO;
        }
//        else if([Util validateEmptyFieldWithString:currentCountry]){
//            NSLog(@"countrycode not corect");
//            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"countrycode not corect"];
//            return NO;
//        }
        else{
            return YES;
        }
        
    }
    
}
-(void)getQuestionList{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"questionList" ofType:@"json"];
    NSError *error = nil; // This so that we can access the error if something goes wrong
    NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
    
    questionId = [[NSMutableArray alloc]init];
    question = [[NSMutableArray alloc]init];
    NSEnumerator *enumerator = [responseDataDic objectEnumerator];
    id object;
    while (object = [enumerator nextObject]) {
        [questionId addObject:[object objectForKey:@"question_id"]];
        if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
            [question addObject:[object objectForKey:@"question_th"]];
        } else {
            [question addObject:[object objectForKey:@"question_en"]];
        }
    }
}

#pragma - call service
- (void) callRegisterSaveService{
    enRegisterSaveService = [[ENRegisterSaveService alloc]init];
    enRegisterSaveService.delegate = self;
    NSLog(@"\n call enRegisterSaveService");
    
    if([self.pThaiNation isEqualToString:@"1"]){
        NSLog(@"\n thai ");
        [enRegisterSaveService requestENRegisterSaveService:self.pNid
                                                   password:self.password
                                                      email:self.email
                                                  birthDate:self.birthDate
                                                 questionId:currentQuestion
                                                     answer:self.answer
                                                       name:self.name
                                                    surname:self.surname
                                                  telephone:[TextFormatterUtil removeMinusSignFromString:self.telephone]
                                         telephoneExtension:@""
                                                 fatherName:self.fatherName
                                                 motherName:self.motherName
                                                 passportNo:@""
                                                countryCode:@""
                                                    moiFlag:@"N"
                                                    middleName:self.midleName];
    }else{
        [enRegisterSaveService requestENRegisterSaveService:self.pNid
                                                   password:self.password
                                                      email:self.email
                                                  birthDate:self.birthDate
                                                 questionId:self.questionId
                                                     answer:self.answer
                                                       name:self.name
                                                    surname:self.surname
                                                  telephone:[TextFormatterUtil removeMinusSignFromString:self.telephone]
                                         telephoneExtension:self.telephoneExtension
                                                 fatherName:@""
                                                 motherName:@""
                                                 passportNo:self.passportNo
                                                countryCode:self.countryCode
                                                    moiFlag:@"N"
                                                    middleName:self.midleName];
        
        
    }
}
- (void) callRegisterSaveServiceWithMOI{
    isCallMoi = YES;
    
    enRegisterSaveService = [[ENRegisterSaveService alloc]init];
    enRegisterSaveService.delegate = self;
    NSLog(@"\n call enRegisterSaveService");
    NSString *version= [Util loadAppSettingWithName:@"Version"];
    
    if([self.pThaiNation isEqualToString:@"1"]){
        NSLog(@"\n thai ");
        [enRegisterSaveService requestENRegisterSaveService:self.pNid
                                                   password:self.password
                                                      email:self.email
                                                  birthDate:self.birthDate
                                                 questionId:currentQuestion
                                                     answer:self.answer
                                                       name:self.name
                                                    surname:self.surname
                                                  telephone:[TextFormatterUtil removeMinusSignFromString:self.telephone]
                                         telephoneExtension:self.telephoneExtension
                                                 fatherName:self.fatherName
                                                 motherName:self.motherName
                                                 passportNo:@""
                                                countryCode:@""
                                                    moiFlag:@"Y"
                                                    middleName:self.midleName];
    }else{
        [enRegisterSaveService requestENRegisterSaveService:self.pNid
                                                   password:self.password
                                                      email:self.email
                                                  birthDate:self.birthDate
                                                 questionId:self.questionId
                                                     answer:self.answer
                                                       name:self.name
                                                    surname:self.surname
                                                  telephone:[TextFormatterUtil removeMinusSignFromString:self.telephone]
                                         telephoneExtension:self.telephoneExtension
                                                 fatherName:@""
                                                 motherName:@""
                                                 passportNo:self.passportNo
                                                countryCode:self.countryCode
                                                    moiFlag:@"N"
                                                    middleName:self.midleName];
        
        
    }
}

- (void) responseENRegisterSaveService:(NSData *)data{
    
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    NSLog(@"response : %@", dic);
    
    NSString *result = @"OK";
//    [dic objectForKey:@"responseStatus"]
    if([[dic objectForKey:@"responseCode"]isEqualToString:@"0"]){
        if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
            response = @"Success";
            NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
            
            if (isCallMoi) {
                
                nameField_.text = [responseDataDic objectForKey:@"name"];
                surnameField_.text = [responseDataDic objectForKey:@"surname"];
                
                isCallMoi = NO;
                
            } else {
                
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
                
                
                EfilingRegisterConfirmViewController *vc = [[EfilingRegisterConfirmViewController alloc]initWithNibName:@"EfilingRegisterConfirmViewController" bundle:nil];
                
                vc.pNid = self.pNid; // hard code for test
                vc.pBuildName = [responseDataDic objectForKey:@"buildName"];
                vc.pRoomNo = [responseDataDic objectForKey:@"roomNo"];
                vc.pFloorNo = [responseDataDic objectForKey:@"floorNo"];
                vc.pAddressNo = [responseDataDic objectForKey:@"addressNo"];
                vc.pSoi = [responseDataDic objectForKey:@"soi"];
                vc.pVillage = [responseDataDic objectForKey:@"village"];
                vc.pMooNo = [responseDataDic objectForKey:@"mooNo"];
                vc.pStreet = [responseDataDic objectForKey:@"street"];
                vc.pTumbol = [responseDataDic objectForKey:@"tambol"];
                vc.pAmphur = [responseDataDic objectForKey:@"amphur"];
                vc.pProvince = [responseDataDic objectForKey:@"province"];
                vc.pPostcode = [responseDataDic objectForKey:@"postcode"];
                vc.pContractNo = [responseDataDic objectForKey:@"contractNo"];
                NSLog(@"contractNo %@",vc.pContractNo);
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
        }
        if([[dic objectForKey:@"responseStatus"] isEqualToString:@"CONFIRM"]) {
            response = @"Confirm";
            responseDataConfirmDic = [dic objectForKey:@"responseData"];
            [responseDataConfirmDic objectForKey:@"name"];
            [responseDataConfirmDic objectForKey:@"surname"];
            [responseDataConfirmDic objectForKey:@"buildName"];
            [responseDataConfirmDic objectForKey:@"roomNo"];
            [responseDataConfirmDic objectForKey:@"floorNo"];
            [responseDataConfirmDic objectForKey:@"addressNo"];
            [responseDataConfirmDic objectForKey:@"soi"];
            [responseDataConfirmDic objectForKey:@"village"];
            [responseDataConfirmDic objectForKey:@"mooNo"];
            [responseDataConfirmDic objectForKey:@"street"];
            [responseDataConfirmDic objectForKey:@"tambol"];
            [responseDataConfirmDic objectForKey:@"amphur"];
            [responseDataConfirmDic objectForKey:@"province"];
            [responseDataConfirmDic objectForKey:@"postcode"];
            
            [self alertYesNoWithTitle:@"" detail:[Util stringWithScreenName:@"Register" labelName:@"ResConfirm"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"] no:[Util stringWithScreenName:@"Common" labelName:@"No"]];
            
        }
        if([[dic objectForKey:@"responseStatus"] isEqualToString:@"ERROR"]) {
            response = @"Error";
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
        }

    }else{
        response = @"Error";
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseMessage"]];
    
    }
}

#pragma mark - Alert with condition
- (void) alertYesNoWithTitle : (NSString *)title detail:(NSString *)detail yes:(NSString *)yes no:(NSString *)no {
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:title];
    [alert setMessage:detail];
    [alert setDelegate:self];
    [alert addButtonWithTitle:yes];
    [alert addButtonWithTitle:no];
    [alert show];
}
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self callRegisterSaveServiceWithMOI];
        
    } else if (buttonIndex == 1){
        EfilingRegisterConfirmViewController *vc = [[EfilingRegisterConfirmViewController alloc]initWithNibName:@"EfilingRegisterConfirmViewController" bundle:nil];
        
        vc.pNid = self.pNid;
        vc.pBuildName = [responseDataConfirmDic objectForKey:@"buildName"];
        vc.pRoomNo = [responseDataConfirmDic objectForKey:@"roomNo"];
        vc.pFloorNo = [responseDataConfirmDic objectForKey:@"floorNo"];
        vc.pAddressNo = [responseDataConfirmDic objectForKey:@"addressNo"];
        vc.pSoi = [responseDataConfirmDic objectForKey:@"soi"];
        vc.pVillage = [responseDataConfirmDic objectForKey:@"village"];
        vc.pMooNo = [responseDataConfirmDic objectForKey:@"mooNo"];
        vc.pStreet = [responseDataConfirmDic objectForKey:@"street"];
        vc.pTumbol = [responseDataConfirmDic objectForKey:@"tambol"];
        vc.pAmphur = [responseDataConfirmDic objectForKey:@"amphur"];
        vc.pProvince = [responseDataConfirmDic objectForKey:@"province"];
        vc.pPostcode = [responseDataConfirmDic objectForKey:@"postcode"];
        vc.pContractNo = [responseDataConfirmDic objectForKey:@"contractNo"];
        NSLog(@"contractNo %@",vc.pContractNo);
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)save:(id)sender {
    if ([self validateField] == YES) {
        
        [self callRegisterSaveService];
    }
}
#pragma - Back button
-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISCROLLVIEW DELEGATE
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self hideKeyboard];
}

@end
