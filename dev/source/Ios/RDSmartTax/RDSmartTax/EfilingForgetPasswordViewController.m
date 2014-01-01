//
//  EfilingForgetPasswordViewController.m
//  RDSmartTax
//
//  Created by Noi on 12/16/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingForgetPasswordViewController.h"
#import "ENResetPasswordRequestService.h"
#import "EfilingSendEmailViewController.h"
#import "EfilingForgetPasswordQuestionViewController.h"

#import "TextFieldModel.h"
#import "DropdownViewModel.h"
#import "Header.h"

#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"

@interface EfilingForgetPasswordViewController (){
    ENResetPasswordRequestService *enResetPasswordRequestService;
    NSLocale *currentLocale;
    NSDateFormatter* dateFormatter;
    NSString *currentDate;
    
    DropdownViewModel *dropdownViewModel;
    UIPickerView *dropDownPickerView;
    UIActionSheet *dropDownActionSheet;
    UIButton *currentButton;
    
    UIDatePicker *dropDownDatePickerView;
}

@end

@implementation EfilingForgetPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [self setFontStyle];
    currentDate = @"";
    //-- Check locale
    currentLocale = [self checkLocale];
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSLog(@"format %u",dateFormatter.dateStyle);
    [dateFormatter setLocale:currentLocale];
    
    //-- DROPDOWN MODEL
    dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
    dropdownViewModel.pTitle.text = [Util stringWithScreenName:@"Common" labelName:@"BirthDate"];
    dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    dropdownViewModel.pHintButton.hidden = YES;
    if ([Util validateEmptyFieldWithString:currentDate]) {
        [dropdownViewModel.pDropdownButton setTitle:[Util stringWithScreenName:@"Common" labelName:@"BirthDate"] forState:UIControlStateNormal];
    } else {
        [dropdownViewModel.pDropdownButton setTitle:currentDate forState:UIControlStateNormal];
    }
    dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownDatePickerClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.birthDateView addSubview:dropdownViewModel];
    
    
    self.pNid = [TextFormatterUtil formatIdCard:self.pNid];
    NSLog(@"nid %@",self.pNid);
    self.txtNid.text = self.pNid;
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setLanguage];
    [self.btnConfirm.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    //self.title=[Util stringWithScreenName:@"Login" labelName:@"ForgetPassword"];

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
    [UIView beginAnimations:nil context:NULL]; [UIView setAnimationDuration:0.35f]; CGRect frame = self.view.frame; frame.origin.y = -100; [self.view setFrame:frame]; [UIView commitAnimations];
    txtActiveEditing = textField;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    if ( textField == self.txtBirthDates ) {
    //		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.birthDate"] integerValue]) {
    //            return NO;
    //        }
    //
    //	}
    return YES;
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
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    [toolBar sizeToFit];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Cancel"] style:UIBarButtonItemStyleBordered target:delegate action:@selector(cancel_clicked:)];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Done"] style:UIBarButtonItemStyleBordered target:delegate action:@selector(done_clicked:)];
    
    doneBtn.tag = tag;
    cancelBtn.tag = tag;
    
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
    
    currentDate = [dateFormatter stringFromDate:dropDownDatePickerView.date];
    [currentButton setTitle:[dateFormatter stringFromDate:dropDownDatePickerView.date] forState:UIControlStateNormal];
    NSLog(@"cuurent date %@",currentDate);
    
    [dropDownActionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
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
    NSLog(@"tag : %d", tag);
    dropDownActionSheet = [[UIActionSheet alloc] init];
    dropDownActionSheet.tag = tag;
    
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
    
    [dropDownDatePickerView addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    dropDownDatePickerView.tag = tag;
    
    
    
    //-- Set default dropdown??
    //    [dropDownDatePickerView selectRow:[currentTaxpayerStatus intValue] inComponent:0 animated:NO];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    [toolBar sizeToFit];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Cancel"] style:UIBarButtonItemStyleBordered target:delegate action:@selector(cancel_clicked:)];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Done"] style:UIBarButtonItemStyleBordered target:delegate action:@selector(done_clicked:)];
    
    doneBtn.tag = tag;
    
    NSArray *barItems = @[cancelBtn, flexSpace, doneBtn];
    
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
    //    currentQuestion = [self selectedQuestion:dropdownViewModel.pDropdownButton.currentTitle];
    //    NSLog(@"current qestion %@",currentQuestion);
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

#pragma - Decorate Label
- (void) setLanguage {
    [self.txtNid setText:[TextFormatterUtil formatIdCard:self.pNid]];
    [self.labelNid setText:[Util stringWithScreenName:@"Common" labelName:@"Nid"]];
    [self.labelBirthDate setText:[Util stringWithScreenName:@"Common" labelName:@"BirthDate"]];
    [self.btnConfirm setTitle:[Util stringWithScreenName:@"Common" labelName:@"Confirm"] forState:UIControlStateNormal];
    
}

- (void) setFontStyle {
    [self.txtNid setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.labelNid setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [self.labelBirthDate setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [self.btnConfirm.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onConfirmButtonClicked:(id)sender {
    if ([self validateField] == YES) {
        [self callResetPasswordRequestService];
        
    }
}
- (BOOL) validateField {
    NSLog(@"bd,%@",self.txtBirthDates.text);
    if([Util validateEmptyFieldWithString:currentDate]){
        NSLog(@"birthdate empty");
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    }else{
        return YES;
    }
    
    
}
#pragma - call service
- (void) callResetPasswordRequestService{
    enResetPasswordRequestService = [[ENResetPasswordRequestService alloc]init];
    enResetPasswordRequestService.delegate = self;
    NSLog(@"date %@",self.txtBirthDates.text);
    NSLog(@"\n call enResetPasswordRequestService");
    NSString *version= [Util loadAppSettingWithName:@"Version"];
    
    [enResetPasswordRequestService requestENResetPasswordRequestService:self.pNid
                                                              birthDate:self.txtBirthDates.text
                                                                version:version];
    
}

-(void) responseENResetPasswordRequestService:(NSData *)data{
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    NSLog(@"response : %@", dic);
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        NSString *email = [responseDataDic objectForKey:@"email"];
        NSLog(@"email %@",email);
        
        if([Util validateEmptyFieldWithString:email] ){
            EfilingForgetPasswordQuestionViewController *vc = [[EfilingForgetPasswordQuestionViewController alloc]initWithNibName:@"EfilingForgetPasswordQuestionViewController" bundle:nil];
            
            vc.pNid = self.pNid;
            vc.pBirthDate = self.txtBirthDates.text;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else{
            EfilingSendEmailViewController *vc = [[EfilingSendEmailViewController alloc]initWithNibName:@"EfilingSendEmailViewController" bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            vc.pNid = self.pNid;
            vc.pEmail = [responseDataDic objectForKey:@"email"];
        }
        
        
    }
    if([[dic objectForKey:@"responseStatus"] isEqualToString:@"Error"]) {
        //        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
        [self alertResultWithTitle:@"" detail:[Util stringWithScreenName:@"Common" labelName:@"Failure"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
    }
    
}
//- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//
//    if (buttonIndex == 0) {
//             [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//}
//- (void) alertYesNoWithTitle : (NSString *)title detail:(NSString *)detail yes:(NSString *)yes no:(NSString *)no {
//    UIAlertView *alert = [[UIAlertView alloc] init];
//    [alert setTitle:title];
//    [alert setMessage:detail];
//    [alert setDelegate:self];
//    [alert addButtonWithTitle:yes];
//    [alert addButtonWithTitle:no];
//    [alert show];
//}
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
            if([obj isKindOfClass:[[self.navigationController popToRootViewControllerAnimated:YES] class]]){
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
