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

@interface EfilingPrintDetailViewController ()

@end

@implementation EfilingPrintDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pUrl = [self.pUrl stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceCharacterSet]];
    NSURL *url = [NSURL URLWithString:self.pUrl];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

@end
