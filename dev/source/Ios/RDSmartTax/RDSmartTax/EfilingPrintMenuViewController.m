//
//  EfilingPrintMenuViewController.m
//  RDSmartTax
//
//  Created by fone on 12/15/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingPrintMenuViewController.h"
#import "EfilingPrintViewController.h"
#import "Util.h"
#import "FontUtil.h"

@interface EfilingPrintMenuViewController ()

@end

@implementation EfilingPrintMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [self setFontStyle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonPrintFormClicked:(id)sender {
    EfilingPrintViewController *vc = [[EfilingPrintViewController alloc]initWithNibName:@"EfilingPrintViewController" bundle:nil];
    vc.pIsReceipt = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onButtonPrintReceiptClicked:(id)sender {
    EfilingPrintViewController *vc = [[EfilingPrintViewController alloc]initWithNibName:@"EfilingPrintViewController" bundle:nil];
    vc.pIsReceipt = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma - Decorate Label
- (void) setLanguage {
    [self.btnForm setTitle:[Util stringWithScreenName:@"Print" labelName:@"Form"] forState:UIControlStateNormal];
    [self.btnReceipt setTitle:[Util stringWithScreenName:@"Print" labelName:@"Receipt"] forState:UIControlStateNormal];
}

- (void) setFontStyle {
    [self.btnForm.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.btnReceipt.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
}

@end
