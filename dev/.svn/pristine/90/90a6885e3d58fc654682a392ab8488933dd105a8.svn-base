//
//  EfilingCheckNewUserViewController.m
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingCheckNewUserViewController.h"
#import "EfilingRegisterSaveViewController.h"
#import "EfilingRegisterConfirmViewController.h"
#import "EfilingValidatePasswordViewController.h"
#import "SettingMainViewController.h"
#import "EfilingSuggestionViewController.h"

#import "FontUtil.h"
#import "Util.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "Header.h"

#import "OpenUDID.h"

@interface EfilingCheckNewUserViewController (){
    
    UITextField *activeTextField;
    CGRect originScrollViewFrame;
    CGSize contentsize;
    
    int maxLength;
    
    NSString *appStoreUrl;
    
}

@end

@implementation EfilingCheckNewUserViewController

@synthesize enCheckNewUserService;
@synthesize enCheckVersionService;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.txtIdCard.text = nil;
    [self setLanguage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.labelTitle1.hidden =  YES;
    self.tvDetail.hidden = YES;
    
    self.txtIdCard.delegate = self;
    
    if ([Util isInternetConnect]) {
        //-- check version
        enCheckVersionService = [[ENCheckVersionService alloc]init];
        enCheckVersionService.delegate = self;
        [enCheckVersionService requestENCheckVersionService:[Util loadAppSettingWithName:@"Version"]];
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
    }
    
    
    self.navigationController.navigationBar.hidden = YES;
    Header *header = [Util loadViewWithNibName:@"Header"];
    header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
//    header.pImage.image = [UIImage imageNamed:@"logo_efiling.png"];
    header.pLabel.hidden = NO;
    header.pLabel.text = [Util stringWithScreenName:@"Efiling" labelName:@"EfilingTitle"];
    header.pLabel.font = [FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold];
    
    header.pLeftButton.hidden = YES;
    [header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    header.pRightButton.hidden = NO;
    [header.pRightButton setImage:[UIImage imageNamed:@"icon_setting.png"] forState:UIControlStateNormal];
    [header.pRightButton addTarget:self action:@selector(onSettingBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.pHeaderView addSubview:header];
    
    maxLength = [[Util retrieveValidateConfigFromKey:@"rd.length.nid"] integerValue]+4;
    [self setFontStyle];
    
    [self.scrollView setContentSize:CGSizeMake(0,self.contentView.frame.size.height)];
    
    self.txtIdCard.delegate = self;
    
}

-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onSettingBtnClicked:(id)sender {
    SettingMainViewController *setting = [[SettingMainViewController alloc]initWithNibName:@"SettingMainViewController" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location == maxLength) {
        return NO;
    }
    
    if ([string length] == 0) {
        return YES;
    }
    
    if ((range.location == 1) || (range.location == 6) || (range.location == 12 || (range.location == 15))) {
        NSString *str    = [NSString stringWithFormat:@"%@-",textField.text];
        textField.text   = str;
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma - Scrollview
-(void)resizeScrollView
{
    CGRect contentViewFrame = self.contentView.frame;
    [self.contentView setFrame: contentViewFrame];
    [super updateContentsize:contentViewFrame.size];
    [super setDefaultPoint:CGPointMake(0, 0)];
    [UIView animateWithDuration:0.3 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
        [self.scrollView setContentSize:contentViewFrame.size];
    }];
}

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

#pragma - Decorate Label
- (void) setLanguage {
    [self.labelTitle1 setText:[Util stringWithScreenName:@"Login" labelName:@"Title1"]];
    [self.labelTitle2 setText:[Util stringWithScreenName:@"Login" labelName:@"Title2"]];
    [self.labelTitle3 setText:[Util stringWithScreenName:@"Login" labelName:@"Title3"]];
    [self.labelCal setText:[Util stringWithScreenName:@"Common" labelName:@"Calculator"]];
    [self.labelSuggestion setText:[Util stringWithScreenName:@"Common" labelName:@"Suggestion"]];
    [self.tvDetail setText:[Util stringWithScreenName:@"Login" labelName:@"Detail"]];
    [self.btnLogin setTitle:[Util stringWithScreenName:@"Login" labelName:@"Title"] forState:UIControlStateNormal];
}

- (void) setFontStyle {
    
    [self.labelTitle1 setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [self.labelTitle2 setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.labelTitle3 setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.tvDetail setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.txtIdCard setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.btnLogin.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [self.labelCal setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleBold]];

    [self.labelSuggestion setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleBold]];

}

#pragma - Response delegate
- (void) responseENCheckVersionService:(NSDictionary *)data {
    NSDictionary *dic = data;
    
    if ([[dic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
        if ([[dic objectForKey:@"update"] isEqualToString:@"Y"]) {
            appStoreUrl = [dic objectForKey:@"url"];
            [self alertYesNoWithTitle:@""detail:[Util loadErrorMessageWithValidateField:@"oldVersion"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"] no:[Util stringWithScreenName:@"Common" labelName:@"No"]];
        }
        
    }  else {
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
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreUrl]];
    } else if (buttonIndex == 1){
        return;
    }
}

- (void) responseENCheckNewUserService:(NSDictionary *)data {
    
    NSDictionary *dic = data;
    
    if ([[dic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        
        if ([[responseDataDic objectForKey:@"status"] isEqualToString:@"1"]) {
            
            //-- Old user
            EfilingValidatePasswordViewController *vc = [[EfilingValidatePasswordViewController alloc]initWithNibName:@"EfilingValidatePasswordViewController" bundle:nil];
            vc.pUserId = [responseDataDic objectForKey:@"userId"];
            vc.pIdCard = [TextFormatterUtil removeMinusSignFromString:self.txtIdCard.text];
            vc.pThaiNation = [responseDataDic objectForKey:@"thaiNation"];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            
            //-- New user
            EfilingRegisterSaveViewController *vc = [[EfilingRegisterSaveViewController alloc]initWithNibName:@"EfilingRegisterSaveViewController" bundle:nil];
            vc.pThaiNation = [responseDataDic objectForKey:@"thaiNation"];
            vc.pNid = [responseDataDic objectForKey:@"userId"];
            [self.navigationController pushViewController:vc animated:YES];
            
//              EfilingRegisterConfirmViewController *vc = [[EfilingRegisterConfirmViewController alloc]initWithNibName:@"EfilingRegisterConfirmViewController" bundle:nil];
//              [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }  else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseMessage"]];
    }
    
}

- (IBAction)onCalButtonClicked:(id)sender {
    
}

- (IBAction)onSuggestionButtonClicked:(id)sender {
    EfilingSuggestionViewController *suggestion = [[EfilingSuggestionViewController alloc]initWithNibName:@"EfilingSuggestionViewController" bundle:nil];
    [self.navigationController pushViewController:suggestion animated:YES];
}

- (IBAction)onLoginButtonClicked:(id)sender {
//    self.txtIdCard.text = @"3-7501-00119-10-5";
    if ([self validateField] == YES) {
        if ([Util isInternetConnect]) {
            //-- Call Service
            
            enCheckNewUserService = [[ENCheckNewUserService alloc]init];
            enCheckNewUserService.delegate = self;
            [enCheckNewUserService requestENCheckNewUserServiceWithIdCard:[TextFormatterUtil removeMinusSignFromString:self.txtIdCard.text]];
        } else {
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
        }
    }
}

#pragma mark - alert
- (void) alertUtilWithTitle : (NSString *) title msg : (NSString *) msg {
    UIAlertView *tryMeAlertview = [[UIAlertView alloc] initWithTitle: title
                                                             message: msg
                                                            delegate: self
                                                   cancelButtonTitle: [Util stringWithScreenName:@"Common" labelName:@"Ok"]
                                                   otherButtonTitles: nil];
    
    [tryMeAlertview show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) {
        [self.txtIdCard becomeFirstResponder];
    }
}

#pragma mark - validate field
- (BOOL) validateField {
    if ([self.txtIdCard.text isEqualToString:@""]){
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"nidEmpty"]];

        return NO;
    } else if (([self.txtIdCard.text length] < maxLength)){
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"nidWrong"]];

        return NO;
    } else if([Util validateIsDuplicated13digits:self.txtIdCard.text]){
        [self alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"nidWrong"]];
        
        return NO;
    } else {
        return YES;
    }
}

@end
