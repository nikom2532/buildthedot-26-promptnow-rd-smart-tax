//
//  EfilingChangeOnlyPasswordViewController.m
//  RDSmartTax
//
//  Created by Noi on 12/19/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingChangeOnlyPasswordViewController.h"
#import "ENChangeOnlyPasswordService.h"
#import "EfilingValidatePasswordViewController.h"
#import "EfilingCheckNewUserViewController.h"

#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"

@interface EfilingChangeOnlyPasswordViewController (){
    UITextField *activeTextField;
    NSString* nid;
    NSString* response;
}


@end

@implementation EfilingChangeOnlyPasswordViewController
@synthesize enChangeOnlyPasswordService;

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
     nid = self.pNid;
    
    self.txtNewPassword.delegate =self;
    self.txtConfirmNewPassword.delegate =self;
    
    [self.txtNewPassword setSecureTextEntry:YES];
    [self.txtConfirmNewPassword setSecureTextEntry:YES];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setLanguage];
    //self.title=[Util stringWithScreenName:@"Login" labelName:@"ForgetPassword"];
    [self createHeader];
}
-(void) createHeader{
    self.navigationController.navigationBar.hidden = YES;
    Header *header = [Util loadViewWithNibName:@"Header"];
    header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    header.pLabel.text = [Util stringWithScreenName:@"Login" labelName:@"ForgetPassword"];
    header.pLabel.font = [FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold];
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
    if ( textField == self.txtNewPassword) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.password"] integerValue]) {
            return NO;
        }
        
	}else if(textField == self.txtConfirmNewPassword){
        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.password"] integerValue]) {
            return NO;
        }
    }
    return YES;
}
#pragma - Decorate Label
- (void) setLanguage {
    [self.labelNewPassword setText:[Util stringWithScreenName:@"Common" labelName:@"NewPassword"]];
    [self.labelConfirmPassword setText:[Util stringWithScreenName:@"Common" labelName:@"ConfirmNewPassword"]];
    [self.btnSave setTitle:[Util stringWithScreenName:@"Common" labelName:@"Save"] forState:UIControlStateNormal];
    [self.txtNewPassword setPlaceholder:[Util loadPlaceholder:@"newPassword"]];
    [self.txtConfirmNewPassword setPlaceholder:[Util loadPlaceholder:@"confirmPassowrd"]];

    
}

- (void) setFontStyle {
    
    [self.labelNewPassword setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
    [self.labelConfirmPassword setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
    [self.txtNewPassword setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [self.txtConfirmNewPassword setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    self.txtNewPassword.textAlignment = UITextAlignmentRight;
    self.txtConfirmNewPassword.textAlignment = UITextAlignmentRight;
    [self.btnSave.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onHintPasswordButtonClicked:(id)sender {
    [Util alertUtilWithTitle:[Util stringWithScreenName:@"Hint" labelName:@"TitlePassword"] msg:[Util stringWithScreenName:@"Hint" labelName:@"TextPassword"]];
}

- (IBAction)onHintPasswordConfirmButtonClicked:(id)sender {
    [Util alertUtilWithTitle:[Util stringWithScreenName:@"Hint" labelName:@"TitlePassword"] msg:[Util stringWithScreenName:@"Hint" labelName:@"TextPassword"]];
}

- (IBAction)onConfirmButtonClicked:(id)sender {
    if ([self validateField] == YES) {
        if ([Util isInternetConnect]) {
            [self callChangeOnlyPassword];
        } else {
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
        }
    }
}
- (BOOL) validateField {
    response = @"validate";
    if([Util validatePasswordEmpty:self.txtNewPassword.text]){
        [self alertResultWithTitle:@"" detail:[Util loadErrorMessageWithValidateField:@"oldPasswordEmpty"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        txtActiveEditing = self.txtNewPassword;
        return NO;
    }else if([Util validatePasswordEmpty:self.txtConfirmNewPassword.text]){
        [self alertResultWithTitle:@"" detail:[Util loadErrorMessageWithValidateField:@"confirmPasswordEmpty"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        txtActiveEditing = self.txtConfirmNewPassword;
        return NO;
    }else if([Util validatePasswordIsExceptWord:self.txtNewPassword.text]){
        NSLog(@"Password field must not be password ");
//        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"passwordWrong"]];
        [self alertResultWithTitle:@"" detail:[Util loadErrorMessageWithValidateField:@"passwordWrong"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        txtActiveEditing = self.txtNewPassword;
        return NO;
    }else if([Util validatePasswordIsExceptWord:self.txtConfirmNewPassword.text]){
        NSLog(@"Password field must not be password ");
        //        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"passwordWrong"]];
        [self alertResultWithTitle:@"" detail:[Util loadErrorMessageWithValidateField:@"confirmPasswordWrong"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        txtActiveEditing = self.txtNewPassword;
        return NO;
    }else{
        return YES;
    }
    
}
#pragma - call service
- (void) callChangeOnlyPassword{
    enChangeOnlyPasswordService = [[ENChangeOnlyPasswordService alloc]init];
    enChangeOnlyPasswordService.delegate = self;
    
    NSLog(@"\n call enChangeOnlyPasswordService");
    [enChangeOnlyPasswordService requestENChangeOnlyPasswordService:nid password:self.txtNewPassword.text];
    
}

-(void)responseENChangeOnlyPasswordService:(NSDictionary*)data{
    NSDictionary *dic = data;
    NSLog(@"response : %@", dic);
    if([[dic objectForKey:@"responseCode"]isEqualToString:@"0"]){
        if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"SUCCESS"]) {
            response = @"success";
             [self alertResultWithTitle:@"" detail:[Util stringWithScreenName:@"Common" labelName:@"Success"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        }
        if([[dic objectForKey:@"responseStatus"] isEqualToString:@"ERROR"]) {
            response = @"fail";
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
         if ([response isEqualToString:@"success"]) {
            for( int i=0;i<[viewControllers count];i++){
                id obj=[viewControllers objectAtIndex:i];
                if([obj isKindOfClass:[EfilingValidatePasswordViewController class]]){
                    [[self navigationController] popToViewController:obj animated:YES];
                    EfilingValidatePasswordViewController *vc = [[EfilingValidatePasswordViewController alloc]initWithNibName:@"EfilingValidatePasswordViewController" bundle:nil];
                    vc.pIdCard = self.pNid;
                    return;
                }
            }
         }else if([response isEqualToString:@"validate"]){
             [txtActiveEditing becomeFirstResponder];
         }else{
             for( int i=0;i<[viewControllers count];i++){
                 id obj=[viewControllers objectAtIndex:i];
                 if([obj isKindOfClass:[[self.navigationController popToRootViewControllerAnimated:YES] class]]){
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
