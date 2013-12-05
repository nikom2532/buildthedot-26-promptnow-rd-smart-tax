//
//  EfilingCheckNewUserViewController.m
//  RDSmartTax
//
//  Created by fone on 12/4/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingCheckNewUserViewController.h"
#import "EfilingRegisterViewController.h"
#import "EfilingValidatePasswordViewController.h"

#import "FontUtil.h"
#import "Util.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"

#define IDCARD_MAX_LENGHT 17

@interface EfilingCheckNewUserViewController (){
    
    UITextField *activeTextField;
    CGRect originScrollViewFrame;
    CGSize contentsize;
    
    ENCheckNewUserService *enCheckNewUserService;
    
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
    
    [self.btnLogin setEnabled:NO];
    [self.btnLogin setBackgroundImage:[UIImage imageNamed:@"wrong.png"] forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setFontStyle];
    
    [self.scrollView setContentSize:CGSizeMake(0,self.contentView.frame.size.height)];
    
    self.txtIdCard.delegate = self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location == IDCARD_MAX_LENGHT) {
        return NO;
    }
    
    if ([string length] == 0) {
        
        [self.btnLogin setEnabled:NO];
        [self.btnLogin setBackgroundImage:[UIImage imageNamed:@"wrong.png"] forState:UIControlStateNormal];
        
        return YES;
    }
    
    if ((range.location == 1) || (range.location == 6) || (range.location == 12 || (range.location == 15)))
    {
        NSString *str    = [NSString stringWithFormat:@"%@-",textField.text];
        textField.text   = str;
        if (range.location == 15) {
            
            [self.btnLogin setEnabled:YES];
            [self.btnLogin setBackgroundImage:[UIImage imageNamed:@"correct.png"] forState:UIControlStateNormal];
        }
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
    [self.labelTitle setText:[Util stringWithLabelName:@"Login"]];
    [self.labelIdCard setText:[Util stringWithLabelName:@"LoginIdCard"]];
    [self.btnLogin setTitle:[Util stringWithLabelName:@"Login"] forState:UIControlStateNormal];
}

- (void) setFontStyle {
    
    [self.labelTitle setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [self.labelIdCard setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.txtIdCard setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.btnLogin.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
}

- (IBAction)onLoginButtonClicked:(id)sender {
    NSString *idCard = [TextFormatterUtil removeMinusSignFromString:self.txtIdCard.text];
    
     //-- Call Service
     enCheckNewUserService = [[ENCheckNewUserService alloc]init];
     enCheckNewUserService.delegate = self;
     [enCheckNewUserService requestENCheckNewUserServiceWithIdCard:idCard];

}

#pragma - Response delegate
- (void) responseENCheckNewUserService:(NSData *)data {
    
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    NSLog(@"response : %@", dic);
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        
        if ([[responseDataDic objectForKey:@"status"] isEqualToString:@"1"]) {
            
            EfilingValidatePasswordViewController *vc = [[EfilingValidatePasswordViewController alloc]initWithNibName:@"EfilingValidatePasswordViewController" bundle:nil];
            vc.pUserId = [responseDataDic objectForKey:@"userId"];
            vc.pIdCard = [TextFormatterUtil removeMinusSignFromString:self.txtIdCard.text];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            
            EfilingRegisterViewController *vc = [[EfilingRegisterViewController alloc]initWithNibName:@"EfilingRegisterViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }  else {
        [Util alertUtilWithTitle:[Util stringWithLabelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
    
}

@end
