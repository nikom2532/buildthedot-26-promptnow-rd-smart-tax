//
//  EfilingPrintViewController.m
//  RDSmartTax
//
//  Created by fone on 12/15/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingPrintViewController.h"
#import "FontUtil.h"
#import "Util.h"
#import "EfilingPrintCell.h"
#import "ShareUserDetail.h"
#import "JSONDictionaryExtensions.h"
#import "EfilingPrintDetailViewController.h"
#import "SVProgressHUD.h"

@interface EfilingPrintViewController () {
    ENPrintFormReceiptService *enPrintFormReceiptService;
    NSString *currentYearStr;
    NSString *lastYearStr;
    
    NSString *detectFormType;
    
    NSString *nidStr;
    NSString *formCodeStr;
    NSString *formTypeStr;
    NSString *taxYearStr;
    
    NSMutableArray *receiptNoArray;
    NSMutableArray *refNoArray;
    NSMutableArray *payDateArray;
    NSMutableArray *taxMonthArray;
    NSMutableArray *taxAmountArray;
    NSMutableArray *printURLArray;
    
    
    NSString *title1;
    NSString *title2;
    NSString *title3;
    
}

@end

@implementation EfilingPrintViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [SVProgressHUD dismiss];
    [self setLanguage];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setFontStyle];
    
    if (self.pIsReceipt) {
        detectFormType = @"R";
        
        title1 = [Util stringWithScreenName:@"Print" labelName:@"ReceiptRefNo"];
        title2 = [Util stringWithScreenName:@"Print" labelName:@"ReceiptPayDate"];
        title3 = [Util stringWithScreenName:@"Print" labelName:@"ReceiptTaxAmount"];
    } else {
        detectFormType = @"F";
        
        title1 = [Util stringWithScreenName:@"Print" labelName:@"FormRefNo"];
        title2 = [Util stringWithScreenName:@"Print" labelName:@"FormPayDate"];
        title3 = [Util stringWithScreenName:@"Print" labelName:@"FormTaxAmount"];
    }
    enPrintFormReceiptService = [[ENPrintFormReceiptService alloc]init];
    enPrintFormReceiptService.delegate = self;
    [self callServiceWithFormType:detectFormType taxYear:currentYearStr];
    
}

- (void) callServiceWithFormType : (NSString *) formType
                         taxYear : (NSString *) taxYear {
    [enPrintFormReceiptService requestENPrintFormReceiptServiceWithNid:[ShareUserDetail retrieveDataWithStringKey:@"nid"]
                                                               version:[ShareUserDetail retrieveDataWithStringKey:@"version"]
                                                             authenKey:[ShareUserDetail retrieveDataWithStringKey:@"authenKey"]
                                                              formCode:@"PND91"
                                                              formType:formType
                                                               taxYear:taxYear];
}

- (void) responseENPrintFormReceiptService:(NSData *)data {
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];

    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        NSDictionary *formDataDic = [responseDataDic objectForKey:@"formData"];
        
        nidStr = [responseDataDic objectForKey:@"nid"];
        formCodeStr = [responseDataDic objectForKey:@"formCode"];
        formTypeStr = [responseDataDic objectForKey:@"formType"];
        taxYearStr = [responseDataDic objectForKey:@"taxYear"];
        
        receiptNoArray = [[NSMutableArray alloc]init];
        refNoArray = [[NSMutableArray alloc]init];
        payDateArray = [[NSMutableArray alloc]init];
        taxMonthArray = [[NSMutableArray alloc]init];
        taxAmountArray = [[NSMutableArray alloc]init];
        printURLArray = [[NSMutableArray alloc]init];
        
        NSEnumerator *enumerator = [formDataDic objectEnumerator];
        id object;
        while (object = [enumerator nextObject]) {
            [receiptNoArray addObject:[object objectForKey:@"receiptNo"]];
            [refNoArray addObject:[object objectForKey:@"refNo"]];
            [payDateArray addObject:[object objectForKey:@"payDate"]];
            [taxMonthArray addObject:[object objectForKey:@"taxMonth"]];
            [taxAmountArray addObject:[object objectForKey:@"taxAmount"]];
            [printURLArray addObject:[object objectForKey:@"printURL"]];
        }
        [self.tableView reloadData];
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - Decorate Label
- (void) setLanguage {

    NSDate *date = [NSDate date];
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@"yyyy"];
    
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        [yearFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
    } else {
        [yearFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    }
    currentYearStr = [yearFormatter stringFromDate:date];
    int lastYear = [currentYearStr intValue]-1;
    lastYearStr = [NSString stringWithFormat:@"%d", lastYear];
    
    [self.segmentControl setTitle:currentYearStr forSegmentAtIndex:0];
    [self.segmentControl setTitle:lastYearStr forSegmentAtIndex:1];
}

- (void) setFontStyle {
    
    UIFont *font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [self.segmentControl setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
}

- (IBAction)segmentedControlIndexChanged:(id)sender {
    
    switch (self.segmentControl.selectedSegmentIndex)
    {
        case 0:
            [self callServiceWithFormType:detectFormType taxYear:currentYearStr];
            break;
        case 1:
            [self callServiceWithFormType:detectFormType taxYear:lastYearStr];
            break;
        default:
            break;
    }
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [receiptNoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    EfilingPrintCell *cell = (EfilingPrintCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EfilingPrintCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.pTitle1.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pTitle2.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pTitle3.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pDetail1.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pDetail2.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pDetail3.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    
    cell.pTitle1.text = title1;
    cell.pTitle2.text = title2;
    cell.pTitle3.text = title3;
    
    cell.pDetail1.text = [refNoArray objectAtIndex:indexPath.row];
    cell.pDetail2.text = [payDateArray objectAtIndex:indexPath.row];
    cell.pDetail3.text = [taxAmountArray objectAtIndex:indexPath.row];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EfilingPrintDetailViewController *vc = [[EfilingPrintDetailViewController alloc]initWithNibName:@"EfilingPrintDetailViewController" bundle:nil];
    vc.pUrl = [printURLArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end