//
//  EfilingTermsAndConditionsViewController.m
//  RDSmartTax
//
//  Created by fone on 12/11/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingTermsAndConditionsViewController.h"
#import "ShareUserDetail.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "EfilingHomeViewController.h"
#import "FontUtil.h"
#import "EfilingPersonalProfileViewController.h"
#import "Header.h"

@interface EfilingTermsAndConditionsViewController () {

}

@end

@implementation EfilingTermsAndConditionsViewController
@synthesize enSaveConditionFillingFirstService;

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

    //-- Header
    self.header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.font = [FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold];
    self.header.pLabel.text = [Util stringWithScreenName:@"TermsAndConditions" labelName:@"Title"];
    self.header.pLeftButton.hidden = YES;
    self.header.pRightButton.hidden = YES;
    [self.pHeaderView addSubview:self.header];
    
    [self setFont];

    self.navigationController.navigationBar.hidden = YES;
    
    //-- Set term text
    self.tfTermAndConDetail.text = [ShareUserDetail retrieveDataWithStringKey:@"termsConditionDetail"];
}

-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setLanguage];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCancelButtonClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onAcceptButtonClicked:(id)sender {
    if ([Util isInternetConnect]) {
        
        enSaveConditionFillingFirstService = [[ENSaveConditionFillingFirstService alloc]init];
        enSaveConditionFillingFirstService.delegate = self;
        
        [enSaveConditionFillingFirstService requestENSaveConditionFillingFirstServiceWithNid:self.pNid];
        
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
    }
    
}

#pragma - delegate method
- (void) responseENSaveConditionFillingFirstService:(NSDictionary *)data {
    NSDictionary *dic = data;
    
    if ([[dic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
            EfilingHomeViewController *vc = [[EfilingHomeViewController alloc]initWithNibName:@"EfilingHomeViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseMessage"]];
    }
}

#pragma - Decorate Label
- (void) setLanguage {
    [self.btnAccept setTitle:[Util stringWithScreenName:@"Common" labelName:@"Accept"] forState:UIControlStateNormal];
    [self.btnCancel setTitle:[Util stringWithScreenName:@"Common" labelName:@"Cancel"] forState:UIControlStateNormal];
}
- (void) setFont {
    [self.btnAccept.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [self.btnCancel.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
}


@end
