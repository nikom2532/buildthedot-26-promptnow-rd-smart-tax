//
//  EfilingPrintDetailViewController.m
//  RDSmartTax
//
//  Created by fone on 12/16/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingPrintDetailViewController.h"
#import "SVProgressHUD.h"
#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "MBProgressHUD.h"
#import "Header.h"

@interface EfilingPrintDetailViewController () {
    
    MBProgressHUD *hud;
    UITextField *tf_email;
    
    UIAlertView *myAlertView;
    
}

@end

@implementation EfilingPrintDetailViewController
@synthesize enSendEmailService;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setLanguage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    enSendEmailService = [[ENSendEmailService alloc]init];
    enSendEmailService.delegate = self;
    
    self.navigationController.navigationBar.hidden = YES;
    
    //-- Header
    self.header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.font = [FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold];
    self.header.pLabel.text = [Util stringWithScreenName:@"Print" labelName:@"PrintTitle"];
    [self.header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.header.pRightButton.hidden = YES;
    [self.pHeaderView addSubview:self.header];
    
    [self setFontStyle];
    
    self.pUrl = [self.pUrl stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceCharacterSet]];
    NSURL *url = [NSURL URLWithString:self.pUrl];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    
}

-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    //    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    [self showHUD];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    [SVProgressHUD dismiss];
    [self closeHUD];
}

#pragma - Decorate Label
- (void) setLanguage {
    [self.btnEmail setTitle:[Util stringWithScreenName:@"Print" labelName:@"sendEmail"] forState:UIControlStateNormal];
    [self.btnSave setTitle:[Util stringWithScreenName:@"Print" labelName:@"savePdf"] forState:UIControlStateNormal];
}

- (void) setFontStyle {
    [self.btnEmail.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.btnSave.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
}

- (IBAction)onSaveButtonClicked:(id)sender {
    [self showHUD];
    [self performSelectorInBackground:@selector(callSavePDF) withObject:nil];
}

- (void) callSavePDF {
    NSString *fileNamePrefix;
    if ([self.pFormType isEqualToString:@"F"]) {
        fileNamePrefix = @"pnd91";
    } else {
        fileNamePrefix = @"receipt";
    }
    NSString *fileName = [NSString stringWithFormat:@"%@%@%@%@%@",fileNamePrefix,@"_",self.pNid,@"_",self.pRefNo];
    
    
    if ([Util savePDFToDocumentWithURL:[self.pUrl stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceCharacterSet]] fileName:fileName]) {
        [self closeHUD];
        [Util alertUtilWithTitle:@"" msg:[Util stringWithScreenName:@"Common" labelName:@"SaveSuccess"]];
    } else {
        [self closeHUD];
        [Util alertUtilWithTitle:@"" msg:[Util stringWithScreenName:@"Common" labelName:@"SaveDuplicate"]];
    }
    
}

- (IBAction)onEmailButtonClicked:(id)sender {
    
    [self showHUD];
    [self showAlertPopupWithTextfield];
    
    
}

-(void)callEmailClass {
    Class emailClass=(NSClassFromString(@"MFMailComposeViewController"));
    if (emailClass!=nil)
    {
        if ([emailClass canSendMail])
            [self displayComposePage];
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Email cannot be send!"
                                                         message:@"Device is not configured to send email"
                                                        delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Email cannot be send!"
                                                     message:@"Device cannot send email"
                                                    delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

-(void)displayComposePage{
    //    [SVProgressHUD dismiss];
    [self closeHUD];
    
    MFMailComposeViewController *composePage=[[MFMailComposeViewController alloc]init];
    composePage.mailComposeDelegate=self;
    
    //    NSArray *recipients=[NSArray arrayWithObject:@""];
    //    [composePage setToRecipients:recipients];
    
    NSString *title;
    NSString *fileNamePrefix;
    NSString *yearTax = [Util stringWithScreenName:@"Print" labelName:@"YearTax"];
    if ([self.pFormType isEqualToString:@"F"]) {
        title = [Util stringWithScreenName:@"Print" labelName:@"FormEmailTitle"];
        fileNamePrefix = @"pnd91";
    } else {
        title = [Util stringWithScreenName:@"Print" labelName:@"ReceiptEmailTitle"];
        fileNamePrefix = @"receipt";
    }
    NSString *emailSubject = [NSString stringWithFormat:@"%@ %@ %@",title,yearTax,self.pYear];
    NSString *fileName = [NSString stringWithFormat:@"%@%@%@%@%@",fileNamePrefix,@"_",self.pNid,@"_",self.pRefNo];
    
    [composePage setSubject:emailSubject];
    [composePage setMessageBody:@"" isHTML:NO];
    [composePage setTitle:@"Email"];
    NSURL *url = [NSURL URLWithString:[self.pUrl stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceCharacterSet]]];
    NSData *pdfData = [NSData dataWithContentsOfURL:url];
    
    [composePage addAttachmentData:pdfData mimeType:@"application/pdf" fileName:fileName];
    
    //-- file name : [Util retrievePdfFileNameWithURL:[self.pUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]
    
    composePage.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:composePage animated:YES completion:nil];
    
}

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - MBProgressHUD
//--Adding By Saritwat
-(void)showHUD
{
    hud.labelText = [Util stringWithScreenName:@"Common" labelName:@"Loading"];
    [self.view addSubview:hud];
    [hud show:YES];
    
}
-(void)closeHUD
{
    [hud show:NO];
    [hud removeFromSuperview];
    
}

#pragma mark - alert email
- (void) showAlertPopupWithTextfield
{
    myAlertView = [[UIAlertView alloc] initWithTitle:[Util stringWithScreenName:@"Util" labelName:@"EmailDesc"] message:nil delegate:self cancelButtonTitle:[Util stringWithScreenName:@"Common" labelName:@"Cancel"] otherButtonTitles:[Util stringWithScreenName:@"Common" labelName:@"Send"], nil];
    [myAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    myAlertView.tag = 1234;
    [myAlertView textFieldAtIndex:0].text = [ShareUserDetail retrieveDataWithStringKey:@"email"];
    [[myAlertView textFieldAtIndex:0] setDelegate:self];
    [myAlertView show];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [myAlertView dismissWithClickedButtonIndex:myAlertView.firstOtherButtonIndex animated:YES];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex]) {
        if ([Util isInternetConnect]) {
            [enSendEmailService requestENSendEmailService:[myAlertView textFieldAtIndex:0].text pdfLink:self.pUrl];
            
        } else {
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
        }
    } else {

    }
}

- (void) responseENSendEmailService:(NSDictionary *)data {
    NSDictionary *dic = data;
    
    if ([[dic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        [Util alertUtilWithTitle:@"" msg:[Util loadErrorMessageWithValidateField:@"sendEmaiSuccess"]];
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseMessage"]];
    }
}

@end
