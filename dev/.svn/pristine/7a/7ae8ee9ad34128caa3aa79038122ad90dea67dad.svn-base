//
//  SettingMainViewController.m
//  RDSmartTax
//
//  Created by fone on 12/19/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "SettingMainViewController.h"
#import "Util.h"
#import "FontUtil.h"
#import "Header.h"

@interface SettingMainViewController ()

@end

@implementation SettingMainViewController

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
    
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        [self thaiDecor];
    } else {
        [self engDecor];
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setFontStyle];
    self.navigationController.navigationBar.hidden = YES;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onThaiButtonClicked:(id)sender {
    [Util saveAppSettingWithKey:@"AppLanguage" text:@"T"];
    [self thaiDecor];
}

- (IBAction)onEnglishButtonClicked:(id)sender {
    [Util saveAppSettingWithKey:@"AppLanguage" text:@"E"];
    [self engDecor];
}

#pragma - Decorate Label
- (void) setLanguage {
    
}

- (void) setFontStyle {
    [self.lblLanguage setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
}

- (void) thaiDecor {
    [self.lblLanguage setText:[Util stringWithScreenName:@"Setting" labelName:@"ChangeLanguage"]];
    
    [self.btnEnglish.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.btnThai.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
}
- (void) engDecor {
    [self.lblLanguage setText:[Util stringWithScreenName:@"Setting" labelName:@"ChangeLanguage"]];
    
    [self.btnEnglish.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [self.btnThai.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
}

@end
