//
//  EfilngUserProfileViewController.m
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingUserProfileViewController.h"
#import "EfilingGeneralProfileViewController.h"
#import "EfilingTemplateViewController.h"

#import "Util.h"
#import "FontUtil.h"

@interface EfilingUserProfileViewController ()

@end

@implementation EfilingUserProfileViewController {
    NSMutableArray *tempMenu;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tempMenu = [[NSMutableArray alloc]initWithObjects:[Util stringWithScreenName:@"Profile" labelName:@"GeneralProfile"],[Util stringWithScreenName:@"Profile" labelName:@"TemplateTitle"], nil];
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
    
    cell.imageView.image = [UIImage imageNamed:@"wrong.png"];
    cell.textLabel.text = [tempMenu objectAtIndex:indexPath.row];
    cell.textLabel.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        EfilingGeneralProfileViewController *vc = [[EfilingGeneralProfileViewController alloc]initWithNibName:@"EfilingGeneralProfileViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        EfilingTemplateViewController *vc = [[EfilingTemplateViewController alloc]initWithNibName:@"EfilingTemplateViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
