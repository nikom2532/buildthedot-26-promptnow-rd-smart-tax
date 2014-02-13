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
#import "TextWithButtonModel.h"
#import "TextWithLabelModel.h"

#import "SettingAboutUsViewController.h"
#import "SettingSuggestionViewController.h"

@interface SettingMainViewController () {
    TextWithButtonModel *textWithButtonModel;
    TextWithLabelModel *textWithLabelModel;
    
    NSMutableArray *tempTitle;
    NSMutableArray *iconImage;
}

@end

@implementation SettingMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    tempTitle = [[NSMutableArray alloc]init];
    [self addTempTitle];
}

- (void) addTempTitle {
    [tempTitle removeAllObjects];
    [tempTitle addObject:[Util stringWithScreenName:@"Setting" labelName:@"ChangeLanguage"]];
    [tempTitle addObject:[Util stringWithScreenName:@"Setting" labelName:@"AboutUs"]];
    [tempTitle addObject:[Util stringWithScreenName:@"Setting" labelName:@"Suggestion"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //-- Header
    self.header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.font = [FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold];
    self.header.pLabel.text = [Util stringWithScreenName:@"Setting" labelName:@"SettingTitle"];
    [self.header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.header.pRightButton.hidden = YES;
    [self.pHeaderView addSubview:self.header];
    
//    iconImage = [[NSMutableArray alloc]initWithObjects:@"icon_suggestion_efiling.png",@"icon_suggestion_condition.png",@"icon_suggestion_agreement.png", nil];
}

-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tempTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row==0) {
        textWithButtonModel = [Util loadViewWithNibName:@"TextWithButtonModel"];
        [textWithButtonModel.pTitle setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
        if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
            [textWithButtonModel.pBtnLeft.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
            [textWithButtonModel.pBtnRight.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
        } else {
            [textWithButtonModel.pBtnLeft.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
            [textWithButtonModel.pBtnRight.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
        }

        textWithButtonModel.pTitle.text = [tempTitle objectAtIndex:indexPath.row];
        [textWithButtonModel.pBtnLeft setTitle:@"ภาษาไทย" forState:UIControlStateNormal];
        [textWithButtonModel.pBtnRight setTitle:@"English" forState:UIControlStateNormal];

        [textWithButtonModel.pBtnLeft addTarget:self action:@selector(onThaiButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [textWithButtonModel.pBtnRight addTarget:self action:@selector(onEnglishButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
//        textWithButtonModel.pImage = [iconImage objectAtIndex:indexPath.row];
        [cell addSubview:textWithButtonModel];
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        textWithLabelModel = [Util loadViewWithNibName:@"TextWithLabelModel"];
        [textWithLabelModel.pTitle setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
        textWithLabelModel.pDetail.hidden = YES;
        
        textWithLabelModel.pTitle.text = [tempTitle objectAtIndex:indexPath.row];
//        textWithLabelModel.pImage = [iconImage objectAtIndex:indexPath.row];
        [cell addSubview:textWithLabelModel];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        SettingAboutUsViewController *vc = [[SettingAboutUsViewController alloc]initWithNibName:@"SettingAboutUsViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row==2){
        SettingSuggestionViewController *vc = [[SettingSuggestionViewController alloc]initWithNibName:@"SettingSuggestionViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onThaiButtonClicked:(id)sender {
    [Util saveAppSettingWithKey:@"AppLanguage" text:@"T"];
    self.header.pLabel.text = [Util stringWithScreenName:@"Setting" labelName:@"SettingTitle"];
    [self addTempTitle];
    [self.tableView reloadData];
}

- (IBAction)onEnglishButtonClicked:(id)sender {
    [Util saveAppSettingWithKey:@"AppLanguage" text:@"E"];
    self.header.pLabel.text = [Util stringWithScreenName:@"Setting" labelName:@"SettingTitle"];
    [self addTempTitle];
    [self.tableView reloadData];
}

@end
