//
//  TaxStep5ViewController.m
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 12/19/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "TaxStep5ViewController.h"
#import "EfilingTaxResultDetailViewController.h"
#import "EfilingRatingViewController.h"
#import "EfilingTaxPaymentViewController.h"
#import "FontUtil.h"
#import "Util.h"
#import "ShareUserDetail.h"
#import "TextFormatterUtil.h"
#import "JLString.h"

#import "ENgetPnd91CalTax.h"
#import "ENUpdatePnd91.h"

#define checked @"bg_checked.png"
#define unchecked @"bg_check.png"

#define right_0 @"btn_switch_right_inActive.png"
#define right_1 @"btn_switch_right_active.png"
#define left_0 @"btn_switch_left_inActive.png"
#define left_1 @"btn_switch_left_active.png"

#define kMargin 230

#define zero @"zero"
#define pay @"pay"
#define back @"back"
@interface TaxStep5ViewController ()<UIAlertViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,ENgetPnd91CalTaxDelegate,ENgetENUpdatePnd91Delegate>
{
    UITextField *currentTextField;

//    BOOL isPay;
    NSString *ok;
    NSString *cancel;
   
    NSString *typeView;
    UIPickerView *dropDownPickerView;
    UIActionSheet *dropDownActionSheet;
    
    UIButton *currentButton;

    NSMutableArray *partyArray;
    
    CGFloat screenHeight;

    NSMutableDictionary *caltaxData;
}
@end

@implementation TaxStep5ViewController
@synthesize calTax;
@synthesize update;
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
    
    typeView = statusCal;
    partyArray = [[NSMutableArray alloc]init];
    [partyArray addObject:@"พรรคเพื่อไทย"];
    [partyArray addObject:@"พรรคประชาธิปัตย์"];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenHeight = screenRect.size.height;

    JLLog(@"_sharedData CalTax : %@",_sharedData);
    
    
    [self updateData];
    [self requestAPICalTax];
    [self setLanguage];
    [self setFontStyle];
    [self setDefault];
    
    [self createHeaderInview];
}
- (void) updateData
{
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:[_sharedData objectForKey:@"keys"]];
   
    NSArray *mArray = [mDic allKeys];
    for (int i = 0; i < [_sharedData allKeys].count; i++) {
        NSString *kShareData = [JLString removeNullString:[[_sharedData allKeys]objectAtIndex:i ]];
        JLLog(@"%@",kShareData)

        for (int cMDic = 0; cMDic < mArray.count; cMDic++) {
            
            NSString *kMDic = [JLString removeNullString:[mArray objectAtIndex:cMDic]];
            if ([kShareData isEqualToString:kMDic]) {
                if ([kShareData isEqualToString:@"incomePayer"]) {
                    [mDic setObject:[[JLString removeNullString:[_sharedData objectForKey:kShareData]]stringByReplacingOccurrencesOfString:@"-" withString:@""] forKey:kShareData];
                }
                else
                {
                    [mDic setObject:[JLString removeNullString:[_sharedData objectForKey:kShareData]] forKey:kShareData];

                }
            }

        }
    }
    
    [_sharedData setObject:mDic forKey:@"keys"];
}
- (void) createHeaderInview
{
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.text = @"ยื่นภาษี";
    [self.header.pLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Request API CalTax
-(void)requestAPICalTax
{
    if ([Util isInternetConnect]) {
        //-- check version
        calTax = [[ENgetPnd91CalTax alloc]init];
        [calTax setDelegate:self];
        [calTax requestENCalTaxServiceWithAPIReferenceNo:[_sharedData objectForKey:@"apiRefNo"] DataPnd:[_sharedData objectForKey:@"keys"]];
        
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
    }

   
}
-(void)responseENgetPnd91CalTaxService:(NSDictionary *)data
{
    JLLog(@"%@",data);
//    apiRefNo
//    nid
//    netTaxValue
//    totTaxValue
//    chkRefund
//    partyCode
//    smsTax
//    forms
//    formId
//    formName
//    formData
//    header
//    fields
//    identify
//    label
//    format
//    type
//    secure
}
#pragma mark - Request API UPDATE
-(void)requsetAPIUpDate
{
    if ([Util isInternetConnect]) {
        update = [[ENUpdatePnd91 alloc]init];
        [update setDelegate:self];
        [update requestENUpdatePnd91ServiceWithAPIReferenceNo:@"" DataPnd:_sharedData];
        
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
    }

   
}
-(void)responseENUpdatePnd91Service:(NSDictionary *)data
{
    JLLog(@"%@",data);

}
#pragma - Decorate Label
- (void) setLanguage {
    //    [self.titlesetText:[Util stringWithScreenName:@"Login" labelName:@"EfilingTitle"]];
    //    [self.labelIdCard setText:[Util stringWithScreenName:@"Login" labelName:@"Nid"]];
    //    [self.btnLogin setTitle:[Util stringWithScreenName:@"Login" labelName:@"Title"] forState:UIControlStateNormal];
    ok = [Util stringWithScreenName:@"Common" labelName:@"Ok"];
    cancel = [Util stringWithScreenName:@"Common" labelName:@"Cancel"];

}

- (void) setFontStyle {

    [titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];

    [tBackHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [tBackLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
    [partyHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [party1Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [party2Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    [backTaxHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [back1Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [back2Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    [telephoneHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [telephoneTextField setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    [detailButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [sendDataButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
    [tpHeaderLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [tpPartyHeaderLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    
    [tpPayHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [tpPayLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [tpButton2Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [tpButton1Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [tpChoosePartyLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [tpChoosePartyButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    [choosePartyButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [choosePartyHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];

    [zHeaderLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [zAmountHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [zAmountLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];


}
#pragma mark - SetView
-(void)setDefault
{
    subheaderLabel.text = @"ผลการคำนวนภาษี";
    [subheaderLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];

    if ([typeView isEqualToString:zero]) {
        [scrollview addSubview:zView];
        CGRect footerFrame = footerView.frame;
        footerFrame.origin.y = zView.frame.size.height + zView.frame.origin.y;
        
        if (footerFrame.origin.y<screenHeight) {
            footerFrame.origin.y = scrollview.frame.size.height - footerFrame.size.height- 20;
        }
        else
        {
            footerFrame.origin.y = zView.frame.size.height + zView.frame.origin.y;
            
        }

        [footerView setFrame:footerFrame];
        [scrollview addSubview:footerView];
        [scrollview setContentSize:CGSizeMake(footerFrame.size.width, footerFrame.size.height + footerFrame.origin.y + kMargin)];
        
        //-- Add Tap Gesture -----------------------------------------------------
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        tapGesture.delegate = self;
        [zView addGestureRecognizer:tapGesture];
    }
    
    else if ([typeView isEqualToString:back]) {
        [scrollview addSubview:taxBackView];
        CGRect footerFrame = footerView.frame;
        footerFrame.origin.y = taxBackView.frame.size.height + taxBackView.frame.origin.y;
        if (footerFrame.origin.y<screenHeight) {
            footerFrame.origin.y = scrollview.frame.size.height - footerFrame.size.height+ 30 ;//- 20;
        }
        else
        {
            footerFrame.origin.y = taxBackView.frame.size.height + taxBackView.frame.origin.y ;
            
        }
        [footerView setFrame:footerFrame];
        [scrollview addSubview:footerView];
        [scrollview setContentSize:CGSizeMake(footerFrame.size.width, footerFrame.size.height + footerFrame.origin.y + kMargin)];

        [telephoneTextField setText:[TextFormatterUtil formatHomeNo:[ShareUserDetail retrieveDataWithStringKey:@"contractNo"]]];
        //-- Add Tap Gesture -----------------------------------------------------
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        tapGesture.delegate = self;
        [taxBackView addGestureRecognizer:tapGesture];
    }
    
    else if ([typeView isEqualToString:pay]) {
        [scrollview addSubview:taxPayNotZeroView];
        CGRect footerFrame = footerView.frame;
        footerFrame.origin.y = taxPayNotZeroView.frame.size.height + taxPayNotZeroView.frame.origin.y;
        if (footerFrame.origin.y<screenHeight) {
            footerFrame.origin.y = scrollview.frame.size.height - footerFrame.size.height - 20;
        }
        else
        {
            footerFrame.origin.y = taxPayNotZeroView.frame.size.height + taxPayNotZeroView.frame.origin.y;
            
        }
        [footerView setFrame:footerFrame];
        [scrollview addSubview:footerView];
        [scrollview setContentSize:CGSizeMake(footerFrame.size.width, footerFrame.size.height + footerFrame.origin.y + kMargin)];
        
        //-- Add Tap Gesture -----------------------------------------------------
        
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//        tapGesture.delegate = self;
//        [taxPayNotZeroView addGestureRecognizer:tapGesture];
    }
    [scrollview setContentOffset:CGPointMake(0, 0) animated:NO];

}
- (IBAction)choosePartyClicked:(UIButton *)sender {
    currentButton = sender;
    [self showDropDownViewWithTag:sender.tag Delegate:self];

    
}

- (IBAction)taxDetailClicked:(id)sender {
    EfilingTaxResultDetailViewController *taxDetail = [[EfilingTaxResultDetailViewController alloc]initWithNibName:@"EfilingTaxResultDetailViewController" bundle:nil];
    [self.navigationController pushViewController:taxDetail animated:YES];
}

- (IBAction)sendTaxClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"ยืนยันการส่งข้อมูลแบบ ภ.ง.ด.91" delegate:self cancelButtonTitle:ok otherButtonTitles:cancel, nil];
    [alert setTag:0];
    [alert show];
}

- (IBAction)party1Clicked:(id)sender {
//    [party1Button setImage:[UIImage imageNamed:checked] forState:UIControlStateNormal];
//    [party2Button setImage:[UIImage imageNamed:unchecked] forState:UIControlStateNormal];

    [party1Button setBackgroundImage:[UIImage imageNamed:left_1] forState:UIControlStateNormal];
    [party2Button setBackgroundImage:[UIImage imageNamed:right_0] forState:UIControlStateNormal];
    

    [party1Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [party2Button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

    JLLog(@"p1 Clicked");
}

- (IBAction)party2Clicked:(id)sender {
//    [party1Button setImage:[UIImage imageNamed:unchecked] forState:UIControlStateNormal];
//    [party2Button setImage:[UIImage imageNamed:checked] forState:UIControlStateNormal];

    [party1Button setBackgroundImage:[UIImage imageNamed:left_0] forState:UIControlStateNormal];
    [party2Button setBackgroundImage:[UIImage imageNamed:right_1] forState:UIControlStateNormal];

    [party1Button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [party2Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    JLLog(@"p2 Clicked");

}

- (IBAction)back1Clicked:(id)sender {
//    [back1Button setImage:[UIImage imageNamed:checked] forState:UIControlStateNormal];
//    [back2Button setImage:[UIImage imageNamed:unchecked] forState:UIControlStateNormal];

    [back1Button setBackgroundImage:[UIImage imageNamed:left_1] forState:UIControlStateNormal];
    [back2Button setBackgroundImage:[UIImage imageNamed:right_0] forState:UIControlStateNormal];
    
     [back1Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back2Button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    

}

- (IBAction)back2Clicked:(id)sender {
//    [back1Button setImage:[UIImage imageNamed:unchecked] forState:UIControlStateNormal];
//    [back2Button setImage:[UIImage imageNamed:checked] forState:UIControlStateNormal];
    [back1Button setBackgroundImage:[UIImage imageNamed:left_0] forState:UIControlStateNormal];
    [back2Button setBackgroundImage:[UIImage imageNamed:right_1] forState:UIControlStateNormal];
    
    

    [back1Button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [back2Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    

}

- (IBAction)tpButton1Clicked:(UIButton *)sender {
//    [tpButton1 setImage:[UIImage imageNamed:checked] forState:UIControlStateNormal];
//    [tpButton2 setImage:[UIImage imageNamed:unchecked] forState:UIControlStateNormal];
    
    [tpButton1 setBackgroundImage:[UIImage imageNamed:left_1] forState:UIControlStateNormal];
    [tpButton2 setBackgroundImage:[UIImage imageNamed:right_0] forState:UIControlStateNormal];
    
    [tpButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tpButton2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
}

- (IBAction)tpButton2Clicked:(UIButton *)sender {
//    [tpButton1 setImage:[UIImage imageNamed:unchecked] forState:UIControlStateNormal];
//    [tpButton2 setImage:[UIImage imageNamed:checked] forState:UIControlStateNormal];
    
    [tpButton1 setBackgroundImage:[UIImage imageNamed:left_0] forState:UIControlStateNormal];
    [tpButton2 setBackgroundImage:[UIImage imageNamed:right_1] forState:UIControlStateNormal];
    
    [tpButton1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [tpButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    

    
}

#pragma mark - UITEXTFIELD DELEGATE
-(void)hideKeyboard
{
    if(currentTextField) {
        [currentTextField resignFirstResponder];
        currentTextField = nil;
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTextField = textField;
    
    [scrollview setContentOffset:CGPointMake(0, telephoneView.frame.origin.y-100) animated:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    currentTextField = nil;
    [scrollview setContentOffset:CGPointMake(0, 0) animated:YES];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 0) {
        if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.contractNo"] integerValue]+3) {
            return NO;
        }
        
        if ([string length] == 0) {
            return YES;
        }
        
        if ((range.location == 3) || (range.location == 7))
        {
            NSString *str    = [NSString stringWithFormat:@"%@-",textField.text];
            textField.text   = str;
        }
        return YES;

    }
    
    return YES;
}
#pragma mark - UIALERTVIEW DELEGATE
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0) {
        if (buttonIndex == 0) {
            [self requsetAPIUpDate];
            EfilingTaxPaymentViewController *taxPayment = [[EfilingTaxPaymentViewController alloc]initWithNibName:@"EfilingTaxPaymentViewController" bundle:nil];
            
            [self.navigationController pushViewController:taxPayment animated:YES];
        }
        else if (buttonIndex == 1) {
            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"ต้องการบันทึกเป็นรูปภาพเพื่อใช้ในการชำระเงินภายหลังหรือไม่" delegate:self cancelButtonTitle:cancel otherButtonTitles:ok, nil];
//            [alert setTag:1];
//            [alert show];
        }
    }
   else if (alertView.tag == 1)
   {
       if (buttonIndex == 0) {
           
           EfilingTaxPaymentViewController *taxPayment = [[EfilingTaxPaymentViewController alloc]initWithNibName:@"EfilingTaxPaymentViewController" bundle:nil];
          
           [self.navigationController pushViewController:taxPayment animated:YES];
       }
       else if (buttonIndex == 1) {
           
//           UIGraphicsBeginImageContext(self.view.frame.size);
//           [ renderInContext:UIGraphicsGetCurrentContext()];
//           UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//           UIGraphicsEndImageContext();
//           UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
           
           EfilingTaxPaymentViewController *taxPayment = [[EfilingTaxPaymentViewController alloc]initWithNibName:@"EfilingTaxPaymentViewController" bundle:nil];
           
           [self.navigationController pushViewController:taxPayment animated:YES];
//
//           UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"ต้องการบันทึกเป็นรูปภาพเพื่อใช้ในการชำระเงินภายหลังหรือไม่" delegate:self cancelButtonTitle:@"ไม่ใช่" otherButtonTitles:@"ใช่", nil];
//           [alert setTag:1];
//           [alert show];
       }
   }
}

#pragma mark - Dropdown
-(void)showDropDownViewWithTag:(NSInteger)tag Delegate:(id)delegate

{
    dropDownActionSheet = [[UIActionSheet alloc] init];
    dropDownActionSheet.tag = tag;
    
    if(tag == 0)
    {
        dropDownPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
        dropDownPickerView.showsSelectionIndicator = YES;
        dropDownPickerView.dataSource = delegate;
        dropDownPickerView.delegate = delegate;
        dropDownPickerView.tag = tag;
    }
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    [toolBar sizeToFit];
    
    UIBarButtonItem *bb_flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:delegate action:nil];
    UIBarButtonItem *bb_done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:delegate action:@selector(closePickerWithItem:)];
    bb_done.tag = tag;
    
    NSArray *barItems = @[bb_flex, bb_done];
    
    [toolBar setItems:barItems animated:YES];
    
    [dropDownActionSheet addSubview:toolBar];
    [dropDownActionSheet addSubview:dropDownPickerView];
    
    [dropDownActionSheet showInView:self.view];
    [dropDownActionSheet setBounds:CGRectMake(0, 0, self.view.frame.size.width, 464)];
    
}

-(void)closePickerWithItem:(UIBarButtonItem *)item;
{
    JLLog(@"Tag : %d \nSelected : %d",item.tag,[dropDownPickerView selectedRowInComponent:0]);
    
    switch (item.tag) {
        case 0:
        {
            [currentButton setTitle:[NSString stringWithFormat:@"%@",[JLString removeNullString:[partyArray objectAtIndex:[dropDownPickerView selectedRowInComponent:0]]]] forState:UIControlStateNormal];
        }
    }
    
    [dropDownActionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return partyArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag == 0)
    {
        //        if(row == 0)
        //        {
        //            return [JLString ThaiString:@"--โปรดระบุ--" EngString:@"Please Specify"];
        //        }
        //
        //        NSDictionary *prefixDetail = [prefixList objectAtIndex:row-1];
        return [NSString stringWithFormat:@"%@",[JLString removeNullString:[partyArray objectAtIndex:row]]];
    }
    return @"";
}
@end
