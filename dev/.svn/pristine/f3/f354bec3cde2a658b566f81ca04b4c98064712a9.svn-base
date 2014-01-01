//
//  EfilingReturnTaxResutViewController.m
//  RDSmartTax
//
//  Created by fone on 12/19/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingReturnTaxResutViewController.h"

#import "Util.h"
#import "FontUtil.h"
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
    self.header.pImage.image = [UIImage imageNamed:@"icon_efiling.png"];
    self.header.pLabel.hidden = YES;
    [self.header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.header.pRightButton.hidden = YES;
    [self.pHeaderView addSubview:self.header];
    
    ENCheckStatusService *enCheckStatusService = [[ENCheckStatusService alloc]init];
    enCheckStatusService.delegate = self;
    [enCheckStatusService requestENCheckStatusServiceWithNid:[ShareUserDetail retrieveDataWithStringKey:@"nid"]
                                                   authenKey:[ShareUserDetail retrieveDataWithStringKey:@"authenKey"]
                                                     version:[ShareUserDetail retrieveDataWithStringKey:@"version"]
                                                        name:[ShareUserDetail retrieveDataWithStringKey:@"name"]
                                                     surname:[ShareUserDetail retrieveDataWithStringKey:@"surname"]];
    
}

-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) responseENCheckStatusService:(NSData *)data {
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        //NSDictionary *formDataDic = [dic objectForKey:@"formDetailList"];
        
        messageStr = [dic objectForKey:@"message"];
        self.etMessage.text = messageStr;
        
        /*
        payDateArray = [[NSMutableArray alloc]init];
        officeNameArray = [[NSMutableArray alloc]init];
        formTypeArray = [[NSMutableArray alloc]init];
        seqArray = [[NSMutableArray alloc]init];
        
        NSEnumerator *enumerator = [formDataDic objectEnumerator];
        id object;
        while (object = [enumerator nextObject]) {
            [payDateArray addObject:[object objectForKey:@"payDate"]];
            [officeNameArray addObject:[object objectForKey:@"officeName"]];
            [formTypeArray addObject:[object objectForKey:@"formType"]];
            [seqArray addObject:[object objectForKey:@"seq"]];
        }
        [self.tableView reloadData];
         */
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
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
}
/*
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [seqArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    EfilingReturnTaxResultCell *cell = (EfilingReturnTaxResultCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EfilingReturnTaxResultCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.pLbNumber.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pLbNumberDetail.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pLbDate.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pLbDateDetail.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pLbLocation.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pLbLocationDetail.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pLbType.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pLbTypeDetail.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    
    cell.pLbNumber.text = title1;
    cell.pLbDate.text = title2;
    cell.pLbLocation.text = title3;
    cell.pLbType.text = title4;
    
    cell.pLbNumberDetail.text = [seqArray objectAtIndex:indexPath.row];
    cell.pLbDateDetail.text = [payDateArray objectAtIndex:indexPath.row];
    cell.pLbLocationDetail.text = [officeNameArray objectAtIndex:indexPath.row];
    cell.pLbTypeDetail.text = [formTypeArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    EfilingPrintDetailViewController *vc = [[EfilingPrintDetailViewController alloc]initWithNibName:@"EfilingPrintDetailViewController" bundle:nil];
//    vc.pUrl = [printURLArray objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
}
 
 */

@end
