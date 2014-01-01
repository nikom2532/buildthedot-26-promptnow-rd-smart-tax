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
#define checked @"bg_checked.png"
#define unchecked @"bg_check.png"
#define kMargin 260

#define zero @"zero"
#define pay @"pay"
#define back @"back"
@interface TaxStep5ViewController ()<UIAlertViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    UITextField *currentTextField;

//    BOOL isPay;
    NSString *ok;
    NSString *cancel;
   
    NSString *typeView;
}
@end

@implementation TaxStep5ViewController

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
    [self setLanguage];
    [self setFontStyle];
    [self setDefault];
    
   

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
    [tpChoosePartyLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [tpChoosePartyButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    [zHeaderLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [zAmountHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [zAmountLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];


}
#pragma mark - SetView
-(void)setDefault
{
    if ([typeView isEqualToString:zero]) {
        [scrollview addSubview:taxPayView];
        CGRect footerFrame = footerView.frame;
        footerFrame.origin.y = taxPayView.frame.size.height + taxPayView.frame.origin.y;
        [footerView setFrame:footerFrame];
        [scrollview addSubview:footerView];
        [scrollview setContentSize:CGSizeMake(footerFrame.size.width, footerFrame.size.height + footerFrame.origin.y + kMargin)];
        
        //-- Add Tap Gesture -----------------------------------------------------
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        tapGesture.delegate = self;
        [taxPayView addGestureRecognizer:tapGesture];
    }
    
    else if ([typeView isEqualToString:back]) {
        [scrollview addSubview:taxBackView];
        CGRect footerFrame = footerView.frame;
        footerFrame.origin.y = taxBackView.frame.size.height + taxBackView.frame.origin.y;
        [footerView setFrame:footerFrame];
        [scrollview addSubview:footerView];
        [scrollview setContentSize:CGSizeMake(footerFrame.size.width, footerFrame.size.height + footerFrame.origin.y + kMargin)];

        [telephoneTextField setText:[TextFormatterUtil formatMobileNo:[ShareUserDetail retrieveDataWithStringKey:@"contractNo"]]];
        //-- Add Tap Gesture -----------------------------------------------------
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        tapGesture.delegate = self;
        [taxBackView addGestureRecognizer:tapGesture];
    }
    
    else if ([typeView isEqualToString:pay]) {
        [scrollview addSubview:taxPayNotZeroView];
        CGRect footerFrame = footerView.frame;
        footerFrame.origin.y = taxPayNotZeroView.frame.size.height + taxPayNotZeroView.frame.origin.y;
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
}

- (IBAction)taxDetailClicked:(id)sender {
    EfilingTaxResultDetailViewController *taxDetail = [[EfilingTaxResultDetailViewController alloc]initWithNibName:@"EfilingTaxResultDetailViewController" bundle:nil];
    [self.navigationController pushViewController:taxDetail animated:YES];
}

- (IBAction)sendTaxClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"ยืนยันการส่งข้อมูลแบบ ภ.ง.ด.91" delegate:self cancelButtonTitle:cancel otherButtonTitles:ok, nil];
    [alert setTag:0];
    [alert show];
}

- (IBAction)party1Clicked:(id)sender {
    [party1Button setImage:[UIImage imageNamed:checked] forState:UIControlStateNormal];
    [party2Button setImage:[UIImage imageNamed:unchecked] forState:UIControlStateNormal];

}

- (IBAction)party2Clicked:(id)sender {
    [party1Button setImage:[UIImage imageNamed:unchecked] forState:UIControlStateNormal];
    [party2Button setImage:[UIImage imageNamed:checked] forState:UIControlStateNormal];

}

- (IBAction)back1Clicked:(id)sender {
    [back1Button setImage:[UIImage imageNamed:checked] forState:UIControlStateNormal];
    [back2Button setImage:[UIImage imageNamed:unchecked] forState:UIControlStateNormal];

}

- (IBAction)back2Clicked:(id)sender {
    [back1Button setImage:[UIImage imageNamed:unchecked] forState:UIControlStateNormal];
    [back2Button setImage:[UIImage imageNamed:checked] forState:UIControlStateNormal];

}

- (IBAction)tpButton1Clicked:(UIButton *)sender {
    [tpButton1 setImage:[UIImage imageNamed:checked] forState:UIControlStateNormal];
    [tpButton2 setImage:[UIImage imageNamed:unchecked] forState:UIControlStateNormal];
    

}

- (IBAction)tpButton2Clicked:(UIButton *)sender {
    [tpButton1 setImage:[UIImage imageNamed:unchecked] forState:UIControlStateNormal];
    [tpButton2 setImage:[UIImage imageNamed:checked] forState:UIControlStateNormal];
    

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
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    currentTextField = nil;
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
            
        }
        else if (buttonIndex == 1) {
            EfilingTaxPaymentViewController *taxPayment = [[EfilingTaxPaymentViewController alloc]initWithNibName:@"EfilingTaxPaymentViewController" bundle:nil];
            
            [self.navigationController pushViewController:taxPayment animated:YES];
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

@end
