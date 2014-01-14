//
//  EflingTermAndConditionViewController.m
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 12/30/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EflingTermAndConditionViewController.h"
#import "TaxStep1ViewController.h"
#import "FontUtil.h"

#import "TaxStep5ViewController.h"
#import "EfilingTaxPaymentViewController.h"
@interface EflingTermAndConditionViewController ()
{
    TaxStep1ViewController *tax1;
}
@end

@implementation EflingTermAndConditionViewController
@synthesize typeOfTax;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithTypeOfPnd:(NSString*)pnd91;
{
    self = [super initWithNibName:@"EflingTermAndConditionViewController" bundle:nil];
    if (self) {
        // Custom initialization
        typeOfTax = pnd91;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [scrollView addSubview:detailView];
    
    if ([typeOfTax isEqualToString:@"pnd"]) {
        [pnd91Button setTitle:@"ภ.ง.ด. 91" forState:UIControlStateNormal];
    }
    else if ([typeOfTax isEqualToString:@"pnd+"]) {
        [pnd91Button setTitle:@"ภ.ง.ด. 91 (ยื่นเพิ่มเติม)" forState:UIControlStateNormal];
    }

    [self setFontStyle];
    [self createHeaderInview];
}
- (void) createHeaderInview
{
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.text = @"ยื่นภาษี";
    [self.header.pLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];

}

- (void) setFontStyle {
    
    [headerLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    
    [detailLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [pnd91Button.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pnd91Clicked:(id)sender {
//    if (!tax1) {
//        tax1 = [[TaxStep1ViewController alloc]initWithNibName:@"TaxStep1ViewController" bundle:nil];
//    }
    TaxStep1ViewController *tax1VC = [[TaxStep1ViewController alloc]initWithNibName:@"TaxStep1ViewController" bundle:nil];

    [self.navigationController pushViewController:tax1VC animated:YES];
    
//    TaxStep5ViewController *tax1VC = [[TaxStep5ViewController alloc]initWithNibName:@"TaxStep5ViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:tax1VC animated:YES];
    
//    EfilingTaxPaymentViewController *tax1VC = [[EfilingTaxPaymentViewController alloc]initWithNibName:@"EfilingTaxPaymentViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:tax1VC animated:YES];

}
@end
