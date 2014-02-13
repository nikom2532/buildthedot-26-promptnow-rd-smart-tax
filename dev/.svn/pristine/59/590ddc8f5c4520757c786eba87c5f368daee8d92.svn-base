//
//  TaxStep4ViewController.m
//  TaxEasy
//
//  Created by saritwat anutakonpatipan on 12/8/2556 BE.
//  Copyright (c) 2556 Tax. All rights reserved.
//

#import "TaxStep4ViewController.h"
#import "TaxStep5ViewController.h"
#import "TextfieldObjectViewController.h"
#import "JLString.h"
#import "FontUtil.h"
#define marginFooter 40
#define keyboardHeight 200

@interface TaxStep4ViewController ()<UIGestureRecognizerDelegate>
{
    UITextField *currentTextField;
    NSMutableArray *filterTextField;
    NSMutableArray *validateArray;

}
@end

@implementation TaxStep4ViewController
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
    self.title = @"ยื่นภาษี";
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"แก้ไข" style:UIBarButtonItemStyleBordered target:self action:@selector(rightButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    validateArray = [[NSMutableArray alloc]init];

    [self createdisplyData];
}
-(void)rightButtonClicked
{
    TaxStep4ViewController *tax4 = [[TaxStep4ViewController alloc]initWithNibName:@"TaxStep4ViewController" bundle:nil];
    [self.navigationController pushViewController:tax4 animated:YES];
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
}

- (void) setFontStyle {
    
    //    [self.labelTitle setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    //    [self.labelIdCard setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    //    [self.txtIdCard setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    //    [self.btnLogin.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
}
#pragma mark - Display Method
-(void)createdisplyData
{
    JLLog(@"_formsArray step2 :%@",[formsArray objectAtIndex:3]);
    NSArray *formData = [[[[formsArray objectAtIndex:3] objectForKey:@"formData"]objectAtIndex:0] objectForKey:@"fields"];
    
    NSArray *tempdata = [formData valueForKeyPath:@"@distinctUnionOfObjects.type"];
    NSLog(@"tempdata : %@",tempdata);
    
    NSMutableArray *checkboxArray = [[NSMutableArray alloc]init];
    filterTextField = [[NSMutableArray alloc]init];
    for (int countData = 0 ; countData < formData.count ; countData++)
    {
        NSDictionary *dataDic = [formData objectAtIndex:countData];
        
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"textfield"]) {
            BOOL checkCondition = [self checkvalidateConditionsinJSON:dataDic];
            
            if (checkCondition) {
                NSArray *condition = [dataDic objectForKey:@"conditions"];
                JLLog(@"condition : %@",[condition objectAtIndex:0]);
                if ([self validateConditionWithIdentify:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"identify" ]]
                                                Operate:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"operate" ]]
                                                 Values:[JLString removeNullString:[[[condition objectAtIndex:0]objectForKey:@"values" ] objectAtIndex:0]]]) {
                    
                    [filterTextField addObject:dataDic];
                    
                }
            }
            else
            {
                [filterTextField addObject:dataDic];
                
            }
        }
        
        
    }
    
    for (int countfilter = 0; countfilter < filterTextField.count; countfilter++) {
        NSDictionary *dataDic = [filterTextField objectAtIndex:countfilter];
        
        TextfieldObjectViewController *textfieldVC = [[TextfieldObjectViewController alloc]initWithNibName:@"TextfieldObjectViewController" bundle:nil];
        [textfieldVC.view setFrame:CGRectMake(0, textfieldVC.view.frame.size.height*countfilter, textfieldVC.view.frame.size.width, textfieldVC.view.frame.size.height)];

        
        textfieldVC.titleLabel.text = [JLString removeNullString:[JLString removeNullString:[dataDic objectForKey:@"label"]]];
        [textfieldVC.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
        
        [textfieldVC.inputTextField setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

        if ([[JLString removeNullString:[dataDic objectForKey:@"format"]]isEqualToString:@"decimal"]) {
            [textfieldVC.inputTextField setKeyboardType:UIKeyboardTypeDecimalPad];
        }
        if ([JLString removeNullString:[dataDic objectForKey:@"placeholder"]].length!=0) {
            [textfieldVC.inputTextField setPlaceholder:[JLString removeNullString:[dataDic objectForKey:@"placeholder"]]];
        }
        [self setTextFieldData:@"" Identify:[dataDic objectForKey:@"identify"]];

        BOOL checkValidate = [self checkvalidateValueinJSON:dataDic];
        NSLog(checkValidate?@"checkValidate YES":@" checkValidate NO");
        if (checkValidate == YES) {
            [validateArray addObject:@"YES"];
        }
        else if (checkValidate == NO)
        {
            [validateArray addObject:@"NO"];
            
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
    titleLabel.text = [JLString removeNullString:[[formsArray objectAtIndex:3]objectForKey:@"formName"]];
    [titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleNormal]];

    
    CGRect checkboxFrame = checkboxView.frame;
    checkboxFrame.origin.y = titleLabel.frame.size.height;
    [checkboxView setFrame:checkboxFrame];
    
    [scrollView addSubview:titleLabel];
    [scrollView addSubview:checkboxView];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, checkboxView.frame.size.height+marginFooter)];
    
    CGFloat hContentSizeHeight = scrollView.contentSize.height;
    CGRect frameNextView = nextView.frame;
    frameNextView.origin.y = hContentSizeHeight-marginFooter;
    [nextView setFrame:frameNextView];
    [scrollView addSubview:nextView];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height+keyboardHeight)];
    //-- Add Tap Gesture -----------------------------------------------------
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    [checkboxView addGestureRecognizer:tapGesture];
    
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
    NSDictionary *dataDic = [filterTextField objectAtIndex:textField.tag];
    
    if ([[JLString removeNullString:[validateArray objectAtIndex:textField.tag]]isEqualToString:@"YES"]) {
        NSArray *validateinData = [dataDic objectForKey:@"validate"];
        JLLog(@"validate count %d",validateinData.count);
        
        for (int cValidate = 0; cValidate < validateinData.count; cValidate++) {
            NSDictionary *dValidate =[validateinData objectAtIndex:cValidate];
            JLLog(@"validate :%d Message :  %@",cValidate,[dValidate objectForKey:@"message"]);
            [self setTextFieldData:textField.text Identify:[dataDic objectForKey:@"identify"]];
            
            if ([self validateWithMyData:textField.text
                              Myidentify:[JLString removeNullString:[dataDic objectForKey:@"identify"]]
                                 Operate:[JLString removeNullString:[dValidate objectForKey:@"operate"]]
                            AlertMessage:[JLString removeNullString:[dValidate objectForKey:@"message"]]
                                  Value1:[dValidate objectForKey:@"v1"]
                                  Value2:[dValidate objectForKey:@"v2"]])
            {
                
                return;
            }
            
        }
        //        [self validateWithMyData:textField.text Operate:<#(NSString *)#> AlertMessage:<#(NSString *)#> Value1:<#(NSString *)#> Value2:<#(NSString *)#>]
    }
    
    [self setTextFieldData:textField.text Identify:[dataDic objectForKey:@"identify"]];
    currentTextField = nil;

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
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
            }else if( [[TaxStep4ViewController numberFormatter] numberFromString:currentString].longLongValue >= 10000000 ){
                newString = currentString;
            }else{
                
                
                [currentString appendString:string];
                [currentString replaceOccurrencesOfString:[TaxStep4ViewController numberFormatter].groupingSeparator withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [currentString length])];
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
            return YES;
        }
        
        return NO;
        
    }
    else if ([eTxt.type isEqualToString:@"xxxxxxxxxxxxx"]) {
        if (range.location == 14) {
            return NO;
        }
        else
        {
            return YES;
        }
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
    NSNumber *currentValue = [[TaxStep4ViewController numberFormatter] numberFromString:numberStr];
    return [[TaxStep4ViewController numberFormatter] stringFromNumber:currentValue];
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
    return [TaxStep4ViewController numberFormatter];
}
#pragma mark - Calculate Method
-(BOOL)checkvalidateConditionsinJSON:(NSDictionary*)json
{
    NSString *str = [NSString stringWithFormat:@"%@",json];
    JLLog(@"str %@",str);
    if ([str rangeOfString:@"conditions"].location == NSNotFound) {
        return NO;
    }
    
    else
    {
        return YES;
    }
}
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
#pragma mark - Set Data
-(void)setTextFieldData:(NSString*)textFielddata Identify:(NSString*)identify
{
    [sharedData setObject:textFielddata forKey:identify];
}
#pragma mark - Validate
-(BOOL)validateConditionWithIdentify:(NSString*)cIdentify Operate:(NSString*)cOperate Values:(NSString*)cValues
{
    JLLog(@"cIdentify:%@ cOperate:%@ cValues:%@",cIdentify,cOperate,cValues);
    JLLog(@"cIdentify:%@ ",[[sharedData objectForKey:@"pickcheckbox"]objectForKey:cIdentify]);
    if ([cOperate isEqualToString:@"equal"]) {
        if ([cValues isEqualToString:@"1"]) {
            if ([[[sharedData objectForKey:@"pickcheckbox"]objectForKey:cIdentify]isEqualToString:@"CHECK"]) {
                return YES;
            }
        }
        else
        {
            if ([[[sharedData objectForKey:@"pickcheckbox"]objectForKey:cIdentify]isEqualToString:@"CHECK"]) {
                return NO;
            }
            else
            {
                return YES;
                
            }
        }
        
    }
    return NO;
}
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
                    NSDictionary *loopV2Dic = [v2Array objectAtIndex:0];
                    if ([mydata floatValue]>=[[JLString removeNullString:[sharedData objectForKey:[JLString removeNullString:[loopV2Dic objectForKey:@"identify"]]]]floatValue]) {
                        [self alertMessageWithMessage:alertmessage];
                        return YES;
                    }
                    
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
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}
- (IBAction)nextClicked:(id)sender {
    TaxStep5ViewController *tax5VC = [[TaxStep5ViewController alloc]initWithNibName:@"TaxStep5ViewController" bundle:nil];
//    tax4VC.formsArray = formsArray;
    [self.navigationController pushViewController:tax5VC animated:YES];
}
@end
