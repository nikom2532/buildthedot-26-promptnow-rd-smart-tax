//
//  TaxStep2ViewController.m
//  TaxEasy
//
//  Created by saritwat anutakonpatipan on 12/8/2556 BE.
//  Copyright (c) 2556 Tax. All rights reserved.
//

#import "TaxStep2ViewController.h"
#import "TextfieldObjectViewController.h"
#import "JLString.h"

#import "TaxStep3ViewController.h"
#define marginFooter 40
#define keyboardHeight 200

@interface TaxStep2ViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
{
    UITextField *currentTextField;
    UIView *detailView;
    NSMutableArray *filterTextField;
}
@end

@implementation TaxStep2ViewController
@synthesize formsArray;
@synthesize sharedData;
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
    JLLog(@"sharedData : %@",sharedData);
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
    JLLog(@"_formsArray step2 :%@",[formsArray objectAtIndex:1]);
    NSArray *formData = [[[[formsArray objectAtIndex:1] objectForKey:@"formData"]objectAtIndex:0] objectForKey:@"fields"];

    NSArray *tempdata = [formData valueForKeyPath:@"@distinctUnionOfObjects.type"];
    NSLog(@"tempdata : %@",tempdata);
    
    NSMutableArray *checkboxArray = [[NSMutableArray alloc]init];
    filterTextField = [[NSMutableArray alloc]init];
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
        
        
        textfieldVC.titleLabel.text = [JLString removeNullString:[dataDic objectForKey:@"label"]];
        [textfieldVC.inputTextField setDelegate:self];
        [textfieldVC.inputTextField setTag:countfilter];
        
        textfieldVC.identify = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"identify"]]];

        if ([[JLString removeNullString:[dataDic objectForKey:@"format"]]isEqualToString:@"decimal"]) {
            [textfieldVC.inputTextField setKeyboardType:UIKeyboardTypeDecimalPad];
        }
        if ([JLString removeNullString:[dataDic objectForKey:@"placeholder"]].length!=0) {
            [textfieldVC.inputTextField setPlaceholder:[JLString removeNullString:[dataDic objectForKey:@"placeholder"]]];
        }
        
        [checkboxArray addObject:textfieldVC.view];
    }
    
    detailView = [[UIView alloc]init];
    
    CGFloat keepHeight = 100;
    
    for (int count = 0; count < checkboxArray.count; count++) {
        UIView *view = [checkboxArray objectAtIndex:count];
        keepHeight = keepHeight + view.frame.size.height;
        [detailView setFrame:CGRectMake(0, 0,scrollView.frame.size.width, keepHeight)];//:CGSizeMake(scrollView.frame.size.width, keepHeight)];
        [detailView addSubview:view];
    }
    for (int countCheckbox = 0; countCheckbox < checkboxArray.count; countCheckbox++) {
    }
    
    //--Create Title Label
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 320, 50)];
    titleLabel.text = [JLString removeNullString:[[formsArray objectAtIndex:1]objectForKey:@"formName"]];
    
    
    CGRect checkboxFrame = detailView.frame;
    checkboxFrame.origin.y = titleLabel.frame.size.height;
    [detailView setFrame:checkboxFrame];
    
    [scrollView addSubview:titleLabel];
    [scrollView addSubview:detailView];

    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, detailView.frame.size.height+marginFooter)];
    
    CGFloat hContentSizeHeight = scrollView.contentSize.height;
    CGRect frameNextView = nextView.frame;
    frameNextView.origin.y = hContentSizeHeight-marginFooter;
    [nextView setFrame:frameNextView];
    [scrollView addSubview:nextView];

    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height+keyboardHeight)];


    //-- Add Tap Gesture -----------------------------------------------------
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    [detailView addGestureRecognizer:tapGesture];
}
- (IBAction)nextClicked:(id)sender {
    TaxStep3ViewController *tax3VC = [[TaxStep3ViewController alloc]initWithNibName:@"TaxStep3ViewController" bundle:nil];
    tax3VC.formsArray = formsArray;
    [self.navigationController pushViewController:tax3VC animated:YES];
}
#pragma mark - UISCROLLVIEW DELEGATE
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [currentTextField resignFirstResponder];
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
//     [scrollView scrollRectToVisible:CGRectMake(0, textField.frame.origin.y-30, scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    currentTextField = textField;

//    [scrollView setContentOffset:CGPointMake(0, textField.frame.size.height-50) animated:YES];
//    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height+keyboardHeight)];

    
//    float yTextPosition = 0;
//    float visibleHeight = scrollView.frame.origin.y+scrollView.frame.size.height;
//    
////    if([detailView.subviews containsObject:currentTextField])
////    {
////        JLLog(@"in 1");
//        yTextPosition = currentTextField.frame.origin.y;
////    }
//    
//    if(yTextPosition > visibleHeight)
//    {
//        JLLog(@"in 2");
//        
//        float scrollHeight = currentTextField.frame.size.height + (yTextPosition - visibleHeight);
//        [scrollView setContentOffset:CGPointMake(0, scrollHeight) animated:YES];
//    }

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    currentTextField = nil;
//    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height-keyboardHeight)];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    if(textField.tag == 8)//-- Telephone TextField
//    {
//        JLLog(@"intextfield %d",textField.tag);
//        
//        NSUInteger newLength = [textField.text length] + [string length] - range.length;
//        if(![JLRegular regularMobilenumber:string])
//        {
//            return NO;
//        }
//        return (newLength > 10)?NO:YES;
//        
//    }
    return YES;
}

@end
