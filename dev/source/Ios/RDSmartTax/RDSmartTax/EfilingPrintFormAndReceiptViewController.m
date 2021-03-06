//
//  EfilingPrintFormAndReceiptViewController.m
//  RDSmartTax
//
//  Created by fone on 12/26/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingPrintFormAndReceiptViewController.h"
#import "FontUtil.h"
#import "Util.h"
#import "EfilingPrintCell.h"
#import "ShareUserDetail.h"
#import "JSONDictionaryExtensions.h"
#import "EfilingPrintDetailViewController.h"
#import "SVProgressHUD.h"
#import "Header.h"
#import "TextFormatterUtil.h"
#import "SlidePageFlow.h"

@interface EfilingPrintFormAndReceiptViewController () {

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
    
    NSString *year;
    int currentIndex;
    
    SlidePageFlow *slidePageFlow;
    NSMutableArray *yearArray;
    NSMutableArray *identify;
}

@end

#define COLOR(x) x/255.0f

@implementation EfilingPrintFormAndReceiptViewController
@synthesize enPrintFormReceiptService;

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
    
    currentIndex = -1;
    [self.tableView reloadData];
}

//-- Type
- (void) typeFormActive {
    [self.btnForm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.btnReceipt setTitleColor:[UIColor colorWithRed:COLOR(139.0) green:COLOR(197.0) blue:COLOR(63.0) alpha:1] forState:UIControlStateNormal];
    [self.btnReceipt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.btnForm setBackgroundImage:[UIImage imageNamed:@"btn_switch_left_active.png"] forState:UIControlStateNormal];
    [self.btnReceipt setBackgroundImage:[UIImage imageNamed:@"btn_switch_right_inActive.png"] forState:UIControlStateNormal];
}

- (void) typeFormInActive {
    [self.btnForm setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.btnReceipt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnForm setBackgroundImage:[UIImage imageNamed:@"btn_switch_left_inActive.png"] forState:UIControlStateNormal];
    [self.btnReceipt setBackgroundImage:[UIImage imageNamed:@"btn_switch_right_active.png"] forState:UIControlStateNormal];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    identify = [[NSMutableArray alloc]initWithObjects:@"lastYear",@"currentYear", nil];
    self.hPageControl.hidden = YES;
    
    //-- page flow
    self.hFlowView.delegate = self;
    self.hFlowView.dataSource = self;
    self.hFlowView.pageControl = self.hPageControl;
    self.hFlowView.minimumPageAlpha = 0.3;
    self.hFlowView.minimumPageScale = 0.9;

    self.navigationController.navigationBar.hidden = YES;
    
    //-- set active
    [self typeFormActive];
    
    //-- Header
    self.header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.font = [FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold];
    self.header.pLabel.text = [Util stringWithScreenName:@"Print" labelName:@"PrintTitle"];
    [self.header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.header.pRightButton.hidden = YES;
    [self.pHeaderView addSubview:self.header];
    
    [self setYear];
    [self setFontStyle];
    
    self.pIsReceipt = NO;
    [self checkStatus];
    
    //-- set year
    yearArray = [[NSMutableArray alloc]initWithObjects:lastYearStr,currentYearStr, nil];
}

-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setYear {
    /*
    NSDate *date = [NSDate date];
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@"yyyy"];
    
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        [yearFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
    } else {
        [yearFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    }
    currentYearStr = [NSString stringWithFormat:@"%d", [[yearFormatter stringFromDate:date] intValue]-1];
    int lastYear = [currentYearStr intValue]-1;
    lastYearStr = [NSString stringWithFormat:@"%d", lastYear];
    
    year = currentYearStr;
     
     */
    
    NSString * timeStampString =[ShareUserDetail retrieveDataWithStringKey:@"timestamp_current"];
    NSTimeInterval _interval=[timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
    [_formatter setDateFormat:@"yyyy"];
    NSString *_date=[_formatter stringFromDate:date];
    
    currentYearStr = [NSString stringWithFormat:@"%d", [_date intValue]-1];
    lastYearStr = [NSString stringWithFormat:@"%d", [_date intValue]-2];
    
//    currentYearStr = @"2556";
//    lastYearStr = @"2555";
    year = currentYearStr;
    
}

- (void) checkStatus {
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
    [self callServiceWithFormType:detectFormType taxYear:year];
}

- (IBAction)onButtonPrintFormClicked:(id)sender {
    [self typeFormActive];
    
    self.pIsReceipt = NO;
    [self checkStatus];
}

- (IBAction)onButtonPrintReceiptClicked:(id)sender {
    [self typeFormInActive];
    
    self.pIsReceipt = YES;
    [self checkStatus];
}

- (void) callServiceWithFormType : (NSString *) formType
                         taxYear : (NSString *) taxYear {
    if ([Util isInternetConnect]) {
        
        [enPrintFormReceiptService requestENPrintFormReceiptServiceWithNid:[ShareUserDetail retrieveDataWithStringKey:@"nid"]
                                                                 authenKey:[ShareUserDetail retrieveDataWithStringKey:@"authenKey"]
                                                                  formCode:@"PND91"
                                                                  formType:formType
                                                                   taxYear:taxYear];
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
    }

}

- (void) responseENPrintFormReceiptService:(NSDictionary *)data {

    NSDictionary *dic = data;
    
    if ([[dic objectForKey:@"responseCode"] isEqualToString:@"0"]) {

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
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseMessage"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.pTitle1.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pTitle2.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pTitle3.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.pDetail1.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    cell.pDetail2.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    cell.pDetail3.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    
    cell.pTitle1.text = title1;
    cell.pTitle2.text = title2;
    cell.pTitle3.text = title3;
    
    cell.pDetail1.text = [refNoArray objectAtIndex:indexPath.row];
    cell.pDetail2.text = [payDateArray objectAtIndex:indexPath.row];
    cell.pDetail3.text = [TextFormatterUtil formatAmount:[taxAmountArray objectAtIndex:indexPath.row]];
    
    
    UIView *bgColorView = [[UIView alloc] init];
    if (currentIndex==-1) {

        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
    } else {
        if (currentIndex==indexPath.row) {

            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_list_selection.png"]];
            cell.textLabel.textColor = [UIColor whiteColor];
        } else {

            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }
    [bgColorView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_list_selection.png"]]];
    [cell setSelectedBackgroundView:bgColorView];
    
    UIImage *img = [UIImage imageNamed:@"bg_list_line.png"];
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 95-img.size.height, img.size.width, img.size.height)];
    imv.image = img;
    [cell addSubview:imv];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EfilingPrintDetailViewController *vc = [[EfilingPrintDetailViewController alloc]initWithNibName:@"EfilingPrintDetailViewController" bundle:nil];
    vc.pUrl = [printURLArray objectAtIndex:indexPath.row];
    vc.pFormType = detectFormType;
    vc.pYear = year;
    vc.pNid = nidStr;
    vc.pRefNo = [refNoArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - page flow delegate
- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView;{
    return CGSizeMake(130, 50);
}

- (void)flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index {
    if (index!=-1) {
        if (index==0) {
            year = lastYearStr;
            
            [self callServiceWithFormType:detectFormType taxYear:lastYearStr];
            
        } else {
            year = currentYearStr;
            [self callServiceWithFormType:detectFormType taxYear:currentYearStr];
        }
    }
}

- (void)flowView:(PagedFlowView *)flowView didTapPageAtIndex:(NSInteger)index{

}

#pragma mark PagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView{
    return 2;
}

- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    slidePageFlow = [Util loadViewWithNibName:@"SlidePageFlow"];
    slidePageFlow.pLabel.text = [NSString stringWithFormat:@"%@%@%@",[Util stringWithScreenName:@"Common" labelName:@"TaxYear"], @" ", [yearArray objectAtIndex:index]];
    [slidePageFlow.pLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleNormal]];
    
    return slidePageFlow;
}

- (IBAction)pageControlValueDidChange:(id)sender {
    UIPageControl *pageControl = sender;
    [self.hFlowView scrollToPage:pageControl.currentPage];
}

@end
