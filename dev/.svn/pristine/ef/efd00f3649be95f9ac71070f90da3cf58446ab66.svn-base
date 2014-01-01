//
//  EfilingSuggestionWebViewDetailViewController.m
//  RDSmartTax
//
//  Created by Noi on 12/30/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingSuggestionWebViewDetailViewController.h"
#import "FontUtil.h"
#import "Util.h"
#import "ShareUserDetail.h"
#import "JSONDictionaryExtensions.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
#import "ENGetSuggestionDetail.h"

@interface EfilingSuggestionWebViewDetailViewController ()

@end

@implementation EfilingSuggestionWebViewDetailViewController{
    ENGetSuggestionDetail *enGetSuggestionDetail;
    MBProgressHUD *hud;
    NSString *displayId;
    NSString *displayMessage;
    NSString *strUrl;
}

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
    enGetSuggestionDetail = [[ENGetSuggestionDetail alloc]init];
    enGetSuggestionDetail.delegate = self;
    
    [self callSuggestionTitle];
    
    //-- Header
    self.header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    self.header.pImage.image = [UIImage imageNamed:@"icon_efiling.png"];
    self.header.pLabel.hidden = YES;
    [self.header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.header.pRightButton.hidden = YES;
    [self.pHeaderView addSubview:self.header];
}

-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    //    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    [self showHUD];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    [SVProgressHUD dismiss];
    [self closeHUD];
}
- (void) callSuggestionTitle{
    [enGetSuggestionDetail requestENGetSuggestionDetailService:self.pId];
}
-(void)responseENGetSuggestionDetailService:(NSData*)data{
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"SUCCESS"]) {
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
            strUrl = [responseDataDic objectForKey:@"url"];
            strUrl = [strUrl stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceCharacterSet]];
            strUrl = @"https://www.google.co.th/";
            NSURL *url = [NSURL URLWithString:strUrl];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        
    }else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - MBProgressHUD
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

@end
