//
//  TaxStep4ViewController.m
//  TaxEasy
//
//  Created by saritwat anutakonpatipan on 12/8/2556 BE.
//  Copyright (c) 2556 Tax. All rights reserved.
//

#import "TaxStep4ViewController.h"

#import "TextfieldObjectViewController.h"
#import "JLString.h"

#define marginFooter 40
#define keyboardHeight 200

@interface TaxStep4ViewController ()

@end

@implementation TaxStep4ViewController
@synthesize formsArray;
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
    self.title = @"ยื่นภาษี";

    [self createdisplyData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Display Method
-(void)createdisplyData
{
    JLLog(@"_formsArray step2 :%@",[formsArray objectAtIndex:3]);
    NSArray *formData = [[[[formsArray objectAtIndex:3] objectForKey:@"formData"]objectAtIndex:0] objectForKey:@"fields"];
    
    NSArray *tempdata = [formData valueForKeyPath:@"@distinctUnionOfObjects.type"];
    NSLog(@"tempdata : %@",tempdata);
    
    NSMutableArray *checkboxArray = [[NSMutableArray alloc]init];
    NSMutableArray *filterTextField = [[NSMutableArray alloc]init];
    for (int countData = 0 ; countData < formData.count ; countData++)
    {
        NSDictionary *dataDic = [formData objectAtIndex:countData];
        
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"textfield"]) {
            [filterTextField addObject:dataDic];
        }
        
        
    }
    
    for (int countfilter = 0; countfilter < filterTextField.count; countfilter++) {
        NSDictionary *dataDic = [filterTextField objectAtIndex:countfilter];
        
        TextfieldObjectViewController *textfieldVC = [[TextfieldObjectViewController alloc]initWithNibName:@"TextfieldObjectViewController" bundle:nil];
        [textfieldVC.view setFrame:CGRectMake(0, textfieldVC.view.frame.size.height*countfilter, textfieldVC.view.frame.size.width, textfieldVC.view.frame.size.height)];

        
        textfieldVC.titleLabel.text = [JLString removeNullString:[JLString removeNullString:[dataDic objectForKey:@"label"]]];
        if ([[JLString removeNullString:[dataDic objectForKey:@"format"]]isEqualToString:@"decimal"]) {
            [textfieldVC.inputTextField setKeyboardType:UIKeyboardTypeDecimalPad];
        }
        if ([JLString removeNullString:[dataDic objectForKey:@"placeholder"]].length!=0) {
            [textfieldVC.inputTextField setPlaceholder:[JLString removeNullString:[dataDic objectForKey:@"placeholder"]]];
        }

        //        [textfieldVC.checkboxButton addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
        [checkboxArray addObject:textfieldVC.view];
    }
    
    UIView *checkboxView = [[UIView alloc]init];
    
    CGFloat keepHeight = 100;
    
    for (int count = 0; count < checkboxArray.count; count++) {
        UIView *view = [checkboxArray objectAtIndex:count];
        keepHeight = keepHeight + view.frame.size.height;
        [checkboxView setFrame:CGRectMake(0, 0,scrollView.frame.size.width, keepHeight)];//:CGSizeMake(scrollView.frame.size.width, keepHeight)];
        [checkboxView addSubview:view];
    }
    for (int countCheckbox = 0; countCheckbox < checkboxArray.count; countCheckbox++) {
    }
    
    //--Create Title Label
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 320, 50)];
    titleLabel.text = [JLString removeNullString:[[formsArray objectAtIndex:1]objectForKey:@"formName"]];
    
    
    CGRect checkboxFrame = checkboxView.frame;
    checkboxFrame.origin.y = titleLabel.frame.size.height;
    [checkboxView setFrame:checkboxFrame];
    
    [scrollView addSubview:titleLabel];
    [scrollView addSubview:checkboxView];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, checkboxView.frame.size.height+marginFooter+keyboardHeight)];
    
    CGFloat hContentSizeHeight = scrollView.contentSize.height;
    CGRect frameNextView = nextView.frame;
    frameNextView.origin.y = hContentSizeHeight-marginFooter;
    [nextView setFrame:frameNextView];
    [scrollView addSubview:nextView];
    
}
- (IBAction)nextClicked:(id)sender {
//    TaxStep4ViewController *tax4VC = [[TaxStep4ViewController alloc]initWithNibName:@"TaxStep4ViewController" bundle:nil];
//    tax4VC.formsArray = formsArray;
//    [self.navigationController pushViewController:tax4VC animated:YES];
}
@end
