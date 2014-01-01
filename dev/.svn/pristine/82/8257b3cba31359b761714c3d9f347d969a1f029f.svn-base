//
//  EfilingTaxPaymentViewController.m
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 12/22/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingTaxPaymentViewController.h"
#import "EfilingRatingViewController.h"
#import "FontUtil.h"
#import "EfilingHomeViewController.h"
#import "EfilingTaxPaymentOtherViewController.h"
#import "JSONDictionaryExtensions.h"

//--print page
#import "TaxStep4ViewController.h"
@interface EfilingTaxPaymentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *payList;
    NSMutableDictionary *responseData;

    
    
    BOOL isPay;
}
@end

@implementation EfilingTaxPaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"ยื่นภาษี";
    
    if ([statusCal isEqualToString:@"pay"]) {
        isPay = YES;

    }
    else
    {
        isPay = NO;
    }
    [self setDefault];
    [self setFontStyle];
    
    [self requestData];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"พิมพ์แบบ" style:UIBarButtonItemStyleBordered target:self action:@selector(rightButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightButton;
}
-(void)viewDidAppear:(BOOL)animated
{
    if (isPay) {

    }
    else
    {
        [scrollview setContentOffset:CGPointMake(0,80) animated:NO];

    }
}
-(void)setBackButton
{
//    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
//                                initWithTitle:@"กลับสู่เมนูหลัก"
//                                style:UIBarButtonItemStyleBordered
//                                target:self
//                                action:@selector(popBack)];
//    self.navigationItem.leftBarButtonItem = btnBack;
    
    [self.header.pLeftButton setTitle:@"กลับสู่เมนูหลัก" forState:UIControlStateNormal];
    [self.header.pLeftButton removeTarget:nil
                       action:NULL
             forControlEvents:UIControlEventAllEvents];
    [self.header.pLeftButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
}
-(void) popBack {
//    [self.navigationController popViewControllerAnimated:YES];
    EfilingRatingViewController *rating = [[EfilingRatingViewController alloc]initWithNibName:@"EfilingRatingViewController" bundle:nil];
    [self.navigationController pushViewController:rating animated:YES];
}
-(void)setDefault
{
    if (isPay) {
        [detailview setFrame:CGRectMake(0, 0, detailview.frame.size.width, detailview.frame.size.height)];
        [scrollview addSubview:detailview];
        [scrollview setContentSize:CGSizeMake(detailview.frame.size.width, detailview.frame.size.height)];
        [scrollview setContentOffset:CGPointMake(0,0) animated:NO];

        [self setBackButton];

    }
    else
    {
        [isZeroView setFrame:CGRectMake(0, 0, isZeroView.frame.size.width, isZeroView.frame.size.height)];
        [scrollview addSubview:isZeroView];
        [scrollview setContentSize:CGSizeMake(isZeroView.frame.size.width, isZeroView.frame.size.height)];
        [scrollview setContentOffset:CGPointMake(0,80) animated:NO];

        [self setBackButton];
    }
}

-(void)setPayList
{
    payList = [[NSMutableArray alloc]init];
    [payList addObjectsFromArray:[[responseData objectForKey:@"responseData"]objectForKey:@"fields"]];
    JLLog(@"payList:%@",[[responseData objectForKey:@"responseData"]objectForKey:@"fields"]);
//    [payList addObject:@"ATM"];
//    [payList addObject:@"Internet Banking"];
//    [payList addObject:@"Telephone Banking"];
//    [payList addObject:@"Mobile Banking"];

    [payTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - Decorate Label
- (void) setLanguage {
    //    [self.titlesetText:[Util stringWithScreenName:@"Login" labelName:@"EfilingTitle"]];
    //    [self.labelIdCard setText:[Util stringWithScreenName:@"Login" labelName:@"Nid"]];
    //    [self.btnLogin setTitle:[Util stringWithScreenName:@"Login" labelName:@"Title"] forState:UIControlStateNormal];
}

- (void) setFontStyle {
    
//    __weak IBOutlet UILabel *titleHLabel;
//    __weak IBOutlet UIButton *printButton;
//    
//    __weak IBOutlet UILabel *refnoHLabel;
//    __weak IBOutlet UILabel *refnoLabel;
//    
//    __weak IBOutlet UILabel *payTypeHLabel;
//    __weak IBOutlet UILabel *payTypeLabel;
//    
//    __weak IBOutlet UILabel *payDateHLabel;
//    __weak IBOutlet UILabel *payDateLabel;
//    
//    __weak IBOutlet UILabel *listTaxHLabel;
//    __weak IBOutlet UILabel *numberOfTaxHLabel;
//    __weak IBOutlet UILabel *numberOfTaxLabel;
//    
//    __weak IBOutlet UILabel *controlNumberHLabel;
//    __weak IBOutlet UILabel *controlNumberLabel;
//    __weak IBOutlet UILabel *amountHLabel;
//    __weak IBOutlet UILabel *amountLabel;
//    
//    __weak IBOutlet UILabel *cateOfPayHLabel;
    
    [titleHLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [printButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
    [refnoHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [refnoLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    [payTypeHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [payTypeLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [payDateHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [payDateLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    [listTaxHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [numberOfTaxHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [numberOfTaxLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [controlNumberHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [controlNumberLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    [amountHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [amountLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
    [cateOfPayHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
   
    [zHeaderLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [zTaxAmountHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [zTaxAmountLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [zDateHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [zDateLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [zRefHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [zRefLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [zYearHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [zYearLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
    [pHeaderLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];

}

#pragma mark - Action Method
- (void)rightButtonClicked
{
//    EfilingRatingViewController *rating = [[EfilingRatingViewController alloc]initWithNibName:@"EfilingRatingViewController" bundle:nil];
//    [self.navigationController pushViewController:rating animated:YES];
    
//    for(id vc in self.navigationController.viewControllers)
//    {
//        if([vc isKindOfClass:[EfilingHomeViewController class]])
//        {
//            EfilingHomeViewController *homeVC = (EfilingHomeViewController *)vc;
//            [self.navigationController popToViewController:homeVC animated:YES];
//            return;
//        }
//    }
}
- (IBAction)printClicked:(id)sender {
    
}

#pragma mark - UITABLEVIEW DELEGATE
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return payList.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dic = [payList objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"label"]];
    //UITableViewCellAccessoryDisclosureIndicator
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    // Configure the cell.
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dataDic = [payList objectAtIndex:indexPath.row];
    EfilingTaxPaymentOtherViewController *other = [[EfilingTaxPaymentOtherViewController alloc]initWithNibName:@"EfilingTaxPaymentOtherViewController" bundle:nil];
    other.resposeData = dataDic;
    [self.navigationController pushViewController:other animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    EfilingTaxPaymentOtherViewController *other = [[EfilingTaxPaymentOtherViewController alloc]initWithNibName:@"EfilingTaxPaymentOtherViewController" bundle:nil];
//    [self.navigationController pushViewController:other animated:YES];
}
#pragma mark - REQUEST DATA
-(void)requestData
{
    //-- Call Service
    ENUpdatePnd91 *engetForm = [[ENUpdatePnd91 alloc]init];
    engetForm.delegate = self;
    [engetForm requestENUpdatePnd91Service];
}
-(void)responseENUpdatePnd91Service:(NSData *)data
{
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        responseData = [[NSMutableDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithJSONData:data]];
        JLLog(@"responseData : %@",responseData);
        [self setPayList];

//        [formsArray addObjectsFromArray:[[responseData objectForKey:@"responseData"] objectForKey:@"forms"]];
//        [self createviewCheckboxWithData:[formsArray objectAtIndex:0]];
    }
}
@end
