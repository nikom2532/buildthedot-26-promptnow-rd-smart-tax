//
//  EfilingRatingViewController.m
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 12/22/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingRatingViewController.h"
#import "EfilingHomeViewController.h"
#import "EfilingTaxPaymentViewController.h"
#import "FontUtil.h"
@interface EfilingRatingViewController ()<UIAlertViewDelegate>
{
    UIButton *currentButton;
    BOOL isVote;
    NSString *ok;
}
@end

@implementation EfilingRatingViewController

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
//    self.title = @"แสดงความพึงพอใจ";
    isVote = YES;
    self.header.pLeftButton.hidden = YES;
    [self setLanguage];
    [self setFontStyle];
    [self createHeaderInview];
}
- (void) createHeaderInview
{
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.text = @"แสดงความพึงพอใจ";
    [self.header.pLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    
}
#pragma - Decorate Label
- (void) setLanguage {
    //    [self.titlesetText:[Util stringWithScreenName:@"Login" labelName:@"EfilingTitle"]];
    //    [self.labelIdCard setText:[Util stringWithScreenName:@"Login" labelName:@"Nid"]];
    //    [self.btnLogin setTitle:[Util stringWithScreenName:@"Login" labelName:@"Title"] forState:UIControlStateNormal];
    ok = [Util stringWithScreenName:@"Common" labelName:@"Ok"];
//    cancel = [Util stringWithScreenName:@"Common" labelName:@"Cancel"];
    
}
- (void) setFontStyle {
    
    [headerLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [statusLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)voteClicked:(UIButton *)sender {
    isVote = YES;
    if (currentButton == nil) {
        [sender setBackgroundColor:[UIColor purpleColor]];
        currentButton = sender;
        
    }
    else
    {
        if (sender == currentButton) {
            
        }
        else
        {
            [currentButton setBackgroundColor:[UIColor lightGrayColor]];
            [sender setBackgroundColor:[UIColor purpleColor]];
            currentButton = sender;
        }
    }
}

- (IBAction)sliderChange:(UISlider *)sender {
    switch ([[NSString stringWithFormat:@"%f",sender.value] intValue]) {
        case 0:
        {
//            _distance = @"-500";
            [sender setValue:0];
            statusLabel.text = @"น้อยที่สุด";
        }
            break;
            
        case 1:
        {
//            _distance = @"-250";
            [sender setValue:1];

            statusLabel.text = @"น้อย";
        }
            break;
            
        case 2:
        {
//            _distance = @"0";
            [sender setValue:2];

            statusLabel.text = @"ปานกลาง";
        }
            break;
            
        case 3:
        {
//            _distance = @"250";
            [sender setValue:3];

            statusLabel.text = @"พอใจ";
        }
            break;
            
        case 4:
        {
//            _distance = @"500";
            [sender setValue:4];

            statusLabel.text = @"พอใจมาก";
        }
            break;
            
        default:
            break;
    }

}


- (IBAction)sendDataClicked:(id)sender {
    if (isVote == YES) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"ขอบคุณที่แสดงความพึงพอใจต่อ RD Smart Tax" delegate:self cancelButtonTitle:ok otherButtonTitles: nil];
        [alert show];
        [alert setTag:1];
    }
    else if (isVote == NO) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"กรุณาแสดงความพึงพอใจต่อ RD Smart Tax" delegate:self cancelButtonTitle:ok otherButtonTitles: nil];
        [alert show];
        [alert setTag:0];
    }
}
#pragma mark - UIALERTVIEW DELEGATE
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    EfilingTaxPaymentViewController *payment = [[EfilingTaxPaymentViewController alloc]initWithNibName:@"EfilingTaxPaymentViewController" bundle:nil];
//    [self.navigationController pushViewController:payment animated:YES];
    if (alertView.tag == 1) {
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
@end
