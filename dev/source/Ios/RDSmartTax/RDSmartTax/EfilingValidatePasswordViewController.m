//
//  EfilingValidatePasswordViewController.m
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingValidatePasswordViewController.h"
#import "EfilingForgetPasswordViewController.h"
#import "EfilingHomeViewController.h"
#import "EfilingTermsAndConditionsViewController.h"
#import "EfilingGeneralProfileViewController.h"

#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"

@interface EfilingValidatePasswordViewController () {
    
    UITextField *activeTextField;
    CGRect originScrollViewFrame;
    CGSize contentsize;
    
    ENAuthenService *enAuthenService;
    ENCheckConditionService *enCheckConditionService;
    ENCheckLoginFirstService *enCheckLoginFirstService;
    
    int maxLength;
}

@end

@implementation EfilingValidatePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setLanguage];
    
    [self.btnLogin setEnabled:NO];
    [self.btnLogin setBackgroundImage:[UIImage imageNamed:@"correct.png"] forState:UIControlStateNormal];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    maxLength = [[Util retrieveValidateConfigFromKey:@"rd.length.password"]integerValue];
    
    [self setFontStyle];
    
    [self.scrollView setContentSize:CGSizeMake(0,self.contentView.frame.size.height)];
    
    self.txtPassword.delegate = self;
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location == maxLength) {
        return NO;
    }
    
    if ([string length] == 0) {
        [self.btnLogin setEnabled:NO];
        [self.btnLogin setBackgroundImage:[UIImage imageNamed:@"correct.png"] forState:UIControlStateNormal];
        return YES;
    }
    
    if (range.location == 7) {
        [self.btnLogin setEnabled:YES];
        [self.btnLogin setBackgroundImage:[UIImage imageNamed:@"wrong.png"] forState:UIControlStateNormal];
    }
    
    return YES;
}

#pragma - Decorate Label
- (void) setLanguage {
    
    [self.labelTitile setText:[Util stringWithScreenName:@"Login" labelName:@"Title"]];
    [self.labelIdCard setText:[Util stringWithScreenName:@"Login" labelName:@"Nid"]];
    [self.labelIdCardNumber setText:[TextFormatterUtil formatIdCard:self.pIdCard]];
    [self.btnLogin setTitle:[Util stringWithScreenName:@"Login" labelName:@"Title"] forState:UIControlStateNormal];
    [self.btnForgetPassword setTitle:[Util stringWithScreenName:@"Login" labelName:@"ForgetPassword"] forState:UIControlStateNormal];
    
}

- (void) setFontStyle {
    
    [self.labelTitile setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [self.labelIdCard setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.labelIdCardNumber setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.txtPassword setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.btnLogin.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.btnForgetPassword.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onForgetPasswordButtonClicked:(id)sender {
    EfilingForgetPasswordViewController *vc = [[EfilingForgetPasswordViewController alloc]initWithNibName:@"EfilingForgetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onLoginButtonClicked:(id)sender {
    //-- Call Service
    enAuthenService = [[ENAuthenService alloc]init];
    enAuthenService.delegate = self;
    [enAuthenService requestENAuthenServiceWithUserId:self.pUserId password:self.txtPassword.text];
}

#pragma - response delegate
- (void) responseENAuthenService:(NSData *)data {
    
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        
        //-- Initial data from Authen Service
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        [ShareUserDetail initialData:responseDataDic];
        
        //-- Check term and condition
        enCheckConditionService = [[ENCheckConditionService alloc]init];
        enCheckConditionService.delegate = self;
        [enCheckConditionService requestENCheckConditionServiceWithNid:[ShareUserDetail retrieveDataWithStringKey:@"nid"]];
        
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
}

#pragma - response delegate
- (void) responseENCheckConditionService:(NSData *)data {
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        NSDictionary *responseDataDic =[dic objectForKey:@"responseData"];
        if ([[responseDataDic objectForKey:@"status"] isEqualToString:@"0"]) {
            //-- check first login
            enCheckLoginFirstService = [[ENCheckLoginFirstService alloc]init];
            enCheckLoginFirstService.delegate = self;
            [enCheckLoginFirstService requestENCheckLoginFirstServiceWithNid:[ShareUserDetail retrieveDataWithStringKey:@"nid"]];
            
        } else {
            //-- term
            EfilingTermsAndConditionsViewController *vc = [[EfilingTermsAndConditionsViewController alloc]initWithNibName:@"EfilingTermsAndConditionsViewController" bundle:nil];
            vc.pConditionDetail = [responseDataDic objectForKey:@"conditionDetail"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
}

#pragma - delegate method
- (void) responseENCheckLoginFirstService:(NSData *)data {
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        if ([[responseDataDic objectForKey:@"status"] isEqualToString:@"0"]) {
            EfilingHomeViewController *vc = [[EfilingHomeViewController alloc]initWithNibName:@"EfilingHomeViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            EfilingGeneralProfileViewController *vc = [[EfilingGeneralProfileViewController alloc]initWithNibName:@"EfilingGeneralProfileViewController" bundle:nil];
            vc.pFirstLogin = @"1";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
    
}

@end