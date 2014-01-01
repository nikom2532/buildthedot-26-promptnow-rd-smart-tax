//
//  EfilingCheckNewUserViewController.m
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingCheckNewUserViewController.h"
#import "EfilingRegisterSaveViewController.h"
#import "EfilingValidatePasswordViewController.h"

#import "FontUtil.h"
#import "Util.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "Header.h"

@interface EfilingCheckNewUserViewController (){
    
    UITextField *activeTextField;
    CGRect originScrollViewFrame;
    CGSize contentsize;
    
    ENCheckNewUserService *enCheckNewUserService;
    
    int maxLength;
    
}

@end

@implementation EfilingCheckNewUserViewController

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
    
    self.navigationController.navigationBar.hidden = YES;
    Header *header = [Util loadViewWithNibName:@"Header"];
    header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    header.pImage.image = [UIImage imageNamed:@"icon_efiling.png"];
    header.pLabel.hidden = YES;
    header.pLeftButton.hidden = YES;
    [header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    header.pRightButton.hidden = YES;
    [self.pHeaderView addSubview:header];
    
    maxLength = [[Util retrieveValidateConfigFromKey:@"rd.length.nid"] integerValue]+4;
    [self setFontStyle];
    
    [self.scrollView setContentSize:CGSizeMake(0,self.contentView.frame.size.height)];
    
    self.txtIdCard.delegate = self;
    
}

-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    [self.tvDetail setText:[Util stringWithScreenName:@"Login" labelName:@"Detail"]];
    [self.btnLogin setTitle:[Util stringWithScreenName:@"Login" labelName:@"Title"] forState:UIControlStateNormal];
}

- (void) setFontStyle {
    
    [self.labelTitle1 setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [self.labelTitle2 setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.labelTitle3 setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.tvDetail setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.btnLogin.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
}

#pragma - Response delegate
- (void) responseENCheckNewUserService:(NSData *)data {
    
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        
        if ([[responseDataDic objectForKey:@"status"] isEqualToString:@"1"]) {
            
            //-- Old user
            EfilingValidatePasswordViewController *vc = [[EfilingValidatePasswordViewController alloc]initWithNibName:@"EfilingValidatePasswordViewController" bundle:nil];
            vc.pUserId = [responseDataDic objectForKey:@"userId"];
            vc.pIdCard = [TextFormatterUtil removeMinusSignFromString:self.txtIdCard.text];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            
            //-- New user
            EfilingRegisterSaveViewController *vc = [[EfilingRegisterSaveViewController alloc]initWithNibName:@"EfilingRegisterSaveViewController" bundle:nil];
            vc.pThaiNation = [responseDataDic objectForKey:@"thaiNation"];
            vc.pNid = [TextFormatterUtil removeMinusSignFromString:self.txtIdCard.text];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }  else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
    
}

- (IBAction)onLoginButtonClicked:(id)sender {
    
    if ([self validateField] == YES) {
        //-- Call Service
        enCheckNewUserService = [[ENCheckNewUserService alloc]init];
        enCheckNewUserService.delegate = self;
        [enCheckNewUserService requestENCheckNewUserServiceWithIdCard:[TextFormatterUtil removeMinusSignFromString:self.txtIdCard.text]];
    }
}

- (BOOL) validateField {
    if ([self.txtIdCard.text isEqualToString:@""]){
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"ID card can't be empty"];
        return NO;
    } else if (([self.txtIdCard.text length] < maxLength)){
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"ID card less than 13 charactor"];
        return NO;
    } else if([Util validateIsDuplicated13digits:self.txtIdCard.text]){
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@"Duplicated 13 digits"];
        return NO;
    } else {
        return YES;
    }
}

@end
