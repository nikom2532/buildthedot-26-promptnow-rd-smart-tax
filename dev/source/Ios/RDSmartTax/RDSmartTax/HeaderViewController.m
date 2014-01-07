//
//  HeaderViewController.m
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/1/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import "HeaderViewController.h"
#import "FontUtil.h"
@interface HeaderViewController ()

@end

@implementation HeaderViewController
@synthesize header;
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
    // Do any additional setup after loading the view from its nib.
//    Header *header = [Util loadViewWithNibName:@"Header"];
//    header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
//    header.pImage.image = [UIImage imageNamed:@"icon_efiling.png"];
//    header.pLabel.hidden = YES;
//    header.pLeftButton.hidden = YES;
//    [header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [header addSubview:header];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_grey.png"]];
    
    [self createHeader];
}
- (void) createHeader
{
    header = [Util loadViewWithNibName:@"Header"];
    if(OSVersionIsAtLeastiOS7)
    {
        
    }
    else
    {
        CGRect headerFrame = header.frame;
        headerFrame.origin.y = -20;
        headerFrame.size.height = headerFrame.size.height - 20;
        [header setFrame:headerFrame];
        
    }
    header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    header.pImage.image = [UIImage imageNamed:@"icon_efiling.png"];
    header.pLabel.hidden = YES;
    header.pLeftButton.hidden = NO;
    [header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    header.pRightButton.hidden = YES;
    
    [header.pRightButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleBold]];


    
    [self.view addSubview:header];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)onBackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
