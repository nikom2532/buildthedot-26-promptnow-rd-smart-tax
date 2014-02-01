//
//  EfilngUserProfileViewController.m
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingUserProfileViewController.h"
#import "EfilingTemplateViewController.h"
#import "EfilingPersonalProfileViewController.h"

#import "Util.h"
#import "FontUtil.h"
#import "Header.h"

@interface EfilingUserProfileViewController ()

@end

@implementation EfilingUserProfileViewController {
    NSMutableArray *tempMenu;
    NSMutableArray *menuIcon;
    NSMutableArray *menuIconSelection;
    
    int currentIndex;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    currentIndex = -1;
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //-- Header
    self.header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.font = [FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold];
    self.header.pLabel.text = [Util stringWithScreenName:@"Profile" labelName:@"ProfileTitle"];
    [self.header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.header.pRightButton.hidden = YES;
    [self.pHeaderView addSubview:self.header];
    
    self.navigationController.navigationBar.hidden = YES;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    tempMenu = [[NSMutableArray alloc]initWithObjects:[Util stringWithScreenName:@"Profile" labelName:@"GeneralProfile"],[Util stringWithScreenName:@"Profile" labelName:@"TemplateTitle"], nil];
    
    menuIcon = [[NSMutableArray alloc]initWithObjects:@"icon_userprofile.png",@"icon_template.png", nil];
    menuIconSelection = [[NSMutableArray alloc]initWithObjects:@"icon_userprofile_selection.png",@"icon_template_selection.png", nil];
}

-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tempMenu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.textLabel.text = [tempMenu objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIView *bgColorView = [[UIView alloc] init];
    if (currentIndex==-1) {
        cell.imageView.image = [UIImage imageNamed:[menuIcon objectAtIndex:indexPath.row]];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
    } else {
        if (currentIndex==indexPath.row) {
            cell.imageView.image = [UIImage imageNamed:[menuIconSelection objectAtIndex:indexPath.row]];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_list_selection.png"]];
            cell.textLabel.textColor = [UIColor whiteColor];
        } else {
            cell.imageView.image = [UIImage imageNamed:[menuIcon objectAtIndex:indexPath.row]];
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }
    [bgColorView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_list_selection.png"]]];
    [cell setSelectedBackgroundView:bgColorView];
    
    //    UIImage *img;
    //    if (indexPath.row==1||indexPath.row==4) {
    //        img = [UIImage imageNamed:@"bg_list_section_separate.png"];
    //    } else {
    //        img = [UIImage imageNamed:@"bg_list_line.png.png"];
    //    }
    
    UIImage *img = [UIImage imageNamed:@"bg_list_line.png"];
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, img.size.width, img.size.height)];
    imv.image = img;
    [cell addSubview:imv];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentIndex = indexPath.row;
    [self.tableView reloadData];
    
    if (indexPath.row == 0) {
        EfilingPersonalProfileViewController *vc = [[EfilingPersonalProfileViewController alloc]initWithNibName:@"EfilingPersonalProfileViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        EfilingTemplateViewController *vc = [[EfilingTemplateViewController alloc]initWithNibName:@"EfilingTemplateViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
