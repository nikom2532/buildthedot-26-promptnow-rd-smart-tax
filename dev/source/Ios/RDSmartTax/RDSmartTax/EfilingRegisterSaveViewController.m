//
//  EfilingRegisterSaveViewController.m
//  RDSmartTax
//
//  Created by Noi on 12/7/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingRegisterSaveViewController.h"
#import "EfilingRegisterConfirmViewController.h"
#import "EfilingCheckNewUserViewController.h"
#import "TextFieldModel.h"
#import "DropdownViewModel.h"
#import "ButtonModel.h"
#import "Header.h"
#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"

@interface EfilingRegisterSaveViewController (){
    
    NSLocale *currentLocale;
    NSDateFormatter* dateFormatter;
    
    NSArray *loginDetailArray;
    NSArray *forgetPasswordArray;
    NSArray *userProfileArray;
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
    NSString *currentCountry;
    int questionIndex;
    int countryIndex;
    NSString *questionIdStr;
    
    TextFieldModel *textFieldModel;
    DropdownViewModel *dropdownViewModel;
    ButtonModel *buttonModel;
    UIPickerView *dropDownPickerView;
    UIActionSheet *dropDownActionSheet;
    UIButton *currentButton;
    
    UIDatePicker *dropDownDatePickerView;
    
    NSMutableArray *questionId;
    NSMutableArray *question;
    
    NSMutableArray *countryCode;
    NSMutableArray *country;
    
    NSString *birthdateStr;
    
    NSMutableArray *validate_field;
    NSMutableArray *message_th;
    NSMutableArray *message_en;

    
    int maxLength;
    
    BOOL isCallMoi;
    
    NSString *response;
    NSString *test;
    //--view
    CGPoint    m_originalRootView;
    CGRect     m_scrollViewFrame;
    
    int currentSection;
    int currentIndex;
    NSString *isTF;
    
}

@end

@implementation EfilingRegisterSaveViewController
@synthesize enRegisterSaveService;

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    // kb - remember original location root view --------------------------
    m_originalRootView = self.view.frame.origin;
    
    // kb - remember original frame -----------------------
    m_scrollViewFrame = self.scrollView.frame;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars=NO;
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    //-- add footer
    buttonModel = [Util loadViewWithNibName:@"ButtonModel"];
    [buttonModel.pButton addTarget:self action:@selector(onContinueButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [buttonModel.pButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    self.tableView.tableFooterView = buttonModel;
    
    //-- Check locale
    currentLocale = [self checkLocale];
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    [dateFormatter setLocale:currentLocale];
    
    isCallMoi = NO;
    
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
    
    //------------------------------- Value Login Detail ----------------------------------------------------------
    loginDetailArray = [[NSArray alloc]initWithObjects:
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
    } else {
        userProfileArray = [[NSArray alloc]initWithObjects:
                            [Util stringWithScreenName:@"Common" labelName:@"NameWithOutTitle"],
                            [Util stringWithScreenName:@"Common" labelName:@"MiddleName"],
                            [Util stringWithScreenName:@"Common" labelName:@"Surname"],
                            [Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
//                            [Util stringWithScreenName:@"Common" labelName:@"Extension"],
                            //[Util stringWithScreenName:@"Common" labelName:@"MobilePhone"],
                            [Util stringWithScreenName:@"Common" labelName:@"PassportRegister"],
                            [Util stringWithScreenName:@"Common" labelName:@"Country"],
                            nil];
}
    
    NSDictionary *userProfileDic = [NSDictionary dictionaryWithObject:userProfileArray forKey:@"data"];
    [dataArray addObject:userProfileDic];
    
    [passwordField_ setSecureTextEntry:YES];
    
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
    [self.buttonContinue.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [self getQuestionList];
    [self getCountryNameList];
    [self createHeader];
    [self setLanguage];
}
-(void)setLanguage{
    //-- set button label
    [buttonModel.pButton setTitle:[Util stringWithScreenName:@"Common" labelName:@"Next"] forState:UIControlStateNormal];
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
        [dropDownPickerView selectRow:questionIndex inComponent:0 animated:NO];

    }else if(tag == 5){
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
    [dropDownActionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(void)done_clicked:(UIBarButtonItem *)item;
{
     if (item.tag == 1) {
        currentDate = [dateFormatter stringFromDate:dropDownDatePickerView.date];
        [currentButton setTitle:[dateFormatter stringFromDate:dropDownDatePickerView.date] forState:UIControlStateNormal];
        NSLog(@"birthdate : %@", currentDate);

    }else if(item.tag == 2){
        currentQuestion = [question objectAtIndex:[dropDownPickerView selectedRowInComponent:0]];
        [currentButton setTitle:[question objectAtIndex:[dropDownPickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
        // set select index question
        questionIndex = [dropDownPickerView selectedRowInComponent:0];
        NSLog(@"currentQuestion %@",currentQuestion);
        NSLog(@"questionIndex %d",questionIndex);
    }else if(item.tag == 5){
        currentCountry = [country objectAtIndex:[dropDownPickerView selectedRowInComponent:0]];
        [currentButton setTitle:[country objectAtIndex:[dropDownPickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
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
        return [country count];
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        return 0;
    }else if(pickerView.tag == 2){
        return [question objectAtIndex:row];

    }else{
        return [country objectAtIndex:row];
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
        [pickerLabel setText:[country objectAtIndex:row]];
    }
    return pickerLabel;
    
}
#pragma mark - hint button
-(IBAction)onHintButtonClicked:(id)sender
{
    [Util alertUtilWithTitle:@"กฏการตั้งรหัสผ่าน" msg:@"- ต้องมีความยาว 8 ตัวอักษรเท่านั้น\n - ใช้ตัวอักษรภาษาอังกฤษได้ (a-z , A-Z)\n - ใช้ตัวเลขได้ (0-9)\n - ต้องไม่ใช้คำว่า “password”\n - ต้องไม่เหมือนหรือคล้ายกับชื่อผู้ใช้"];
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
            
            NSString *yearString = [formatterYear stringFromDate:[NSDate date]];
            NSString *defaulDateStr= [NSString stringWithFormat:@"%@%@",@"01/01/",yearString];
            defaulDate = [formatterDefault dateFromString:defaulDateStr];
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
        }
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
    return 90;
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
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	UITextField* tf = nil ;
    
    textFieldModel = [Util loadViewWithNibName:@"TextFieldModel"];
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
                textFieldModel.pTextfieldLine.hidden = NO;
//                textFieldModel.pTxt.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
                [textFieldModel addSubview:[FormUtil initLabelWithSubTitleText:[TextFormatterUtil formatIdCard:self.pNid]]];
                [cell addSubview:textFieldModel];
                break ;
            }
            case 1: {
                textFieldModel.pTxt.text = self.password;
                textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"password"];
                //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pTxt.secureTextEntry = YES;
                tf = passwordField_ = textFieldModel.pTxt;
                [textFieldModel.pButton addTarget:self action:@selector(onHintButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [textFieldModel.pButton setImage:[UIImage imageNamed:@"icon_hint.png"] forState:UIControlStateNormal];
                [cell addSubview:textFieldModel];
                
                break ;
            }
            case 2: {
                textFieldModel.pTxt.text = self.confirmPassword;
                textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"confirmPassowrd"];
                //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
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
                textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"email"];
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
                    [dropdownViewModel.pDropdownButton setTitle:[Util loadPlaceholder:@"birthDate"] forState:UIControlStateNormal];
                } else {
                    [dropdownViewModel.pDropdownButton setTitle:currentDate forState:UIControlStateNormal];
                }
                dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
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
                dropdownViewModel.pDropdownButton.titleLabel.textAlignment = UITextAlignmentRight;
                if ([Util validateEmptyFieldWithString:currentQuestion]) {
                    [dropdownViewModel.pDropdownButton setTitle:[Util loadPlaceholder:@"question"] forState:UIControlStateNormal];
                } else {
                    [dropdownViewModel.pDropdownButton setTitle:currentQuestion forState:UIControlStateNormal];
                }
                
                dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                [dropdownViewModel.pDropdownButton setTag:indexPath.row];
                [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:dropdownViewModel];
                
                break ;
            }
            case 3: {
                textFieldModel.pTxt.text = self.answer;
                textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"answer"];
               // textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
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
                    textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"name"];;
                    //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = nameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];

                    break ;
                }
                case 1: {
                    textFieldModel.pTxt.text = self.midleName;
                    textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"middleName"];
                    //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = middleNameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 2: {
                    textFieldModel.pTxt.text = self.surname;
                    textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"surname"];
                    //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = surnameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];

                    break ;
                }
                case 3: {
                    textFieldModel.pTxt.text = self.telephone;
                    textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"contractNo"];
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
                    textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"fatherName"];
                    //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = fatherNameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 5: {
                    textFieldModel.pTxt.text = self.motherName;
                    textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"middleName"];;
                    //textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
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
                    textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"name"];
//                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = nameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 1: {
                    textFieldModel.pTxt.text = self.midleName;
                    textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"middleName"];
//                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = middleNameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 2: {
                    textFieldModel.pTxt.text = self.surname;
                    textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"surname"];
//                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = surnameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 3: {
                    textFieldModel.pTxt.text = self.telephone;
                    textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"contractNo"];
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
                    textFieldModel.pTxt.placeholder = [Util loadPlaceholder:@"passportNo"];
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
                    dropdownViewModel.pDropdownButton.titleLabel.textAlignment = UITextAlignmentRight;
                    if ([Util validateEmptyFieldWithString:currentCountry]) {
                        [dropdownViewModel.pDropdownButton setTitle:[Util loadPlaceholder:@"countryCode"]forState:UIControlStateNormal];
                    } else {
                        [dropdownViewModel.pDropdownButton setTitle:currentCountry forState:UIControlStateNormal];
                    }
                    
                    dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                    [dropdownViewModel.pDropdownButton setTag:indexPath.row];
                    [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:dropdownViewModel];
                    
                    break ;
                }
                    
            }
        }
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    [tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    tf.delegate = self ;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (IBAction)textFieldFinished:(id)sender {
    //[sender resignFirstResponder];
}
- (BOOL) validateField {
    //--focus
    isTF = @"Y";
    
    if(countryIndex){
        currentCountry = [countryCode objectAtIndex:countryIndex];
    }
    if(![currentQuestion isEqualToString:@""]){
        questionIdStr = [questionId objectAtIndex:questionIndex];
        NSLog(@"selectedQuestion : %@", questionIdStr);
    }
    
    birthdateStr = [currentDate stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    if([self.pThaiNation isEqualToString: @"1"]
       ){
        if([Util validatePasswordEmpty:self.password]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"passwordEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"1" section:@"0"];
            return NO;
        }else if([Util validatePasswordEmpty:self.confirmPassword]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"confirmPasswordEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"2" section:@"0"];
            return NO;
        }
        if([Util validatePasswordIsEqualConfirmPassword:self.password confirmPassword:self.confirmPassword]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"passwordNotEqual"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"1" section:@"0"];
            return NO;
        }else if([Util validatePasswordIsExceptWord:self.password]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"passwordWrong"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"1" section:@"0"];
            return NO;
        }else if([Util validatePasswordIsExceptWord:self.confirmPassword]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"confirmPasswordWrong"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"2" section:@"0"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.email]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"emailEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"0" section:@"1"];
            return NO;
        }
        else if(![Util validateEmail:self.email]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"emailWrong"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"0" section:@"1"];
            return NO;
        }
        else if([Util validateEmptyFieldWithString:birthdateStr]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"birthDateEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"1" section:@"1"];
            isTF = @"N";
            return NO;
        }
        else if([Util validateEmptyFieldWithString:questionIdStr]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"questionIdEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"2" section:@"1"];
            isTF = @"N";
            return NO;
        }
        else if([Util validateEmptyFieldWithString:self.answer]){
            NSLog(@"answer not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"answerEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"3" section:@"1"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.name]){
            NSLog(@"name not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"nameEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"0" section:@"2"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.surname]){
            NSLog(@"surname not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"surnameEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"2" section:@"2"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.telephone]){
            NSLog(@"telephone not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"contractNoEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"3" section:@"2"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.fatherName]){
            NSLog(@"fathername not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"fatherNameEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"4" section:@"2"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.motherName]){
            NSLog(@"mothername not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"motherNameEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"5" section:@"2"];
            return NO;
        }else{
            return YES;
        }
    }else{
        
        if([Util validatePasswordEmpty:self.password]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"passwordEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"1" section:@"0"];
            return NO;
        }else if([Util validatePasswordEmpty:self.confirmPassword]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"confirmPasswordEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"2" section:@"0"];
            return NO;
        }
        if([Util validatePasswordIsEqualConfirmPassword:self.password confirmPassword:self.confirmPassword]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"passwordNotEqual"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"1" section:@"0"];
            return NO;
        }else if([Util validatePasswordIsExceptWord:self.password]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"passwordWrong"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"1" section:@"0"];
            return NO;
        }else if([Util validatePasswordIsExceptWord:self.confirmPassword]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"confirmPasswordWrong"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"2" section:@"0"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.email]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"emailEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"0" section:@"1"];
            return NO;
        }
        else if(![Util validateEmail:self.email]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"emailWrong"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"0" section:@"1"];
            return NO;
        }
        else if([Util validateEmptyFieldWithString:birthdateStr]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"birthDateEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"1" section:@"1"];
            isTF = @"N";
            return NO;
        }
        else if([Util validateEmptyFieldWithString:questionIdStr]){
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"questionIdEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"2" section:@"1"];
            isTF = @"N";
            return NO;
        }
        else if([Util validateEmptyFieldWithString:self.answer]){
            NSLog(@"answer not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"answerEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"3" section:@"1"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.name]){
            NSLog(@"name not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"nameEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"0" section:@"2"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.surname]){
            NSLog(@"surname not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"surnameEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"2" section:@"2"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.telephone]){
            NSLog(@"telephone not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"contractNoEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"3" section:@"2"];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.passportNo]){
            NSLog(@"passport not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"passportNoEmpty"]];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"4" section:@"2"];
            return NO;
        }
        else if([Util validateEmptyFieldWithString:[NSString stringWithFormat:@"%@",currentCountry]]){
            NSLog(@"countrycode not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"countrycode not corect"];
            //--focus
            [self becomeFirstResponderTextFieldWithIndex:@"5" section:@"2"];
            isTF = @"N";
            return NO;
        }
        else{
            return YES;
        }
        
    }
    
}

#pragma - call service
- (void) callRegisterSaveService{
    enRegisterSaveService = [[ENRegisterSaveService alloc]init];
    enRegisterSaveService.delegate = self;
    NSLog(@"\n call enRegisterSaveService");
    NSLog(@"nid %@",self.pNid);
    if([self.pThaiNation isEqualToString:@"1"]){
        [enRegisterSaveService requestENRegisterSaveService:[TextFormatterUtil removeMinusSignFromString:self.pNid]
                                                   password:self.password
                                                      email:self.email
                                                  birthDate:birthdateStr
                                                 questionId:questionIdStr
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
        [enRegisterSaveService requestENRegisterSaveService:[TextFormatterUtil removeMinusSignFromString:self.pNid]
                                                   password:self.password
                                                      email:self.email
                                                  birthDate:birthdateStr
                                                 questionId:questionIdStr
                                                     answer:self.answer
                                                       name:self.name
                                                    surname:self.surname
                                                  telephone:[TextFormatterUtil removeMinusSignFromString:self.telephone]
                                         telephoneExtension:self.telephoneExtension
                                                 fatherName:@""
                                                 motherName:@""
                                                 passportNo:self.passportNo
                                                countryCode:currentCountry
                                                    moiFlag:@"N"
                                                    middleName:self.midleName];
        
        
    }
}
- (void) callRegisterSaveServiceWithMOI{
    isCallMoi = YES;
    
    enRegisterSaveService = [[ENRegisterSaveService alloc]init];
    enRegisterSaveService.delegate = self;
    NSLog(@"\n call enRegisterSaveService");
   
    if([self.pThaiNation isEqualToString:@"1"]){
        [enRegisterSaveService requestENRegisterSaveService:[TextFormatterUtil removeMinusSignFromString:self.pNid]
                                                   password:self.password
                                                      email:self.email
                                                  birthDate:birthdateStr
                                                 questionId:questionIdStr
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
        [enRegisterSaveService requestENRegisterSaveService:[TextFormatterUtil removeMinusSignFromString:self.pNid]
                                                   password:self.password
                                                      email:self.email
                                                  birthDate:birthdateStr
                                                 questionId:questionIdStr
                                                     answer:self.answer
                                                       name:self.name
                                                    surname:self.surname
                                                  telephone:[TextFormatterUtil removeMinusSignFromString:self.telephone]
                                         telephoneExtension:self.telephoneExtension
                                                 fatherName:@""
                                                 motherName:@""
                                                 passportNo:self.passportNo
                                                countryCode:currentCountry
                                                    moiFlag:@"N"
                                                    middleName:self.midleName];
        
        
    }
}

- (void) responseENRegisterSaveService:(NSDictionary *)data{
    
    NSDictionary *dic = data;
    if([[dic objectForKey:@"responseCode"]isEqualToString:@"0"]){
        if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"SUCCESS"]) {
            response = @"Success";
            NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
            
            if (isCallMoi) {
                
                nameField_.text = [responseDataDic objectForKey:@"name"];
                surnameField_.text = [responseDataDic objectForKey:@"surname"];
                //-- message return from moi
                [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseMessage"]];
                
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
                
                vc.pNid = self.pNid;
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
            
            //[Util stringWithScreenName:@"Register" labelName:@"ResConfirm"]
            [self alertYesNoWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] detail:[dic objectForKey:@"responseMessage"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"] no:[Util stringWithScreenName:@"Common" labelName:@"No"]];
            
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
    NSArray *viewControllers = [[self navigationController] viewControllers];
    if (buttonIndex == 0) {
        [self callRegisterSaveServiceWithMOI];
        
    } else if (buttonIndex == 1){
//            EfilingRegisterConfirmViewController *vc = [[EfilingRegisterConfirmViewController alloc]initWithNibName:@"EfilingRegisterConfirmViewController" bundle:nil];
//            
//            vc.pNid = self.pNid;
//            vc.pBuildName = [responseDataConfirmDic objectForKey:@"buildName"];
//            vc.pRoomNo = [responseDataConfirmDic objectForKey:@"roomNo"];
//            vc.pFloorNo = [responseDataConfirmDic objectForKey:@"floorNo"];
//            vc.pAddressNo = [responseDataConfirmDic objectForKey:@"addressNo"];
//            vc.pSoi = [responseDataConfirmDic objectForKey:@"soi"];
//            vc.pVillage = [responseDataConfirmDic objectForKey:@"village"];
//            vc.pMooNo = [responseDataConfirmDic objectForKey:@"mooNo"];
//            vc.pStreet = [responseDataConfirmDic objectForKey:@"street"];
//            vc.pTumbol = [responseDataConfirmDic objectForKey:@"tambol"];
//            vc.pAmphur = [responseDataConfirmDic objectForKey:@"amphur"];
//            vc.pProvince = [responseDataConfirmDic objectForKey:@"province"];
//            vc.pPostcode = [responseDataConfirmDic objectForKey:@"postcode"];
//            vc.pContractNo = [responseDataConfirmDic objectForKey:@"contractNo"];
//            NSLog(@"contractNo %@",vc.pContractNo);
//        [self.navigationController pushViewController:obj animated:YES];

        for( int i=0;i<[viewControllers count];i++){
            id obj=[viewControllers objectAtIndex:i];
            if([obj isKindOfClass:[EfilingCheckNewUserViewController class]]){
                [[self navigationController] popToViewController:obj animated:YES];
                return;
            }
        }
        
    }
}

- (IBAction)onContinueButtonClicked:(id)sender {
    if ([self validateField] == YES) {
        if ([Util isInternetConnect]) {
            [self callRegisterSaveService];
        } else {
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
        }
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
#pragma mark - FOCUS
- (void) becomeFirstResponderTextFieldWithIndex : (NSString *) index section:(NSString *)section {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[index intValue] inSection:[section intValue]];
    currentSection = [section intValue];
    currentIndex = [index intValue];
    
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
@end
