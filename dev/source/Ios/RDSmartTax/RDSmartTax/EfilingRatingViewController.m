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
@interface EfilingRatingViewController ()<UIAlertViewDelegate>
{
    UIButton *currentButton;
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
    self.title = @"แสดงความพึงพอใจ";
    
    self.header.pLeftButton.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)voteClicked:(UIButton *)sender {
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

- (IBAction)sendDataClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"ขอบคุณที่แสดงความพึงพอใจต่อ RD Smart Tax" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}
#pragma mark - UIALERTVIEW DELEGATE
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    EfilingTaxPaymentViewController *payment = [[EfilingTaxPaymentViewController alloc]initWithNibName:@"EfilingTaxPaymentViewController" bundle:nil];
//    [self.navigationController pushViewController:payment animated:YES];
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
@end
