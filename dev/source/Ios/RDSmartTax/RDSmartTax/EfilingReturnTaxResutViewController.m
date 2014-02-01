//
//  EfilingReturnTaxResutViewController.m
//  RDSmartTax
//
//  Created by fone on 12/19/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingReturnTaxResutViewController.h"

#import "Util.h"
#import "EfilingReturnTaxResultCell.h"
#import "ShareUserDetail.h"
#import "JSONDictionaryExtensions.h"

@interface EfilingReturnTaxResutViewController () {
    NSMutableArray *formDetailListArray;
    
    NSMutableArray *seqArray;
    NSMutableArray *payDateArray;
    NSMutableArray *officeNameArray;
    NSMutableArray *formTypeArray;
 
    NSString *title1;
    NSString *title2;
    NSString *title3;
    NSString *title4;
    
    NSString *messageStr;
}

@end

@implementation EfilingReturnTaxResutViewController
@synthesize enCheckStatusService;
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
    
    self.navigationController.navigationBar.hidden = YES;
    
    //-- Header
    self.header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.font = [FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold];
    self.header.pLabel.text = [Util stringWithScreenName:@"CheckReturnTaxResult" labelName:@"CheckReturnTaxResultTitle"];
    [self.header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.header.pRightButton.hidden = YES;
    [self.pHeaderView addSubview:self.header];
    
    if ([Util isInternetConnect]) {
        
        enCheckStatusService = [[ENCheckStatusService alloc]init];
        enCheckStatusService.delegate = self;
        [enCheckStatusService requestENCheckStatusServiceWithNid:[ShareUserDetail retrieveDataWithStringKey:@"nid"]
                                                       authenKey:[ShareUserDetail retrieveDataWithStringKey:@"authenKey"]
                                                         version:[ShareUserDetail retrieveDataWithStringKey:@"version"]
                                                            name:[ShareUserDetail retrieveDataWithStringKey:@"name"]
                                                         surname:[ShareUserDetail retrieveDataWithStringKey:@"surname"]];
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
    }

    
}

-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) responseENCheckStatusService:(NSDictionary *)data {
    NSDictionary *dic = data;

    if ([[dic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        messageStr = [dic objectForKey:@"message"];
        self.etMessage.text = messageStr;
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseMessage"]];
    }
}

-(void)ENCheckStatusServiceConnectionDidStart:(ENCheckStatusService *)sender {

}

-(void)ENCheckStatusServiceConnectionDidMakeProgress:(ENCheckStatusService *)sender {

}

-(void)ENCheckStatusServiceConnectionDidFinish:(ENCheckStatusService *)sender {

}

-(void)ENCheckStatusServiceConnectionDidFail:(ENCheckStatusService *)sender {

}

-(void)ENCheckStatusServiceConnectionDidTimeout:(ENCheckStatusService *)sender {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma - Decorate Label
- (void) setLanguage {
    
    title1 = [Util stringWithScreenName:@"CheckReturnTaxResult" labelName:@"Seq"];
    title2 = [Util stringWithScreenName:@"CheckReturnTaxResult" labelName:@"PayDate"];
    title3 = [Util stringWithScreenName:@"CheckReturnTaxResult" labelName:@"OfficeName"];
    title4 = [Util stringWithScreenName:@"CheckReturnTaxResult" labelName:@"FormType"];
}

- (void) setFontStyle {
    
    [self.etMessage setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
//    self.etMessage.textColor = [ColorUtil colorLightGrey];
}

@end
