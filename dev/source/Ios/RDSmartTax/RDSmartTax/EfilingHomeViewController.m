//
//  EfilingHomeViewController.m
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingHomeViewController.h"
#import "EfilingPersonalProfileViewController.h"
#import "EfilingPaymentViewController.h"
#import "EfilingPrintFormAndReceiptViewController.h"
#import "SettingMainViewController.h"
#import "EfilingReturnTaxResutViewController.h"
#import "EfilingChangePasswordViewController.h"
#import "EfilingSuggestionViewController.h"
#import "EfilingArrearViewController.h"
#import "EfilingTaxPaymentViewController.h"
#import "EflingTermAndConditionViewController.h"
#import "ShareUserDetail.h"
#import "Util.h"
#import "FontUtil.h"
#import "Header.h"

#import "ENCheckTemptaxform.h"
@interface EfilingHomeViewController () {
    NSArray *menuTitle;
    NSArray *menuIcon;
    NSArray *menuIconSelection;
    int currentIndex;
}

@end

@implementation EfilingHomeViewController
@synthesize engetForm;
@synthesize enLogoutService;
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
    menuTitle = [[NSArray alloc] initWithObjects:
                 [Util stringWithScreenName:@"Suggestion" labelName:@"SuggestionTitle"],
                 [Util stringWithScreenName:@"Profile" labelName:@"ProfileTitle"],
                 [Util stringWithScreenName:@"Efiling" labelName:@"EfilingTitle"],
                 [Util stringWithScreenName:@"Payment" labelName:@"PaymentTitle"],
                 [Util stringWithScreenName:@"Print" labelName:@"PrintTitle"],
                 [Util stringWithScreenName:@"CheckReturnTaxResult" labelName:@"CheckReturnTaxResultTitle"],
                 [Util stringWithScreenName:@"ChangePassword" labelName:@"ChangePasswordTitle"],
                 nil];
    
    menuIcon = [[NSArray alloc] initWithObjects:
                @"icon_suggestion.png",
                @"icon_general_profile.png",
                @"icon_pnd91.png",
                @"icon_payment.png",
                @"icon_print.png",
                @"icon_check_taxrefund.png",
                @"icon_change_password.png",
                nil];
    
    menuIconSelection = [[NSArray alloc] initWithObjects:
                @"icon_suggestion_selection.png",
                @"icon_general_profile_selection.png",
                @"icon_pnd91_selection.png",
                @"icon_payment_selection.png",
                @"icon_print_selection.png",
                @"icon_check_taxrefund_selection.png",
                @"icon_change_password_selection.png",
                nil];
    
    // set top view
    NSString *name = [ShareUserDetail retrieveDataWithStringKey:@"name"];
    NSString *surname = [ShareUserDetail retrieveDataWithStringKey:@"surname"];
    NSString *fullName =[NSString stringWithFormat:@"%@ %@",name,surname];
    self.lbName.text = fullName;
    
    self.lbLoginTitle.text = [NSString stringWithFormat:@"%@ %@",[Util stringWithScreenName:@"Common" labelName:@"LatestLogin"],@":"];
    
    
    //-- Date
    NSString *dateStr = [ShareUserDetail retrieveDataWithStringKey:@"lastAccessed"];

    if (![dateStr isEqualToString:@""]) {
        /*
        NSArray *allTextArray = [dateStr componentsSeparatedByString:@" "];
        NSString *dateString = [allTextArray objectAtIndex:0];
        NSArray *time = [allTextArray objectAtIndex:1];
        
        NSString *date = [dateString substringToIndex:2];
        NSString *month = [dateString substringWithRange:NSMakeRange(2, 2)];
        NSString *year = [dateString substringFromIndex:[dateString length]-4];
        
        NSString *defaulDateStr= [NSString stringWithFormat:@"%@%@%@%@%@%@%@",date,@" ",month,@" ",year,@" ",time];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        if ([@"T" isEqualToString:[Util loadAppSettingWithName:@"AppLanguage"]]) {
            [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
        } else {
            [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        }
        
        NSDate *defaulDate = [[NSDate alloc] init];
        [dateFormatter setDateFormat:@"dd MM yyyy HH:mm"];
        defaulDate = [dateFormatter dateFromString:defaulDateStr];
        
        NSString *convertedDateString;
        
        if ([@"T" isEqualToString:[Util loadAppSettingWithName:@"AppLanguage"]]) {
            [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm"];
            convertedDateString = [dateFormatter stringFromDate:defaulDate];
            convertedDateString = [NSString stringWithFormat:@"%@ %@",convertedDateString,@"น."];
        }else{
            [dateFormatter setDateFormat:@"dd MMMM yyyy hh:mm a"];
            convertedDateString = [dateFormatter stringFromDate:defaulDate];
        }
         self.lbLatestLogin.text = convertedDateString;
         */
        

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        
        NSDate *date = [dateFormatter dateFromString: dateStr]; // here you can fetch date from string with define format
        dateFormatter = [[NSDateFormatter alloc] init];
        NSString *convertedString;
        if ([@"T" isEqualToString:[Util loadAppSettingWithName:@"AppLanguage"]]) {
            [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"]];
        } else {
            [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        }
        if ([@"T" isEqualToString:[Util loadAppSettingWithName:@"AppLanguage"]]) {
            [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm"];
            convertedString = [dateFormatter stringFromDate:date];
            convertedString = [NSString stringWithFormat:@"%@ %@",convertedString,@"น."];
        }else{
            [dateFormatter setDateFormat:@"dd MMMM yyyy hh:mm a"];
            convertedString = [dateFormatter stringFromDate:date];
        }
        self.lbLatestLogin.text = convertedString;
    }
   
    
    
    [self setFontStyle];
    
    currentIndex = -1;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    //-- Header
    self.header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    self.header.pImage.image = [UIImage imageNamed:@"logo_efiling.png"];
    self.header.pLabel.hidden = YES;
    self.header.pLeftButton.hidden = YES;
    self.header.pRightButton.hidden = NO;
    [self.header.pRightButton setImage:[UIImage imageNamed:@"btn_logout.png"] forState:UIControlStateNormal];
    [self.header.pRightButton addTarget:self action:@selector(onLogoutBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.pHeaderView addSubview:self.header];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onLogoutBtnClicked:(id)sender {
    [self alertYesNoWithTitle:@""detail:[Util stringWithScreenName:@"Logout" labelName:@"Title"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"] no:[Util stringWithScreenName:@"Common" labelName:@"No"]];
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
    return [menuTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    cell.textLabel.text = [menuTitle objectAtIndex:indexPath.row];
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
    
    UIImage *img = [UIImage imageNamed:@"bg_list_line.png"];
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50-img.size.height, img.size.width, img.size.height)];
    imv.image = img;
    [cell addSubview:imv];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    currentIndex = indexPath.row;
    [self.tableView reloadData];
    
    if (indexPath.row==0) {
        EfilingSuggestionViewController *suggestion = [[EfilingSuggestionViewController alloc]initWithNibName:@"EfilingSuggestionViewController" bundle:nil];
        [self.navigationController pushViewController:suggestion animated:YES];
    } else if (indexPath.row==1) {
        EfilingPersonalProfileViewController *profile = [[EfilingPersonalProfileViewController alloc]initWithNibName:@"EfilingPersonalProfileViewController" bundle:nil];
        [self.navigationController pushViewController:profile animated:YES];
    } else if (indexPath.row==2) {
        
        [self requestDataTempTaxForm];
        if ([statusPay isEqualToString:@"pay"]) {
            EfilingArrearViewController *arear = [[EfilingArrearViewController alloc]initWithNibName:@"EfilingArrearViewController" bundle:nil];
            [self.navigationController pushViewController:arear animated:YES];

        }
        else
        {
            EflingTermAndConditionViewController *tax = [[EflingTermAndConditionViewController alloc]initWithTypeOfPnd:statusPay];
            [self.navigationController pushViewController:tax animated:YES];
        }
       
    } else if (indexPath.row==3) {
        EfilingTaxPaymentViewController *payment = [[EfilingTaxPaymentViewController alloc]initWithNibName:@"EfilingTaxPaymentViewController" bundle:nil];
        payment.formPage = @"home";
        [self.navigationController pushViewController:payment animated:YES];
    } else if (indexPath.row==4) {
        EfilingPrintFormAndReceiptViewController *print = [[EfilingPrintFormAndReceiptViewController alloc]initWithNibName:@"EfilingPrintFormAndReceiptViewController" bundle:nil];
        [self.navigationController pushViewController:print animated:YES];
    } else if (indexPath.row==5) {
        EfilingReturnTaxResutViewController *doc = [[EfilingReturnTaxResutViewController alloc]initWithNibName:@"EfilingReturnTaxResutViewController" bundle:nil];
        [self.navigationController pushViewController:doc animated:YES];
    } else if (indexPath.row==6) {
        EfilingChangePasswordViewController *password = [[EfilingChangePasswordViewController alloc]initWithNibName:@"EfilingChangePasswordViewController" bundle:nil];
        [self.navigationController pushViewController:password animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Alert with condition
- (void) alertYesNoWithTitle : (NSString *)title detail:(NSString *)detail yes:(NSString *)yes no:(NSString *)no {
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:title];
    [alert setMessage:detail];
    [alert setDelegate:self];
    [alert addButtonWithTitle:yes];
    [alert addButtonWithTitle:no];
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        enLogoutService = [[ENLogoutService alloc]init];
        enLogoutService.delegate = self;
        [enLogoutService requestENLogoutService];
        
    } else if (buttonIndex == 1){
        currentIndex = -1;
        [self.tableView reloadData];
        return;
    }
}

- (void) responseENLogoutService:(NSDictionary *)data {
    NSDictionary *dic = data;
    
    if ([[dic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
        [ShareUserDetail resetData];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }  else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseMessage"]];
    }
}

- (void) setFontStyle {
    [self.lbName setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [self.lbLoginTitle setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [self.lbLatestLogin setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

}

- (void) setLanguage {

}

- (IBAction)onBackToMainMenuButtonClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - REQUEST DATA TempTaxForm
-(void)requestDataTempTaxForm
{
    //-- Call Service
    engetForm = [[ENCheckTemptaxform alloc]init];
    engetForm.delegate = self;
    [engetForm requestENCheckTemptaxformService];
}
-(void)responseENgetFormPnd91Service:(NSDictionary *)data
{
//    NSDictionary *dic = data;//[NSDictionary dictionaryWithJSONData:data];
//    
//    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
//        responseData = [[NSMutableDictionary alloc]initWithDictionary:dic];
//        
//        [formsArray addObjectsFromArray:[[responseData objectForKey:@"responseData"] objectForKey:@"forms"]];
//        [self createviewCheckboxWithData:[formsArray objectAtIndex:0]];
//    }
}
@end
