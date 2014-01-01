//
//  EfilingForgetPasswordQuestionViewController.m
//  RDSmartTax
//
//  Created by Noi on 12/19/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingForgetPasswordQuestionViewController.h"
#import "ENConfirmQuestionService.h"
#import "EfilingChangeOnlyPasswordViewController.h"
#import "EfilingAuthenUserViewController.h"

#import "TextFieldModel.h"
#import "DropdownViewModel.h"
#import "Header.h"

#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"
@interface EfilingForgetPasswordQuestionViewController (){
    ENConfirmQuestionService *enConfirmQuestionService;
    NSString* response;
    
    UITextField *activeTextField;
    NSString *defaultQuestion;
    NSMutableArray *questionId;
    NSMutableArray *question;
    int selectedQuestion;
    NSString *strSelectedQuestion;
    DropdownViewModel *dropdownViewModel;
    UIPickerView *dropDownPickerView;
    UIActionSheet *dropDownActionSheet;
    UIButton *currentButton;
}


@end

@implementation EfilingForgetPasswordQuestionViewController

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
    [self setFontStyle];
    self.pNid = [ShareUserDetail retrieveDataWithStringKey:@"nid"];
    strSelectedQuestion = @"";
    
    defaultQuestion = [Util stringWithScreenName:@"ForgetPassword" labelName:@"DefaultQuestion"];
    dropdownViewModel = [Util loadViewWithNibName:@"DropdownViewModel"];
    dropdownViewModel.pTitle.text = [Util stringWithScreenName:@"Common" labelName:@"Question"];
    dropdownViewModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    dropdownViewModel.pHintButton.hidden = YES;
    dropdownViewModel.pDropdownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [dropdownViewModel.pDropdownButton setTitle:[Util stringWithScreenName:@"ForgetPassword" labelName:@"DefaultQuestion"] forState:UIControlStateNormal];//
    [dropdownViewModel.pDropdownButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:dropdownViewModel];
    
     self.txtAnswer.delegate = self;
   
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setLanguage];
    [self getQuestionList];
    //self.title=[Util stringWithScreenName:@"Login" labelName:@"ForgetPassword"];
    [self createHeader];
}
-(void) createHeader{
    // navigation bar
    self.navigationController.navigationBar.hidden = YES;
    Header *header = [Util loadViewWithNibName:@"Header"];
    header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    header.pLabel.text = [Util stringWithScreenName:@"Login" labelName:@"ForgetPassword"];
    [header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    header.pRightButton.hidden = YES;
    [self.view addSubview:header];

}

#pragma - mark Textfield
#pragma mark - TextField delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    activeTextField=textField;
    [super textFieldDidBeginEditing:textField];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    activeTextField=nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (activeTextField) {
        [activeTextField resignFirstResponder];
        
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if( textField == self.txtAnswer) {
        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.answer"] integerValue]) {
            return NO;
        }
	}
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
    
    if(tag == 0)
    {
        dropDownPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
        dropDownPickerView.showsSelectionIndicator = YES;
        dropDownPickerView.dataSource = delegate;
        dropDownPickerView.delegate = delegate;
        dropDownPickerView.tag = tag;
    }
    
    //-- Set default dropdown
    [dropDownPickerView selectRow:[defaultQuestion intValue] inComponent:0 animated:NO];
    

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
    [dropdownViewModel.pDropdownButton setTitle:[question objectAtIndex:[dropDownPickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
    
    [dropDownActionSheet dismissWithClickedButtonIndex:0 animated:YES];
    selectedQuestion =[dropDownPickerView selectedRowInComponent:0];
    strSelectedQuestion = [NSString stringWithFormat:@"%d",selectedQuestion];
    NSLog(@"selectedQuestion : %@", strSelectedQuestion);
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [question count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [question objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [dropdownViewModel.pDropdownButton setTitle:[question objectAtIndex:row] forState:UIControlStateNormal];
    
}

#pragma - Decorate Label
- (void) setLanguage {
    [self.labelQuestion setText:[Util stringWithScreenName:@"Common" labelName:@"Question"]];
    [self.labelAnswer setText:[Util stringWithScreenName:@"Common" labelName:@"Answer"]];
    [self.btnConfirm setTitle:[Util stringWithScreenName:@"Common" labelName:@"Confirm"] forState:UIControlStateNormal];
    [self.btnForgetQuestion setTitle:[Util stringWithScreenName:@"Common" labelName:@"ForgetQuestion"] forState:UIControlStateNormal];
    
    [self.txtQuestion setPlaceholder:[Util stringWithScreenName:@"Common" labelName:@"Question"]];
    [self.txtAnswer setPlaceholder:[Util stringWithScreenName:@"Common" labelName:@"Answer"]];
}

- (void) setFontStyle {
    
    [self.labelQuestion setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [self.labelAnswer setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [self.btnConfirm.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [self.btnForgetQuestion.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) validateField {
    NSLog(@"selectedQuestion : %@", strSelectedQuestion);
    if([Util validateEmptyFieldWithString:strSelectedQuestion]){
        NSLog(@"question empty");
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    }else if([Util validateEmptyFieldWithString:self.txtAnswer.text]){
        NSLog(@"answer empty");
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
        return NO;
    }else{
        return YES;
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
- (IBAction)onConfirmButtonClicked:(id)sender {
    if ([self validateField] == YES) {
        [self callConfirmQuestionService];
    }else{
        
    }
    
}

- (IBAction)onForgotButtonClicked:(id)sender {
    EfilingAuthenUserViewController *vc = [[EfilingAuthenUserViewController alloc]initWithNibName:@"EfilingAuthenUserViewController" bundle:nil];
    vc.pNid = self.pNid;
    vc.pBirthDate = self.pBirthDate;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) callConfirmQuestionService{
    enConfirmQuestionService = [[ENConfirmQuestionService alloc]init];
    enConfirmQuestionService.delegate = self;
    NSLog(@"\n quesstion %@", strSelectedQuestion);
    NSLog(@"\n call enConfirmQuestionService");
    NSString *version= [Util loadAppSettingWithName:@"Version"];
    
    [enConfirmQuestionService requestENConfirmQuestion:self.pNid
                                                answer:strSelectedQuestion
                                            questionId:self.txtQuestion.text
                                               version:version];
    
}
- (void) responseENConfirmQuestionService:(NSData *)data{
    
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    NSLog(@"response : %@", dic);
   
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        EfilingChangeOnlyPasswordViewController *vc = [[EfilingChangeOnlyPasswordViewController alloc]initWithNibName:@"EfilingChangeOnlyPasswordViewController" bundle:nil];
        vc.pNid = self.pNid;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    if([[dic objectForKey:@"responseStatus"] isEqualToString:@"Error"]) {
        [self alertResultWithTitle:@"" detail:[dic objectForKey:@"responseError"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
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
            if([obj isKindOfClass:[EfilingForgetPasswordQuestionViewController class]]){
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
