//
//  EfilingSendEmailViewController.m
//  RDSmartTax
//
//  Created by Noi on 12/18/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingSendEmailViewController.h"
#import "ENResetPasswordConfirmService.h"
#import "EfilingValidatePasswordViewController.h"
#import "EfilingCheckNewUserViewController.h"
#import "TextFieldModel.h"

#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"
@interface EfilingSendEmailViewController (){
    NSArray *confirmEmailArray;
    NSString *nid;
    NSString *email;
    NSString *response;
    
    TextFieldModel *textFieldModel;

}

@end

@implementation EfilingSendEmailViewController
@synthesize enResetPasswordConfirmService;

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
    email = [TextFormatterUtil formatEmailMask:@"somsak@hotmail.com"];//self.pEmail
    self.txtEmail.text = email;
    
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
#pragma - Decorate Label
- (void) setLanguage {
    [self.labelTxtSendEmail1 setText:[Util stringWithScreenName:@"Common" labelName:@"ConFirmRequestPasswordText1"]];
    [self.labelTxtSendEmail2 setText:[Util stringWithScreenName:@"Common" labelName:@"ConFirmRequestPasswordText2"]];
    [self.btnConfirmRequestPassword setTitle:[Util stringWithScreenName:@"Common" labelName:@"ConFirmRequestPassword"] forState:UIControlStateNormal];
}

- (void) setFontStyle {
    
    [self.labelTxtSendEmail1 setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
    [self.labelTxtSendEmail2 setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
    [self.btnConfirmRequestPassword.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onConfirmButtonClicked:(id)sender {

    if ([Util isInternetConnect]) {
        [self callResetPasswordConfirmService];
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
    }

}
#pragma - call service
- (void) callResetPasswordConfirmService{
    enResetPasswordConfirmService = [[ENResetPasswordConfirmService alloc]init];
    enResetPasswordConfirmService.delegate = self;
    
    NSLog(@"\n call enResetPasswordConfirmService");
    [enResetPasswordConfirmService requestENResetPasswordConfirmService:nid
                                                                  email:self.pEmail];
    
}
-(void)responseENResetPasswordConfirmService:(NSDictionary*)data{
    NSDictionary *dic = data;
    NSLog(@"response : %@", dic);
    //NSString *result = @"Error";
    //[dic objectForKey:@"responseStatus"]
    if([[dic objectForKey:@"responseCode"]isEqualToString:@"0"]){
        if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"SUCCESS"]) {
            response = @"success";
            [self alertResultWithTitle:@"" detail:[Util stringWithScreenName:@"Common" labelName:@"Success"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"]];
        }
        if([[dic objectForKey:@"responseStatus"] isEqualToString:@"ERROR"]) {
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
                    if([obj isKindOfClass:[EfilingValidatePasswordViewController class]]){
                        [[self navigationController] popToViewController:obj animated:YES];
                        return;
                    }
                }
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
