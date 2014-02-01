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
#import "ShareUserDetail.h"
#import "JLString.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

//--print page
#import "TaxStep4ViewController.h"
@interface EfilingTaxPaymentViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray *payList;
    NSMutableDictionary *responseData;

    NSString *ok;
    NSString *cancel;

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
//    self.title = @"ยื่นภาษี";
    
    if ([statusCal isEqualToString:@"pay"]) {
        isPay = YES;

    }
    else
    {
        isPay = NO;
    }
    
    [self setDefault];
    [self setFontStyle];
    [self setLanguage];
    [self requestData];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"พิมพ์แบบ" style:UIBarButtonItemStyleBordered target:self action:@selector(rightButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self createHeaderInview];
}

- (void) createHeaderInview
{
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.text = @"ชำระภาษี";
    [self.header.pLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    
   
}
-(void)setLeftButton
{
    [self.header.pLeftButton removeTarget:nil
                                   action:NULL
                         forControlEvents:UIControlEventAllEvents];

    [self.header.pLeftButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
//    [self.header.pLeftButton setTitle:[JLString removeNullString:[Util stringWithScreenName:@"Common" labelName:@"Success"]]  forState:UIControlStateNormal];
    [self.header.pLeftButton setImage:[UIImage imageNamed:@"btn_efiling_home.png"] forState:UIControlStateNormal];
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    if (isPay) {

    }
    else
    {
//        [scrollview setContentOffset:CGPointMake(0,0) animated:NO];

    }
}
-(void)setCaptureButton
{
//    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
//                                initWithTitle:@"กลับสู่เมนูหลัก"
//                                style:UIBarButtonItemStyleBordered
//                                target:self
//                                action:@selector(popBack)];
//    self.navigationItem.leftBarButtonItem = btnBack;
    
//    [self.header.pLeftButton setTitle:@"ต่อไป" forState:UIControlStateNormal];
//    [self.header.pLeftButton removeTarget:nil
//                       action:NULL
//             forControlEvents:UIControlEventAllEvents];
//    [self.header.pLeftButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    
//    self.header.pLeftButton.hidden = YES;
    
//    [self.header.pRightButton setTitle:@"บันทึกหน้าจอ" forState:UIControlStateNormal];
    [self.header.pRightButton setImage:[UIImage imageNamed:@"btn_screen_shot.png"] forState:UIControlStateNormal];
    [self.header.pRightButton removeTarget:nil
                                   action:NULL
                         forControlEvents:UIControlEventAllEvents];
    [self.header.pRightButton addTarget:self action:@selector(captureClicked) forControlEvents:UIControlEventTouchUpInside];
    self.header.pRightButton.hidden = NO;

}
-(void) captureClicked {
    JLLog(@"capture");
//    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"บันทึกรูปผลการยื่นแบบ" delegate:self cancelButtonTitle:ok otherButtonTitles:cancel, nil];
    [alert setTag:1];
    [alert show];
}
-(void) captureScreen
{
    CGSize size ;
    if (isPay) {
        size = detailview.frame.size;
        size.height = 250;
    }
    else if (!isPay) {
        size = isZeroView.frame.size;
        size.height = 250;

    }
    
    UIGraphicsBeginImageContextWithOptions(size, self.view.opaque, 0.0);
    
    [detailview setBackgroundColor:[UIColor whiteColor]];
    [detailview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //    NSData *imageData = UIImageJPEGRepresentation(imageView, 1.0 ); //you can use PNG too
    //    [imageData writeToFile:@"image1.jpeg" atomically:YES];
//    UIImageWriteToSavedPhotosAlbum(imageView, nil, nil, nil);
//    self.library = [[ALAssetsLibrary alloc] init];
//
//    [self.library saveImage:imageView toAlbum:@"RDSmartTax" withCompletionBlock:^(NSError *error) {
//        if (error!=nil) {
//            NSLog(@"Big error: %@", [error description]);
//        }
//    }];

    [Util saveImageToAlbumWithImage:imageView];
    
    [detailview setBackgroundColor:[UIColor clearColor]];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"บันทึกรูปผลการยื่นแบบ สำเร็จ" delegate:nil cancelButtonTitle:ok otherButtonTitles: nil];
    [alert show];
}
-(void) popBack {
//    [self.navigationController popViewControllerAnimated:YES];
    
    if ([[JLString removeNullString:[ShareUserDetail retrieveDataWithStringKey:@"displaySatisfication"]]isEqualToString:@"0"]) {
        EfilingRatingViewController *rating = [[EfilingRatingViewController alloc]initWithNibName:@"EfilingRatingViewController" bundle:nil];
        [self.navigationController pushViewController:rating animated:YES];
    }
    else
    {
        EfilingRatingViewController *rating = [[EfilingRatingViewController alloc]initWithNibName:@"EfilingRatingViewController" bundle:nil];
        [self.navigationController pushViewController:rating animated:YES];
//        for(id vc in self.navigationController.viewControllers)
//        {
//            if([vc isKindOfClass:[EfilingHomeViewController class]])
//            {
//                EfilingHomeViewController *homeVC = (EfilingHomeViewController *)vc;
//                [self.navigationController popToViewController:homeVC animated:YES];
//                return;
//            }
//        }
    }

   
    
}
-(void)setDefault
{
    if (isPay) {
        [detailview setFrame:CGRectMake(0, 0, detailview.frame.size.width, detailview.frame.size.height)];
        [scrollview addSubview:detailview];
        [scrollview setContentSize:CGSizeMake(detailview.frame.size.width, detailview.frame.size.height)];
//        [scrollview setContentOffset:CGPointMake(0,0) animated:NO];
//        self.header.pLeftButton.hidden = YES;
        [self setCaptureButton];
        [self setLeftButton];
    }
    else
    {
        [isZeroView setFrame:CGRectMake(0, 0, isZeroView.frame.size.width, isZeroView.frame.size.height)];
        [scrollview addSubview:isZeroView];
        [scrollview setContentSize:CGSizeMake(isZeroView.frame.size.width, isZeroView.frame.size.height)];
//        self.header.pLeftButton.hidden = YES;
//        [scrollview setContentOffset:CGPointMake(0,0) animated:NO];

//        [self setBackButton];
        [self setLeftButton];

    }
    if ([_formPage isEqualToString:@"home"]) {
        self.header.pLeftButton.hidden = NO;
    }
}

-(void)setPayList
{
    payList = [[NSMutableArray alloc]init];
    [payList addObjectsFromArray:[[responseData objectForKey:@"responseData"]objectForKey:@"fields"]];
    JLLog(@"payList:%@",[[responseData objectForKey:@"responseData"]objectForKey:@"fields"]);
    logo1Label.text = [JLString removeNullString:[[payList objectAtIndex:0]objectForKey:@"label"]];
    logo2Label.text = [JLString removeNullString:[[payList objectAtIndex:1]objectForKey:@"label"]];
    logo3Label.text = [JLString removeNullString:[[payList objectAtIndex:2]objectForKey:@"label"]];
    logo4Label.text = [JLString removeNullString:[[payList objectAtIndex:3]objectForKey:@"label"]];
    logo5Label.text = [JLString removeNullString:[[payList objectAtIndex:4]objectForKey:@"label"]];

    [logo1Label setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
    [logo2Label setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
    [logo3Label setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
    [logo4Label setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
    [logo5Label setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
    
    [logo1Label sizeToFit];
    [logo2Label sizeToFit];
    [logo3Label sizeToFit];
    [logo4Label sizeToFit];
    [logo5Label sizeToFit];

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
    [zNextButton setTitle:[Util stringWithScreenName:@"Common" labelName:@"Success"] forState:UIControlStateNormal];
    [pNextButton setTitle:[Util stringWithScreenName:@"Common" labelName:@"Success"] forState:UIControlStateNormal];

    ok = [Util stringWithScreenName:@"Common" labelName:@"Ok"];
    cancel = [Util stringWithScreenName:@"Common" labelName:@"Cancel"];
    //    [self.titlesetText:[Util stringWithScreenName:@"Login" labelName:@"EfilingTitle"]];
    //    [self.labelIdCard setText:[Util stringWithScreenName:@"Login" labelName:@"Nid"]];
    //    [self.btnLogin setTitle:[Util stringWithScreenName:@"Login" labelName:@"Title"] forState:UIControlStateNormal];
}

- (void) setFontStyle {

    
    [titleHLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [printButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
    [refnoHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [refnoLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    [payTypeHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [payTypeLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [payDateHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [payDateLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    [listTaxHLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
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

- (IBAction)nextClicked:(id)sender {
    if ([[JLString removeNullString:[ShareUserDetail retrieveDataWithStringKey:@"displaySatisfication"]]isEqualToString:@"0"]) {
        EfilingRatingViewController *rating = [[EfilingRatingViewController alloc]initWithNibName:@"EfilingRatingViewController" bundle:nil];
        [self.navigationController pushViewController:rating animated:YES];
    }
    else
    {
        
        for(id vc in self.navigationController.viewControllers)
        {
            if([vc isKindOfClass:[EfilingHomeViewController class]])
            {
                EfilingHomeViewController *homeVC = (EfilingHomeViewController *)vc;
                [self.navigationController popToViewController:homeVC animated:YES];
                return;
            }
        }
    }

}

- (IBAction)paymentClicked:(UIButton *)sender {
    NSDictionary *dataDic = [payList objectAtIndex:sender.tag];
    EfilingTaxPaymentOtherViewController *other = [[EfilingTaxPaymentOtherViewController alloc]initWithNibName:@"EfilingTaxPaymentOtherViewController" bundle:nil];
    other.resposeData = dataDic;
    [self.navigationController pushViewController:other animated:YES];
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
    if ([Util isInternetConnect]) {
        ENUpdatePnd91 *engetForm = [[ENUpdatePnd91 alloc]init];
        engetForm.delegate = self;
        [engetForm requestENUpdatePnd91ServiceWithAPIReferenceNo:@"" DataPnd:nil];

        
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
    }

}
-(void)responseENUpdatePnd91Service:(NSDictionary *)data
{
    NSDictionary *dic = data;//[NSDictionary dictionaryWithJSONData:data];
    
    if ([[data objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        responseData = [[NSMutableDictionary alloc]initWithDictionary:data];
        JLLog(@"responseData : %@",responseData);
        [self setPayList];

//        [formsArray addObjectsFromArray:[[responseData objectForKey:@"responseData"] objectForKey:@"forms"]];
//        [self createviewCheckboxWithData:[formsArray objectAtIndex:0]];
    }
}
#pragma mark - UIALERTVIEW DELEGAT
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [self captureScreen];
        }
    }
}
@end
