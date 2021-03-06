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
@interface EfilingSuggestionTextDetailViewController (){
    NSString *display_type;
    NSString *instructions_message;//explanation_message
    NSString *url;
}

@end

@implementation EfilingSuggestionTextDetailViewController
@synthesize enGetSuggestionDetail;

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
    
    if ([Util isInternetConnect]) {
        [self callSuggestionTitle];
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
    }
    
    //-- Header
    self.header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.font = [FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold];
    self.header.pLabel.text = [Util stringWithScreenName:@"Suggestion" labelName:@"SuggestionTitle"];
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
-(void)responseENGetSuggestionDetailService:(NSDictionary*)data{
    NSDictionary *dic = data;
    
   // if ([[dic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        display_type = [responseDataDic objectForKey:@"display_type"];
        instructions_message = [responseDataDic objectForKey:@"instructions_message"];//explanation_message
        url = [responseDataDic objectForKey:@"url"];
        
        self.textView.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
        self.textView.text = instructions_message;//explanation_message
    
  //  }

}


@end
