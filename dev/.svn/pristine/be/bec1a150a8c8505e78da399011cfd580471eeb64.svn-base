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
@interface EflingTermAndConditionViewController ()
{
    
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
//    [self createHeader];
}
//- (void) createHeader
//{
//    Header *header = [Util loadViewWithNibName:@"Header"];
//    header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
//    header.pImage.image = [UIImage imageNamed:@"icon_efiling.png"];
//    header.pLabel.hidden = YES;
//    header.pLeftButton.hidden = YES;
//    header.pRightButton.hidden = YES;
//    [self.view addSubview:header];
//}

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
    TaxStep1ViewController *tax1 = [[TaxStep1ViewController alloc]initWithNibName:@"TaxStep1ViewController" bundle:nil];
    [self.navigationController pushViewController:tax1 animated:YES];
}
@end
