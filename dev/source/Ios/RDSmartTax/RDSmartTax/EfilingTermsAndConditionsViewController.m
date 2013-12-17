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
#import "EfilingGeneralProfileViewController.h"
#import "FontUtil.h"

@interface EfilingTermsAndConditionsViewController () {
    ENSaveConditionFillingFirstService *enSaveConditionFillingFirstService;
    ENCheckLoginFirstService *enCheckLoginFirstService;
}

@end

@implementation EfilingTermsAndConditionsViewController

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

    [self setFont];
    self.navigationItem.hidesBackButton = YES;
    
    //-- Set term text
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
    
    enSaveConditionFillingFirstService = [[ENSaveConditionFillingFirstService alloc]init];
    enSaveConditionFillingFirstService.delegate = self;
    [enSaveConditionFillingFirstService requestENSaveConditionFillingFirstServiceWithNid:[ShareUserDetail retrieveDataWithStringKey:@"nid"]];
    
}

#pragma - delegate method
- (void) responseENSaveConditionFillingFirstService:(NSData *)data {
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        enCheckLoginFirstService = [[ENCheckLoginFirstService alloc]init];
        enCheckLoginFirstService.delegate = self;
        [enCheckLoginFirstService requestENCheckLoginFirstServiceWithNid:[ShareUserDetail retrieveDataWithStringKey:@"nid"]];
        
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
}

#pragma - delegate method
- (void) responseENCheckLoginFirstService:(NSData *)data {
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        if ([[responseDataDic objectForKey:@"status"] isEqualToString:@"0"]) {
            EfilingHomeViewController *vc = [[EfilingHomeViewController alloc]initWithNibName:@"EfilingHomeViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            EfilingGeneralProfileViewController *vc = [[EfilingGeneralProfileViewController alloc]initWithNibName:@"EfilingGeneralProfileViewController" bundle:nil];
            vc.pFirstLogin = @"1";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
    
}

#pragma - Decorate Label
- (void) setLanguage {
    [self.labelTitle setText:[Util stringWithScreenName:@"TermsAndConditions" labelName:@"Title"]];
    [self.btnAccept setTitle:[Util stringWithScreenName:@"Common" labelName:@"Accept"] forState:UIControlStateNormal];
    [self.btnCancel setTitle:[Util stringWithScreenName:@"Common" labelName:@"Decline"] forState:UIControlStateNormal];
}
- (void) setFont {
    self.labelTitle.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    [self.btnAccept.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.btnCancel.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
}


@end
