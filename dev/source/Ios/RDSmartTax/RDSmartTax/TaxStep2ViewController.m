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
#import "TaxStep5ViewController.h"
#import "FontUtil.h"
#import "EtextField.h"
#import "TextFormatterUtil.h"
#define marginFooter 40
#define keyboardHeight 200

@interface TaxStep2ViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
{
    UITextField *currentTextField;
    UIView *detailView;
    NSMutableArray *filterTextField;
    NSMutableArray *validateArray;

    BOOL isChangeTextField;
    
     NSString *ok;
    TaxStep3ViewController *tax3VC;
    
    NSMutableArray *arrayETextField;
    
    CGFloat screenHeight;

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
    isChangeTextField = YES;
    validateArray = [[NSMutableArray alloc]init];
    arrayETextField = [[NSMutableArray alloc]init];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenHeight = screenRect.size.height;
    
    [self createdisplyData];
    [self setLanguage];
    [self setFontStyle];
    [self createHeaderInview];
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
#pragma - Decorate Label
- (void) setLanguage {
    [nextButton setTitle:[Util stringWithScreenName:@"Common" labelName:@"Next"] forState:UIControlStateNormal];
    ok = [Util stringWithScreenName:@"Common" labelName:@"Ok"];

    //    [self.titlesetText:[Util stringWithScreenName:@"Login" labelName:@"EfilingTitle"]];
    //    [self.labelIdCard setText:[Util stringWithScreenName:@"Login" labelName:@"Nid"]];
    //    [self.btnLogin setTitle:[Util stringWithScreenName:@"Login" labelName:@"Title"] forState:UIControlStateNormal];
}

- (void) setFontStyle {
    [nextButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    //    [self.labelTitle setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    //    [self.labelIdCard setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    //    [self.txtIdCard setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    //    [self.btnLogin.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
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
        [textfieldVC.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
        [textfieldVC.inputTextField setDelegate:self];
        [textfieldVC.inputTextField setTag:countfilter];
        [textfieldVC.inputTextField setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
        textfieldVC.identify = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"identify"]]];
        
        textfieldVC.inputTextField.identify = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"identify"]]];
        textfieldVC.inputTextField.type = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"format"]]];
        
        if ([[JLString removeNullString:[dataDic objectForKey:@"format"]]isEqualToString:@"decimal"]) {
            [textfieldVC.inputTextField setKeyboardType:UIKeyboardTypeDecimalPad];
            [textfieldVC.inputTextField setTextAlignment:NSTextAlignmentRight];
        }
        else if ([[JLString removeNullString:[dataDic objectForKey:@"format"]]isEqualToString:@"xxxxxxxxxxxxx"]) {
            [textfieldVC.inputTextField setKeyboardType:UIKeyboardTypeNumberPad];
        }
        [textfieldVC.inputTextField setTextAlignment:NSTextAlignmentRight];

        [arrayETextField addObject:textfieldVC.inputTextField];
        
//        [sharedData setObject:textFielddata forKey:identify];
        textfieldVC.inputTextField.text = [JLString removeNullString:[sharedData objectForKey:[dataDic objectForKey:@"identify"]]];
        
        if ([textfieldVC.inputTextField.text isEqualToString:@""]) {
            [self setTextFieldData:@"" Identify:[dataDic objectForKey:@"identify"]];
        }
        
        if ([JLString removeNullString:[dataDic objectForKey:@"placeholder"]].length!=0) {
            [textfieldVC.inputTextField setPlaceholder:[JLString removeNullString:[dataDic objectForKey:@"placeholder"]]];
        }
        
        
        BOOL checkValidate = [self checkvalidateValueinJSON:dataDic];
        NSLog(checkValidate?@"checkValidate YES":@" checkValidate NO");
        if (checkValidate == YES) {
            [validateArray addObject:@"YES"];
        }
        else if (checkValidate == NO)
        {
            [validateArray addObject:@"NO"];
            
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
//    for (int countCheckbox = 0; countCheckbox < checkboxArray.count; countCheckbox++) {
//    }
    
    //--Create Title Label
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 320, 32)];
//    titleLabel.text = [JLString removeNullString:[[formsArray objectAtIndex:1]objectForKey:@"formName"]];
//    [titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
//    [titleLabel setBackgroundColor:[UIColor whiteColor]];
    
    headerLabel.text = [JLString removeNullString:[[formsArray objectAtIndex:1]objectForKey:@"formName"]];
    [headerLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];

    subheaderLabel.text = [JLString removeNullString:[[formsArray objectAtIndex:1]objectForKey:@"formName"]];
    [subheaderLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
//    CGRect checkboxFrame = detailView.frame;
//    checkboxFrame.origin.y = titleLabel.frame.size.height;
//    [detailView setFrame:checkboxFrame];
    
//    [scrollView addSubview:titleLabel];
    [scrollView addSubview:detailView];

    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, detailView.frame.size.height+marginFooter)];
    
    CGFloat hContentSizeHeight = scrollView.contentSize.height;
    CGRect frameNextView = nextView.frame;
    CGRect frameHeader = headerLabel.frame;
    frameNextView.origin.y = hContentSizeHeight;

    if (frameNextView.origin.y<screenHeight) {
        frameNextView.origin.y = scrollView.frame.size.height - frameNextView.size.height - frameHeader.size.height;
    }
    else
    {
        frameNextView.origin.y = hContentSizeHeight-marginFooter;

    }
    
    [nextView setFrame:frameNextView];
    [scrollView addSubview:nextView];

    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height+keyboardHeight)];


    //-- Add Tap Gesture -----------------------------------------------------
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    [detailView addGestureRecognizer:tapGesture];
}
#pragma mark - Calculate Method
-(BOOL)checkvalidateValueinJSON:(NSDictionary*)json
{
    NSString *str = [NSString stringWithFormat:@"%@",json];
    JLLog(@"str %@",str);
    if ([str rangeOfString:@"validate"].location == NSNotFound) {
        return NO;
    }
    
    else
    {
        return YES;
    }
}
#pragma mark - Action
- (IBAction)nextClicked:(id)sender {
    [currentTextField resignFirstResponder];
  
    
    for (int cTextField = 0; cTextField < filterTextField.count; cTextField++) {
        NSDictionary *dataDic = [filterTextField objectAtIndex:cTextField];
        
        if ([[JLString removeNullString:[validateArray objectAtIndex:cTextField]]isEqualToString:@"YES"]) {
            NSArray *validateinData = [dataDic objectForKey:@"validate"];
            JLLog(@"validate count %d",validateinData.count);
            
            for (int cValidate = 0; cValidate < validateinData.count; cValidate++) {
                NSDictionary *dValidate =[validateinData objectAtIndex:cValidate];
                JLLog(@"validate :%d Message :  %@",cValidate,[dValidate objectForKey:@"message"]);
//                [sharedData setObject:textFielddata forKey:identify];

                if ([self validateWithMyData:[JLString removeNullString:[sharedData objectForKey:[JLString removeNullString:[dataDic objectForKey:@"identify"]]]]
                                  Myidentify:[JLString removeNullString:[dataDic objectForKey:@"identify"]]
                                     Operate:[JLString removeNullString:[dValidate objectForKey:@"operate"]]
                                AlertMessage:[JLString removeNullString:[dValidate objectForKey:@"message"]]
                                      Value1:[dValidate objectForKey:@"v1"]
                                      Value2:[dValidate objectForKey:@"v2"]])
                {
                    EtextField *tempEText = [arrayETextField objectAtIndex:cValidate];
                    [tempEText becomeFirstResponder];
                    return;
                }
                
            }
        }

    }
    if ([[JLString removeNullString:[sharedData objectForKey:@"countcheck"]]isEqualToString:@"0"]) {
        TaxStep5ViewController *tax5VC = [[TaxStep5ViewController alloc]initWithNibName:@"TaxStep5ViewController"bundle:nil];// bundle:<#(NSBundle *)#>
        tax5VC.formsArray = formsArray;
        tax5VC.sharedData = sharedData;
        [self.navigationController pushViewController:tax5VC animated:YES];
        return;
    }
    JLLog(@"sharedData:%@",sharedData);
//    if (!tax3VC) {
//        tax3VC = [[TaxStep3ViewController alloc]initWithNibName:@"TaxStep3ViewController" bundle:nil];
//        tax3VC.formsArray = formsArray;
//        tax3VC.sharedData = sharedData;
//    }
    TaxStep3ViewController *tax3 = [[TaxStep3ViewController alloc]initWithNibName:@"TaxStep3ViewController" bundle:nil];
    tax3.formsArray = formsArray;
    tax3.sharedData = sharedData;
    [self.navigationController pushViewController:tax3 animated:YES];
}
#pragma mark - UISCROLLVIEW DELEGATE
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [currentTextField resignFirstResponder];
}

#pragma mark - UITEXTFIELD DELEGATE
-(void)hideKeyboard
{
    if(currentTextField)  {
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
    if (isChangeTextField == YES) {
        currentTextField = textField;
    }

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSDictionary *dataDic = [filterTextField objectAtIndex:textField.tag];
    EtextField *eTxt = (EtextField*)textField;
    if ([eTxt.type isEqualToString:@"decimal"]) {

       textField.text = [TextFormatterUtil formatAmount:eTxt.text];
    }
    
    [self setTextFieldData:[textField.text stringByReplacingOccurrencesOfString:@"," withString:@""] Identify:[dataDic objectForKey:@"identify"]];
    currentTextField = nil;


}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (currentTextField) {
        [currentTextField resignFirstResponder];
        
    }
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    EtextField *eTxt = (EtextField*)textField;
    if ([eTxt.type isEqualToString:@"decimal"]) {
        
        NSMutableString* currentString = [NSMutableString stringWithString:textField.text];
        NSString* newString;
        
        if([currentString rangeOfString:@"."].location == NSNotFound )
        {
            if([string isEqualToString:@"."]){
                newString = [currentString stringByAppendingString:string];
            }else if( [[TaxStep2ViewController numberFormatter] numberFromString:currentString].longLongValue >= 10000000 ){
                newString = currentString;
            }else{
                
                
                [currentString appendString:string];
                [currentString replaceOccurrencesOfString:[TaxStep2ViewController numberFormatter].groupingSeparator withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [currentString length])];
                newString = [self reformatNumber:currentString];
            }
            
        }
        
        else{
            if (([[[currentString componentsSeparatedByString:@"."] lastObject] length] >= 2) || [string isEqualToString:@"."]){
                newString = currentString;
            }else if([string isEqualToString:@"0"]){
                [currentString appendString:string];
                newString = currentString;
            }else{
                [currentString appendString:string];
                newString = [self reformatNumber:currentString];
            }
            
        }
        
        if(newString.length <= 20){
            [textField setText:newString];
            
            //            [eTxt setText:newString];
            NSLog(@"currentString : %@",textField.text);
        }
        if ([string isEqualToString:@""]) {
            NSString *removeString = [textField.text substringToIndex:[textField.text length]-1];
        
            newString = [self reformatNumber:[removeString stringByReplacingOccurrencesOfString:@"," withString:@""]];
            [textField setText:newString];

//            return YES;
           
        }
        
        return NO;
        
    }
    else if ([eTxt.type isEqualToString:@"xxxxxxxxxxxxx"]) {
//        if (range.location == 14) {
//            return NO;
//        }
//        else
//        {
//            return YES;
//        }
        JLLog(@"%@",string);

//        if (range.location == 14) {
//            return NO;
//        }
        
        if ([string length] == 0) {
            return YES;
        }
        
        if ((range.location == 1) || (range.location == 6) || (range.location == 12 || (range.location == 15))) {
            NSString *str    = [NSString stringWithFormat:@"%@-",textField.text];
            textField.text   = str;
        }
        return YES;
    }
    else if ([eTxt.type isEqualToString:@"x-xxxx-xxxxx-xxx"]) {
        if (range.location == 17) {
            return NO;
        }
        
        if ([string length] == 0) {
            return YES;
        }
        
        if ((range.location == 1) || (range.location == 6) || (range.location == 12 || (range.location == 15)))
        {
            NSString *str    = [NSString stringWithFormat:@"%@-",textField.text];
            textField.text   = str;
        }
        return YES;
    }
    else
    {
        return YES;
    }
//    [textField isKindOfClass:[EtextField class]];
//    
//    textField.id
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
    return NO;
}
#pragma mark - Money method
+(NSString*)addFormatPrice:(double)dblPrice {
    NSNumber *temp = [NSNumber numberWithDouble:dblPrice];
    NSDecimalNumber *someAmount = [NSDecimalNumber decimalNumberWithDecimal:
                                   [temp decimalValue]];
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    return [currencyFormatter stringFromNumber:someAmount];
}

+(double)removeFormatPrice:(NSString *)strPrice {
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber* number = [currencyFormatter numberFromString:strPrice];
    return [number doubleValue];
}

-(NSString*) reformatNumber:(NSString*) numberStr
{
    NSNumber *currentValue = [[TaxStep2ViewController numberFormatter] numberFromString:numberStr];
    return [[TaxStep2ViewController numberFormatter] stringFromNumber:currentValue];
}

static NSNumberFormatter* numberFormatter;
+(NSNumberFormatter*) numberFormatter
{
    if( numberFormatter == nil){
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setMaximumFractionDigits:2];
        [numberFormatter setMinimumFractionDigits:0];
        [numberFormatter setMinimumIntegerDigits:1];
        [numberFormatter setGroupingSeparator:@","];
        [numberFormatter setAllowsFloats:YES];
    }
    return numberFormatter;
}
-(NSNumberFormatter*) getNumberFormatter
{
    return [TaxStep2ViewController numberFormatter];
}
#pragma mark - Set Data
-(void)setTextFieldData:(NSString*)textFielddata Identify:(NSString*)identify
{
    [sharedData setObject:textFielddata forKey:identify];
}
#pragma mark - Validate
-(BOOL)validateWithMyData:(NSString*)mydata Myidentify:(NSString*)myidentify Operate:(NSString*)operate AlertMessage:(NSString*)alertmessage Value1:(NSDictionary*)v1 Value2:(NSDictionary*)v2
{
    JLLog(@"mydata : %@ ||myidentify:%@ ||Operate :%@|| ",mydata,myidentify, operate);
    NSArray *v1Array = [v1 objectForKey:@"summary"];
    NSArray *v2Array = [v2 objectForKey:@"summary"];
    JLLog(@"inloopBegin %@",myidentify);

    if ([operate isEqualToString:@"not_null"]) {
        if (mydata.length == 0) {

            [self alertMessageWithMessage:alertmessage];
            return YES;
        }
    }
    else if ([operate isEqualToString:@">="]) {

        for (int loopV1 = 0; loopV1 < v1Array.count ; loopV1++) {

            NSDictionary *loopV1Dic = [v1Array objectAtIndex:loopV1];

            if ([[JLString removeNullString:[loopV1Dic objectForKey:@"identify"]]isEqualToString:myidentify]) {

                if ([[JLString removeNullString:[loopV1Dic objectForKey:@"value"]]isEqualToString:@"+"]) {

                     NSDictionary *loopV2Dic = [v2Array objectAtIndex:0];
                    if ([mydata floatValue]>=[[JLString removeNullString:[loopV2Dic objectForKey:@"value"]]floatValue])  {

                    }
                    else
                    {

                        [self alertMessageWithMessage:alertmessage];
                        return YES;
                    }
                }
                
            }
            
            else
            {
                 if ([[JLString removeNullString:[loopV1Dic objectForKey:@"value"]]isEqualToString:@"+"]) {
                     
                 }
                else
                {
                    
                }
            }
        }
//        for (int loopV2 = 0; loopV2 < v2Array.count ; loopV2++) {
//            
//            NSDictionary *loopV2Dic = [v2Array objectAtIndex:loopV2];
//            
//        }
    }
    else if ([operate isEqualToString:@"<="]) {
        for (int loopV1 = 0; loopV1 < v1Array.count ; loopV1++) {
            
            NSDictionary *loopV1Dic = [v1Array objectAtIndex:loopV1];
            if ([[JLString removeNullString:[loopV1Dic objectForKey:@"identify"]]isEqualToString:myidentify]) {
                
                if ([[JLString removeNullString:[loopV1Dic objectForKey:@"value"]]isEqualToString:@"+"]) {
                    
                    if ([mydata floatValue]>0)  {
                        
                        NSDictionary *loopV2Dic = [v2Array objectAtIndex:0];
                        if ([mydata floatValue]<=[[JLString removeNullString:[sharedData objectForKey:[JLString removeNullString:[loopV2Dic objectForKey:@"identify"]]]]floatValue]) {
                            

                        }
                        else if (![mydata floatValue]<=[[JLString removeNullString:[sharedData objectForKey:[JLString removeNullString:[loopV2Dic objectForKey:@"identify"]]]]floatValue])
                        {
                            [self alertMessageWithMessage:alertmessage];
                            return YES;
                        }
                    }
                    else
                    {
                        [self alertMessageWithMessage:alertmessage];
                        return YES;

                    }
                }
                
            }
            
            else
            {
                
            }
        }
        
    }
    else if ([operate isEqualToString:@"chkPin"]) {
        
    }
   
    return NO;
}
#pragma mark - ALERT MESSAGE
-(void)alertMessageWithMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:self cancelButtonTitle:ok otherButtonTitles: nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
//        [currentTextField becomeFirstResponder];
//        isChangeTextField = NO;
    }
}
@end
