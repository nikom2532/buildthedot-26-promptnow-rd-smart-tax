//
//  MainViewController.m
//  RDSmartTax
//
//  Created by fone on 12/4/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "MainViewController.h"
#import "EfilingCheckNewUserViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    EfilingCheckNewUserViewController *vc = [[EfilingCheckNewUserViewController alloc]initWithNibName:@"EfilingCheckNewUserViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
