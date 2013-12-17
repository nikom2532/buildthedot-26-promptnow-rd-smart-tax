//
//  EfilingHomeViewController.m
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingHomeViewController.h"
#import "EfilingUserProfileViewController.h"
#import "EfilingPrintMenuViewController.h"
#import "TaxStep1ViewController.h"
#import "ShareUserDetail.h"
#import "Util.h"

@interface EfilingHomeViewController () {
    
}

@end

@implementation EfilingHomeViewController

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
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnProfile:(id)sender {
    EfilingUserProfileViewController *vc = [[EfilingUserProfileViewController alloc]initWithNibName:@"EfilingUserProfileViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)btnEfiling:(id)sender {
    TaxStep1ViewController *tax = [[TaxStep1ViewController alloc]initWithNibName:@"TaxStep1ViewController" bundle:nil];
    [self.navigationController pushViewController:tax animated:YES];

}

- (IBAction)btnLogout:(id)sender {
    [self alertYesNoWithTitle:@"" detail:[Util stringWithScreenName:@"Logout" labelName:@"Title"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"] no:[Util stringWithScreenName:@"Common" labelName:@"No"]];
}

- (IBAction)btnPrint:(id)sender {
    EfilingPrintMenuViewController *print = [[EfilingPrintMenuViewController alloc]initWithNibName:@"EfilingPrintMenuViewController" bundle:nil];
    [self.navigationController pushViewController:print animated:YES];
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
        [ShareUserDetail resetData];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } else if (buttonIndex == 1){
        return;
    }
}

@end
