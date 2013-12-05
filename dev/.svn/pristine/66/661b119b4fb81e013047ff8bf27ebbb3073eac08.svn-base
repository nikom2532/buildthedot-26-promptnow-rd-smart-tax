//
//  EfilingValidatePasswordViewController.m
//  RDSmartTax
//
//  Created by fone on 12/4/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingValidatePasswordViewController.h"
#import "EfilingForgetPasswordViewController.h"

#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"

#define PASSWORD_MAX_LENGHT 8

@interface EfilingValidatePasswordViewController () {
    
    UITextField *activeTextField;
    CGRect originScrollViewFrame;
    CGSize contentsize;
    
    ENAuthenService *enAuthenService;
    
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
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    if (range.location == PASSWORD_MAX_LENGHT) {
        return NO;
    }
    
    if ([string length] == 0) {
        return YES;
    }
    
    return YES;
}

#pragma - Decorate Label
- (void) setLanguage {
    
    [self.labelTitile setText:[Util stringWithLabelName:@"Login"]];
    [self.labelIdCard setText:[Util stringWithLabelName:@"LoginIdCard"]];
    [self.labelIdCardNumber setText:[TextFormatterUtil formatIdCard:self.pIdCard]];
    [self.btnLogin setTitle:[Util stringWithLabelName:@"Login"] forState:UIControlStateNormal];
    [self.btnForgetPassword setTitle:[Util stringWithLabelName:@"ForgetPassword"] forState:UIControlStateNormal];
    
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
    NSLog(@"response : %@", dic);
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        
        //-- Initial data from Authen Service
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        [ShareUserDetail initialData:responseDataDic];
        
    } else {
        [Util alertUtilWithTitle:[Util stringWithLabelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
}


@end
