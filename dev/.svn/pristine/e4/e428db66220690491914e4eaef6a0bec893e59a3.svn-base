//
//  EfilingSuggestionTextDetailViewController.m
//  RDSmartTax
//
//  Created by Noi on 12/30/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingSuggestionTextDetailViewController.h"
#import "FontUtil.h"
#import "Util.h"
#import "ShareUserDetail.h"
#import "JSONDictionaryExtensions.h"
#import "SVProgressHUD.h"

#import "ENGetSuggestionDetail.h"
@interface EfilingSuggestionTextDetailViewController ()

@end

@implementation EfilingSuggestionTextDetailViewController{
    ENGetSuggestionDetail *enGetSuggestionDetail;
    NSString *displayId;
    NSString *displayMessage;
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

- (void) callSuggestionTitle{
    [enGetSuggestionDetail requestENGetSuggestionDetailService:self.pId];
}
-(void)responseENGetSuggestionDetailService:(NSData*)data{
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"SUCCESS"]) {
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        displayId = [responseDataDic objectForKey:@"display_id"];
        displayMessage = [responseDataDic objectForKey:@"instructions_message"];
        
        self.textView.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
        self.textView.text = displayMessage;
    
    }else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }

}


@end
