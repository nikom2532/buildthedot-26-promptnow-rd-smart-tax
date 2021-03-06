//
//  EfilingChangePasswordViewController.m
//  RDSmartTax
//
//  Created by fone on 12/21/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingChangePasswordViewController.h"
#import "ENChangePassword.h"
#import "EfilingCheckNewUserViewController.h"
#import "EfilingValidatePasswordViewController.h"
#import "EfilingHomeViewController.h"

#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"
@interface EfilingChangePasswordViewController (){
    NSString *response;
    UITextField *activeTextField;
}

@end

@implementation EfilingChangePasswordViewController
@synthesize enChangePasswordService;

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
    
    self.txtOldPassword.delegate =self;
    self.txtNewPassword.delegate =self;
    self.txtConfirmPassword.delegate =self;

    [self.txtOldPassword setSecureTextEntry:YES];
    [self.txtNewPassword setSecureTextEntry:YES];
    [self.txtConfirmPassword setSecureTextEntry:YES];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setLanguage];
    [self createHeader];
    [txtActiveEditing becomeFirstResponder];
}
-(void) createHeader{
    // navigation bar
    self.navigationController.navigationBar.hidden = YES;
    Header *header = [Util loadViewWithNibName:@"Header"];
    header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    header.pLabel.text = [Util stringWithScreenName:@"ChangePassword" labelName:@"ChangePasswordTitle"];
    header.pLabel.font = [FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold];
    [header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    header.pRightButton.hidden = YES;
    [self.view addSubview:header];
    
}
#pragma mark -
#pragma mark Textfield
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
    if ( textField == self.txtOldPassword) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.password"] integerValue]) {
            return NO;
        }
        
	}else if(textField == self.txtNewPassword){
        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.password"] integerValue]) {
            return NO;
        }
    }else if(textField == self.txtConfirmPassword){
        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.password"] integerValue]) {
            return NO;
        }
    }
    
    if (range.location > 0 && range.length == 1 && string.length == 0)
    {
        // Stores cursor position
        UITextPosition *beginning = textField.beginningOfDocument;
        UITextPosition *start = [textField positionFromPosition:beginning offset:range.location];
        NSInteger cursorOffset = [textField offsetFromPosition:beginning toPosition:start] + string.length;
        
        // Save the current text, in case iOS deletes the whole text
        NSString *text = textField.text;
        
        
        // Trigger deletion
        [textField deleteBackward];
        
        
        // iOS deleted the entire string
        if (textField.text.length != text.length - 1)
        {
            textField.text = [text stringByReplacingCharactersInRange:range withString:string];
            
            // Update cursor position
            UITextPosition *newCursorPosition = [textField positionFromPosition:textField.beginningOfDocument offset:cursorOffset];
            UITextRange *newSelectedRange = [textField textRangeFromPosition:newCursorPosition toPosition:newCursorPosition];
            [textField setSelectedTextRange:newSelectedRange];
        }
        
        return NO;
    }

    return YES;
}
#pragma - Decorate Label
- (void) setLanguage {
    [self.labelOldPassword setText:[Util stringWithScreenName:@"Common" labelName:@"OldPassword"]];
    [self.labelNewPassword setText:[Util stringWithScreenName:@"Common" labelName:@"NewPassword"]];
    [self.labelConfirmPassword setText:[Util stringWithScreenName:@"Common" labelName:@"ConfirmNewPassword"]];
    
    [self.btnConfirm setTitle:[Util stringWithScreenName:@"Common" labelName:@"Confirm"] forState:UIControlStateNormal];
    
    
}

- (void) setFontStyle {
    
    [self.labelOldPassword setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
    [self.labelNewPassword setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
    [self.labelConfirmPassword setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
    [self.txtOldPassword setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [self.txtNewPassword setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [self.txtConfirmPassword setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    self.txtOldPassword.textAlignment = UITextAlignmentRight;
    self.txtNewPassword.textAlignment = UITextAlignmentRight;
    self.txtConfirmPassword.textAlignment = UITextAlignmentRight;

    [self.btnConfirm.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onConfirmButtonClicked:(id)sender {
    if ([self validateField] == YES) {
        if ([Util isInternetConnect]) {
            [self callChangePassword];
        } else {
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
        }
    }
}

- (IBAction)onHintOldPasswordButtonClicked:(id)sender {
    [Util alertUtilWithTitle:@"Hint" msg:@"ใส่รหัสผ่านเดิม"];
}

- (IBAction)onHintNewPasswordButtonClicked:(id)sender {
    [Util alertUtilWithTitle:[Util stringWithScreenName:@"Hint" labelName:@"TitlePassword"] msg:[Util stringWithScreenName:@"Hint" labelName:@"TextPassword"]];
}

- (IBAction)onHintConfirmPasswordButtonClicked:(id)sender {
    [Util alertUtilWithTitle:[Util stringWithScreenName:@"Hint" labelName:@"TitlePassword"] msg:[Util stringWithScreenName:@"Hint" labelName:@"TextPassword"]];
}
- (BOOL) validateField {
    response = @"validate";
    if([Util validatePasswordEmpty:self.txtOldPassword.text]){
       [self alertResultWithTitle:@"" detail:[Util loadErrorMessageWithValidateField:@"oldPasswordEmpty"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        txtActiveEditing = self.txtOldPassword;
        return NO;
    }else if([Util validatePasswordEmpty:self.txtNewPassword.text]){
        [self alertResultWithTitle:@"" detail:[Util loadErrorMessageWithValidateField:@"newPasswordEmpty"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        txtActiveEditing = self.txtNewPassword;
        return NO;
    }else if([Util validatePasswordEmpty:self.txtConfirmPassword.text]){
        [self alertResultWithTitle:@"" detail:[Util loadErrorMessageWithValidateField:@"confirmPasswordEmpty"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        txtActiveEditing = self.txtNewPassword;
         txtActiveEditing = self.txtConfirmPassword;
        return NO;
    }else if([Util validatePasswordIsExceptWord:self.txtNewPassword.text]){
        [self alertResultWithTitle:@"" detail:[Util loadErrorMessageWithValidateField:@"newPasswordWrong"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        txtActiveEditing = self.txtNewPassword;
        return NO;
    }else if([Util validatePasswordIsExceptWord:self.txtConfirmPassword.text]){
        [self alertResultWithTitle:@"" detail:[Util loadErrorMessageWithValidateField:@"newPasswordWrong"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        txtActiveEditing = self.txtNewPassword;
        return NO;
    }else if([Util validatePasswordIsEqualConfirmPassword:self.txtNewPassword.text confirmPassword:self.txtConfirmPassword.text]){
        [self alertResultWithTitle:@"" detail:[Util loadErrorMessageWithValidateField:@"passwordNotEqual"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        txtActiveEditing = self.txtNewPassword;
        return NO;
    }
    else{
        return YES;
    }
    
}
#pragma - call service
- (void) callChangePassword{
    enChangePasswordService = [[ENChangePassword alloc]init];
    enChangePasswordService.delegate = self;
    
    NSLog(@"\n call enChangePasswordService");
    [enChangePasswordService requestENChangePasswordService:[ShareUserDetail retrieveDataWithStringKey:@"nid"]
                                                oldPassword:self.txtOldPassword.text
                                                newPassword:self.txtNewPassword.text
                                                authenKey:[ShareUserDetail retrieveDataWithStringKey:@"authenKey"]];
    
}

-(void)responseENChangePasswordService:(NSDictionary*)data{
    NSDictionary *dic = data;//[NSDictionary dictionaryWithJSONData:data]
    if([[dic objectForKey:@"responseCode"]isEqualToString:@"0"]){
        if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
            response = @"success";
            [self alertResultWithTitle:@"" detail:[Util stringWithScreenName:@"Common" labelName:@"Success"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        }
        if([[dic objectForKey:@"responseStatus"] isEqualToString:@"Error"]) {
            response = @"fail";
            //        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
            [self alertResultWithTitle:@"" detail:[Util stringWithScreenName:@"Common" labelName:@"Failure"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
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
        if ([response isEqualToString:@"success"]) {
            for( int i=0;i<[viewControllers count];i++){
                id obj=[viewControllers objectAtIndex:i];
                if([obj isKindOfClass:[EfilingHomeViewController class]]){
                    [[self navigationController] popToViewController:obj animated:YES];
                    return;
                }
            }
        }else if([response isEqualToString:@"validate"]){
            [txtActiveEditing becomeFirstResponder];
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
