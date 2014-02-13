//
//  TaxStep3ViewController.m
//  TaxEasy
//
//  Created by saritwat anutakonpatipan on 12/8/2556 BE.
//  Copyright (c) 2556 Tax. All rights reserved.
//

#import "TaxStep3ViewController.h"

#import "JLString.h"
#import "TextfieldObjectViewController.h"
#import "StaticObjectViewController.h"
#import "TaxStep5ViewController.h"
#import "ShareUserDetail.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#define marginFooter 40
#define keyboardHeight 200
@interface TaxStep3ViewController ()
{
    UITextField *currentTextField;
    
    NSMutableArray *validateArray;
    NSMutableArray *filterTextField;
    NSMutableArray *filterStatic;
    NSMutableArray *filterStaticNotHide;

    NSMutableArray *formData;
    
    NSString *ok;

    NSMutableArray *arrayETextField;

     CGFloat screenHeight;
}
@end

@implementation TaxStep3ViewController
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
    
    
    JLLog(@"sharedData step3 : %@",sharedData);
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

-(void)rightButtonClicked
{
    
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
    formData = [[NSMutableArray alloc]init];
    [formData addObjectsFromArray:[[[[formsArray objectAtIndex:2] objectForKey:@"formData"]objectAtIndex:0] objectForKey:@"fields"]];
    [formData addObjectsFromArray:[[[[formsArray objectAtIndex:3] objectForKey:@"formData"]objectAtIndex:0] objectForKey:@"fields"]];

//    NSArray *tempdata = [formData valueForKeyPath:@"@distinctUnionOfObjects.type"];
//    NSLog(@"tempdata : %@",tempdata);
//    JLLog(@"_formsArray step3 :%@",formData);

    NSMutableArray *formData2 = [[NSMutableArray alloc]init];
    [formData2 addObjectsFromArray:[[[[formsArray objectAtIndex:2] objectForKey:@"formData"]objectAtIndex:0] objectForKey:@"fields"]];
    NSMutableArray *tempformData2 = [[NSMutableArray alloc]init];
    
    // -- Get Object For Create Header
    for (int countData = 0 ; countData < formData2.count ; countData++)
    {
        NSDictionary *dataDic = [formData2 objectAtIndex:countData];
        
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"textfield"]) {
            
            BOOL checkCondition = [self checkvalidateConditionsinJSON:dataDic];
            
            if (checkCondition) {
                NSArray *condition = [dataDic objectForKey:@"conditions"];
                JLLog(@"condition : %@",[condition objectAtIndex:0]);
                if ([self validateConditionWithIdentify:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"identify" ]]
                                                Operate:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"operate" ]]
                                                 Values:[JLString removeNullString:[[[condition objectAtIndex:0]objectForKey:@"values" ] objectAtIndex:0]]]) {
                    
                    [tempformData2 addObject:dataDic];
                    
                }
            }
            else
            {
                [tempformData2 addObject:dataDic];
                
            }
        }

    }
    
    NSMutableArray *checkboxArray = [[NSMutableArray alloc]init];
    filterTextField = [[NSMutableArray alloc]init];
    filterStatic = [[NSMutableArray alloc]init];
    filterStaticNotHide = [[NSMutableArray alloc]init];
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
                    
//                    [filterTextField addObject:dataDic];

                }
            }
            else
            {
//                [filterTextField addObject:dataDic];

            }
        }
       
        
        else if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"static"]) {
            
            if ([[JLString removeNullString:[dataDic objectForKey:@"hidden"]]isEqualToString:@""]) {
                JLLog(@"hidden####### :%@",dataDic);
                BOOL checkCondition = [self checkvalidateConditionsinJSON:dataDic];
                
                if (checkCondition) {
                    NSArray *condition = [dataDic objectForKey:@"conditions"];
                    JLLog(@"condition : %@",[condition objectAtIndex:0]);
                    
                    NSLog([self validateConditionStaticWithIdentify:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"identify"]] Operate:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"operate"]] Values:[[condition objectAtIndex:0]objectForKey:@"values"]]? @"#YES":@"#NO");
                    if ([self validateConditionStaticWithIdentify:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"identify"]] Operate:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"operate"]] Values:[[condition objectAtIndex:0]objectForKey:@"values"]]){
                        
//                        [filterStaticNotHide addObject:dataDic];
                        
                    }
                    
                }
                else
                {
//                    [filterStaticNotHide addObject:dataDic];
                }

            }
            
            else if ([[JLString removeNullString:[dataDic objectForKey:@"hidden"]]isEqualToString:@"1"]) {
                BOOL checkCondition = [self checkvalidateConditionsinJSON:dataDic];
                
                if (checkCondition) {
                    NSArray *condition = [dataDic objectForKey:@"conditions"];
                    JLLog(@"condition : %@",[condition objectAtIndex:0]);
                    if ([self validateConditionStaticWithIdentify:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"identify"]] Operate:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"operate"]] Values:[[condition objectAtIndex:0]objectForKey:@"values"]]){
                        
                        [filterStatic addObject:dataDic];
                        
                    }
                    
                }
                else
                {
                    [filterStatic addObject:dataDic];
                }
                
            }

            //            [filterStatic addObject:dataDic];
        }
        
    }
    JLLog(@"_formsArray step3 :%@",filterStaticNotHide);
    
    UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];

    for (int cFormData = 0 ; cFormData < formData.count ; cFormData++)
    {
        NSDictionary *dataDic = [formData objectAtIndex:cFormData];
        CGFloat keepHeight = 0;
        UIView *currentview ;
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"textfield"]) {
            
            BOOL checkCondition = [self checkvalidateConditionsinJSON:dataDic];
            
            if (checkCondition) {
                NSArray *condition = [dataDic objectForKey:@"conditions"];
                JLLog(@"condition : %@",[condition objectAtIndex:0]);
                if ([self validateConditionWithIdentify:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"identify" ]]
                                                Operate:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"operate" ]]
                                                 Values:[JLString removeNullString:[[[condition objectAtIndex:0]objectForKey:@"values" ] objectAtIndex:0]]]) {
                    
                    //add view
//                    if (countfilter >= tempformData2.count) {
//                        [textfieldVC.view setFrame:CGRectMake(0, (textfieldVC.view.frame.size.height*countfilter)+50, textfieldVC.view.frame.size.width, textfieldVC.view.frame.size.height)];
//                        
//                    }
//                    else
//                    {
//                        [textfieldVC.view setFrame:CGRectMake(0, textfieldVC.view.frame.size.height*countfilter, textfieldVC.view.frame.size.width, textfieldVC.view.frame.size.height)];
//                        
//                    }
//                    
                    TextfieldObjectViewController *textfieldVC = [[TextfieldObjectViewController alloc]initWithNibName:@"TextfieldObjectViewController" bundle:nil];
                    [textfieldVC.view setFrame:CGRectMake(0, detailView.frame.size.height, textfieldVC.view.frame.size.width, textfieldVC.view.frame.size.height)];

                    textfieldVC.titleLabel.text = [JLString removeNullString:[dataDic objectForKey:@"label"]];
                    [textfieldVC.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
                    [textfieldVC.inputTextField setDelegate:self];
                    [textfieldVC.inputTextField setTag:cFormData];
                    [textfieldVC.inputTextField setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    textfieldVC.inputTextField.type = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"format"]]];
                    
                    if ([[JLString removeNullString:[dataDic objectForKey:@"format"]]isEqualToString:@"decimal"]) {
                        [textfieldVC.inputTextField setKeyboardType:UIKeyboardTypeDecimalPad];
                        [textfieldVC.inputTextField setTextAlignment:NSTextAlignmentRight];

                    }
                    if ([JLString removeNullString:[dataDic objectForKey:@"placeholder"]].length!=0) {
                        [textfieldVC.inputTextField setPlaceholder:[JLString removeNullString:[dataDic objectForKey:@"placeholder"]]];
                    }
                    textfieldVC.inputTextField.text = [JLString removeNullString:[sharedData objectForKey:[dataDic objectForKey:@"identify"]]];
                    
                    if ([textfieldVC.inputTextField.text isEqualToString:@""]) {
                        [self setTextFieldData:@"" Identify:[dataDic objectForKey:@"identify"]];
                    }
                    [arrayETextField addObject:textfieldVC.inputTextField];

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
                    [textfieldVC.view setBackgroundColor:[UIColor clearColor]];
                    
                    keepHeight = textfieldVC.view.frame.size.height;

                    [checkboxArray addObject:textfieldVC.view];
                    currentview = textfieldVC.view;
                    [filterTextField addObject:dataDic];

                }
            }
            else
            {
                //add view
                TextfieldObjectViewController *textfieldVC = [[TextfieldObjectViewController alloc]initWithNibName:@"TextfieldObjectViewController" bundle:nil];
                [textfieldVC.view setFrame:CGRectMake(0, detailView.frame.size.height, textfieldVC.view.frame.size.width, textfieldVC.view.frame.size.height)];

                textfieldVC.titleLabel.text = [JLString removeNullString:[dataDic objectForKey:@"label"]];
                [textfieldVC.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                [textfieldVC.inputTextField setDelegate:self];
                [textfieldVC.inputTextField setTag:cFormData];
                [textfieldVC.inputTextField setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                textfieldVC.inputTextField.type = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"format"]]];
                
                if ([[JLString removeNullString:[dataDic objectForKey:@"format"]]isEqualToString:@"decimal"]) {
                    [textfieldVC.inputTextField setKeyboardType:UIKeyboardTypeDecimalPad];
                    [textfieldVC.inputTextField setTextAlignment:NSTextAlignmentRight];

                }
                if ([JLString removeNullString:[dataDic objectForKey:@"placeholder"]].length!=0) {
                    [textfieldVC.inputTextField setPlaceholder:[JLString removeNullString:[dataDic objectForKey:@"placeholder"]]];
                }
                textfieldVC.inputTextField.text = [JLString removeNullString:[sharedData objectForKey:[dataDic objectForKey:@"identify"]]];
                
                if ([textfieldVC.inputTextField.text isEqualToString:@""]) {
                    [self setTextFieldData:@"" Identify:[dataDic objectForKey:@"identify"]];
                }
                [arrayETextField addObject:textfieldVC.inputTextField];

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
                [textfieldVC.view setBackgroundColor:[UIColor clearColor]];
                keepHeight = textfieldVC.view.frame.size.height;

                [checkboxArray addObject:textfieldVC.view];
                currentview = textfieldVC.view;
                [filterTextField addObject:dataDic];

            }
        }
        else if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"static"]) {
            
            if ([[JLString removeNullString:[dataDic objectForKey:@"hidden"]]isEqualToString:@""]) {
                BOOL checkCondition = [self checkvalidateConditionsinJSON:dataDic];
                
                if (checkCondition) {
                    NSArray *condition = [dataDic objectForKey:@"conditions"];
                    JLLog(@"condition : %@",[condition objectAtIndex:0]);
                    if ([self validateConditionStaticWithIdentify:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"identify"]] Operate:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"operate"]] Values:[[condition objectAtIndex:0]objectForKey:@"values"]]){
                        
//                        [filterStaticNotHide addObject:dataDic];
                        //-- Add view
                        StaticObjectViewController *staticVC = [[StaticObjectViewController alloc]initWithNibName:@"StaticObjectViewController" bundle:nil];
                        [staticVC.view setFrame:CGRectMake(0, detailView.frame.size.height, staticVC.view.frame.size.width, staticVC.view.frame.size.height)];
                        
                        staticVC.titleLabel.text = [JLString removeNullString:[dataDic objectForKey:@"label"]];
                        [staticVC.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                        
                        [staticVC.detailLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                        staticVC.detailLabel.text = [self summaryDataWithsummary:[dataDic objectForKey:@"summary"]];
                        
//                        [staticVC.inputTextField setDelegate:self];
//                        [textfieldVC.inputTextField setTag:cFormData];
//                        [textfieldVC.inputTextField setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
//                        textfieldVC.inputTextField.type = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"format"]]];
                        
//                        if ([[JLString removeNullString:[dataDic objectForKey:@"format"]]isEqualToString:@"decimal"]) {
//                            [textfieldVC.inputTextField setKeyboardType:UIKeyboardTypeDecimalPad];
//                        }
//                        if ([JLString removeNullString:[dataDic objectForKey:@"placeholder"]].length!=0) {
//                            [textfieldVC.inputTextField setPlaceholder:[JLString removeNullString:[dataDic objectForKey:@"placeholder"]]];
//                        }
//                        [self setTextFieldData:@"" Identify:[dataDic objectForKey:@"identify"]];
                        
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
                        [staticVC.view setBackgroundColor:[UIColor clearColor]];
                        keepHeight = staticVC.view.frame.size.height;
                        
                        [checkboxArray addObject:staticVC.view];
                        currentview = staticVC.view;
                        [filterStaticNotHide addObject:dataDic];

                    }
                    
                }
                else
                {
//                    [filterStaticNotHide addObject:dataDic];
                    //-- Add view
                    StaticObjectViewController *staticVC = [[StaticObjectViewController alloc]initWithNibName:@"StaticObjectViewController" bundle:nil];
                    [staticVC.view setFrame:CGRectMake(0, detailView.frame.size.height, staticVC.view.frame.size.width, staticVC.view.frame.size.height)];
                    
                    staticVC.titleLabel.text = [JLString removeNullString:[dataDic objectForKey:@"label"]];
                    [staticVC.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    
                    [staticVC.detailLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    staticVC.detailLabel.text = [self summaryDataWithsummary:[dataDic objectForKey:@"summary"]];
                    
//                    if ([[JLString removeNullString:[dataDic objectForKey:@"format"]]isEqualToString:@"xxxxx-xxxxx-xxx"]) {
//                        staticVC.detailLabel.text = [TextFormatterUtil formatIdCard:[self summaryDataWithsummary:[dataDic objectForKey:@"summary"]]];
//                        if([staticVC.detailLabel.text length] == 13){
//                            staticVC.detailLabel.text =  [NSString stringWithFormat:@"%@-%@-%@",
//                                       [staticVC.detailLabel.text substringWithRange:NSMakeRange(0, 5)],
//                                       [staticVC.detailLabel.text substringWithRange:NSMakeRange(1, 4)],
//                                       [staticVC.detailLabel.text substringWithRange:NSMakeRange(5, 5)]];
//                        }
//
//                    }
                    
                    //                        [staticVC.inputTextField setDelegate:self];
                    //                        [textfieldVC.inputTextField setTag:cFormData];
                    //                        [textfieldVC.inputTextField setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    //                        textfieldVC.inputTextField.type = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"format"]]];
                    
                    //                        if ([[JLString removeNullString:[dataDic objectForKey:@"format"]]isEqualToString:@"decimal"]) {
                    //                            [textfieldVC.inputTextField setKeyboardType:UIKeyboardTypeDecimalPad];
                    //                        }
                    //                        if ([JLString removeNullString:[dataDic objectForKey:@"placeholder"]].length!=0) {
                    //                            [textfieldVC.inputTextField setPlaceholder:[JLString removeNullString:[dataDic objectForKey:@"placeholder"]]];
                    //                        }
                    //                        [self setTextFieldData:@"" Identify:[dataDic objectForKey:@"identify"]];
                    
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
                    [staticVC.view setBackgroundColor:[UIColor clearColor]];
                    keepHeight = staticVC.view.frame.size.height;
                    
                    [checkboxArray addObject:staticVC.view];
                    currentview = staticVC.view;
                    [filterStaticNotHide addObject:dataDic];

                }
                
            }
        }
        
        [detailView setFrame:CGRectMake(0, 0, self.view.frame.size.width,detailView.frame.size.height + keepHeight)];
        [detailView addSubview:currentview];
        currentview = nil;
    }
    
    
//    for (int countfilter = 0; countfilter < filterTextField.count; countfilter++) {
//        NSDictionary *dataDic = [filterTextField objectAtIndex:countfilter];
//        
//        
//       
//    }
    
//    UIView *checkboxView = [[UIView alloc]init];
//    
//    CGFloat keepHeight = 100;
//    
//    for (int count = 0; count < checkboxArray.count; count++) {
//        
//        if (count == tempformData2.count) {
//            //--Create Title Label
//            UILabel *titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(20, keepHeight, 320, 50)];
//            titleLabel2.text = [JLString removeNullString:[[formsArray objectAtIndex:3]objectForKey:@"formName"]];
//            [titleLabel2 setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleNormal]];
//            JLLog(@"Add#### %f",keepHeight);
//            [checkboxView addSubview:titleLabel2];
//        }
//        
//            UIView *view = [checkboxArray objectAtIndex:count];
//            keepHeight = keepHeight + view.frame.size.height;
//            [checkboxView setFrame:CGRectMake(0, 0,scrollView.frame.size.width, keepHeight)];//:CGSizeMake(scrollView.frame.size.width, keepHeight)];
//            [checkboxView addSubview:view];
//    }
//    
//    for (int countCheckbox = 0; countCheckbox < checkboxArray.count; countCheckbox++) {
//    }
    
    //--Create Title Label
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 320, 40)];
    headerLabel.text = [JLString removeNullString:[[formsArray objectAtIndex:2]objectForKey:@"formName"]];
    [headerLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    
    subheaderLabel.text = [JLString removeNullString:[[formsArray objectAtIndex:2]objectForKey:@"formName"]];
    [subheaderLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
//    CGRect checkboxFrame = detailView.frame;
//    checkboxFrame.origin.y = titleLabel.frame.size.height;
//    [detailView setFrame:checkboxFrame];
//    
//    [scrollView addSubview:titleLabel];
    [scrollView addSubview:detailView];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, detailView.frame.size.height+marginFooter)];
    
    CGFloat hContentSizeHeight = scrollView.contentSize.height;
    CGRect frameNextView = nextView.frame;
    frameNextView.origin.y = hContentSizeHeight+90;
    CGRect frameHeader = headerLabel.frame;

    if (frameNextView.origin.y<screenHeight) {
        frameNextView.origin.y = scrollView.frame.size.height - frameNextView.size.height - frameHeader.size.height;
    }
    else
    {
        frameNextView.origin.y = hContentSizeHeight+90;
        
    }
    [nextView setFrame:frameNextView];
    [scrollView addSubview:nextView];

    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height+keyboardHeight)];

    //-- Add Tap Gesture -----------------------------------------------------
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    [scrollView addGestureRecognizer:tapGesture];
    
//    NSMutableArray *formData2 = [[NSMutableArray alloc]init];
//    [formData2 addObjectsFromArray:[[[[formsArray objectAtIndex:2] objectForKey:@"formData"]objectAtIndex:0] objectForKey:@"fields"]];
//    NSMutableArray *tempformData2 = [[NSMutableArray alloc]init];
//    
//    // -- Get Object For Create Header
//    for (int countData = 0 ; countData < formData2.count ; countData++)
//    {
//        NSDictionary *dataDic = [formData2 objectAtIndex:countData];
//        
//        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"textfield"]) {
//            
//            BOOL checkCondition = [self checkvalidateConditionsinJSON:dataDic];
//            
//            if (checkCondition) {
//                NSArray *condition = [dataDic objectForKey:@"conditions"];
//                JLLog(@"condition : %@",[condition objectAtIndex:0]);
//                if ([self validateConditionWithIdentify:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"identify" ]]
//                                                Operate:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"operate" ]]
//                                                 Values:[JLString removeNullString:[[[condition objectAtIndex:0]objectForKey:@"values" ] objectAtIndex:0]]]) {
//                    
//                    [tempformData2 addObject:dataDic];
//                    
//                }
//            }
//            else
//            {
//                [tempformData2 addObject:dataDic];
//                
//            }
//        }
//        
//    }
//    
//    NSMutableArray *checkboxArray = [[NSMutableArray alloc]init];
//    filterTextField = [[NSMutableArray alloc]init];
//    filterStatic = [[NSMutableArray alloc]init];
//    for (int countData = 0 ; countData < formData.count ; countData++)
//    {
//        NSDictionary *dataDic = [formData objectAtIndex:countData];
//        
//        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"textfield"]) {
//            
//            BOOL checkCondition = [self checkvalidateConditionsinJSON:dataDic];
//            
//            if (checkCondition) {
//                NSArray *condition = [dataDic objectForKey:@"conditions"];
//                JLLog(@"condition : %@",[condition objectAtIndex:0]);
//                if ([self validateConditionWithIdentify:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"identify" ]]
//                                                Operate:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"operate" ]]
//                                                 Values:[JLString removeNullString:[[[condition objectAtIndex:0]objectForKey:@"values" ] objectAtIndex:0]]]) {
//                    
//                    [filterTextField addObject:dataDic];
//                    
//                }
//            }
//            else
//            {
//                [filterTextField addObject:dataDic];
//                
//            }
//        }
//        
//        
//        else if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"static"]) {
//            
//            BOOL checkCondition = [self checkvalidateConditionsinJSON:dataDic];
//            
//            if (checkCondition) {
//                NSArray *condition = [dataDic objectForKey:@"conditions"];
//                JLLog(@"condition : %@",[condition objectAtIndex:0]);
//                if ([self validateConditionStaticWithIdentify:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"identify"]] Operate:[JLString removeNullString:[[condition objectAtIndex:0]objectForKey:@"operate"]] Values:[[condition objectAtIndex:0]objectForKey:@"values"]]){
//                    
//                    [filterStatic addObject:dataDic];
//                    
//                }
//                
//            }
//            else
//            {
//                [filterStatic addObject:dataDic];
//            }
//            //            [filterStatic addObject:dataDic];
//        }
//        
//    }
//    JLLog(@"_formsArray step3 :%@",filterStatic);
//    
//    
//    
//    for (int countfilter = 0; countfilter < filterTextField.count; countfilter++) {
//        NSDictionary *dataDic = [filterTextField objectAtIndex:countfilter];
//        
//        
//        TextfieldObjectViewController *textfieldVC = [[TextfieldObjectViewController alloc]initWithNibName:@"TextfieldObjectViewController" bundle:nil];
//        if (countfilter >= tempformData2.count) {
//            [textfieldVC.view setFrame:CGRectMake(0, (textfieldVC.view.frame.size.height*countfilter)+50, textfieldVC.view.frame.size.width, textfieldVC.view.frame.size.height)];
//            
//        }
//        else
//        {
//            [textfieldVC.view setFrame:CGRectMake(0, textfieldVC.view.frame.size.height*countfilter, textfieldVC.view.frame.size.width, textfieldVC.view.frame.size.height)];
//            
//        }
//        
//        
//        textfieldVC.titleLabel.text = [JLString removeNullString:[dataDic objectForKey:@"label"]];
//        [textfieldVC.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
//        [textfieldVC.inputTextField setDelegate:self];
//        [textfieldVC.inputTextField setTag:countfilter];
//        [textfieldVC.inputTextField setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
//        textfieldVC.inputTextField.type = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"format"]]];
//        
//        if ([[JLString removeNullString:[dataDic objectForKey:@"format"]]isEqualToString:@"decimal"]) {
//            [textfieldVC.inputTextField setKeyboardType:UIKeyboardTypeDecimalPad];
//        }
//        if ([JLString removeNullString:[dataDic objectForKey:@"placeholder"]].length!=0) {
//            [textfieldVC.inputTextField setPlaceholder:[JLString removeNullString:[dataDic objectForKey:@"placeholder"]]];
//        }
//        [self setTextFieldData:@"" Identify:[dataDic objectForKey:@"identify"]];
//        
//        BOOL checkValidate = [self checkvalidateValueinJSON:dataDic];
//        NSLog(checkValidate?@"checkValidate YES":@" checkValidate NO");
//        if (checkValidate == YES) {
//            [validateArray addObject:@"YES"];
//        }
//        else if (checkValidate == NO)
//        {
//            [validateArray addObject:@"NO"];
//            
//        }
//        //        [textfieldVC.checkboxButton addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [textfieldVC.view setBackgroundColor:[UIColor clearColor]];
//        [checkboxArray addObject:textfieldVC.view];
//    }
//    
//    UIView *checkboxView = [[UIView alloc]init];
//    
//    CGFloat keepHeight = 100;
//    
//    for (int count = 0; count < checkboxArray.count; count++) {
//        
//        if (count == tempformData2.count) {
//            //--Create Title Label
//            UILabel *titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(20, keepHeight, 320, 50)];
//            titleLabel2.text = [JLString removeNullString:[[formsArray objectAtIndex:3]objectForKey:@"formName"]];
//            [titleLabel2 setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleNormal]];
//            JLLog(@"Add#### %f",keepHeight);
//            [checkboxView addSubview:titleLabel2];
//        }
//        
//        UIView *view = [checkboxArray objectAtIndex:count];
//        keepHeight = keepHeight + view.frame.size.height;
//        [checkboxView setFrame:CGRectMake(0, 0,scrollView.frame.size.width, keepHeight)];//:CGSizeMake(scrollView.frame.size.width, keepHeight)];
//        [checkboxView addSubview:view];
//    }
//    
//    for (int countCheckbox = 0; countCheckbox < checkboxArray.count; countCheckbox++) {
//    }
//    
//    //--Create Title Label
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 320, 50)];
//    titleLabel.text = [JLString removeNullString:[[formsArray objectAtIndex:2]objectForKey:@"formName"]];
//    [titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleNormal]];
//    
//    CGRect checkboxFrame = checkboxView.frame;
//    checkboxFrame.origin.y = titleLabel.frame.size.height;
//    [checkboxView setFrame:checkboxFrame];
//    
//    [scrollView addSubview:titleLabel];
//    [scrollView addSubview:checkboxView];
//    
//    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, checkboxView.frame.size.height+marginFooter)];
//    
//    CGFloat hContentSizeHeight = scrollView.contentSize.height;
//    CGRect frameNextView = nextView.frame;
//    frameNextView.origin.y = hContentSizeHeight-marginFooter;
//    [nextView setFrame:frameNextView];
//    [scrollView addSubview:nextView];
//    
//    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height+keyboardHeight)];
//    
//    //-- Add Tap Gesture -----------------------------------------------------
//    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//    tapGesture.delegate = self;
//    [checkboxView addGestureRecognizer:tapGesture];


}
- (IBAction)nextClicked:(id)sender {
    
    for (int cFilterStatic = 0; cFilterStatic < filterStatic.count; cFilterStatic++) {
        NSDictionary *dStatic = [filterStatic objectAtIndex:cFilterStatic];
        [self validateStaticWithMyidentify:[JLString removeNullString:[dStatic objectForKey:@"identify"]] Summary:[dStatic objectForKey:@"summary"]];
        [self setTextFieldData:[NSString stringWithFormat:@"%f", [self validateStaticWithMyidentify:[JLString removeNullString:[dStatic objectForKey:@"identify"]] Summary:[dStatic objectForKey:@"summary"]]] Identify:[JLString removeNullString:[dStatic objectForKey:@"identify"]]];
    }
    JLLog(@"sharedData After : %@",sharedData);
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

    NSLog(@"next sharedData : %@",sharedData);
    TaxStep5ViewController *tax4VC = [[TaxStep5ViewController alloc]initWithNibName:@"TaxStep5ViewController" bundle:nil];
    tax4VC.formsArray = formsArray;
    tax4VC.sharedData = sharedData;
    [self.navigationController pushViewController:tax4VC animated:YES];
}
#pragma mark - Calculate Summary Static Method
-(NSString*)summaryDataWithsummary:(NSArray*)summary
{
    NSString *summaryString = @"";
    if ([[JLString removeNullString:[[summary objectAtIndex:0]objectForKey:@"value"]]isEqualToString:@"device"]) {
        summaryString = [ShareUserDetail retrieveDataWithStringKey:[JLString removeNullString:[[summary objectAtIndex:0]objectForKey:@"identify"]]];
    }
    if ([summaryString isEqualToString:@""]) {
        summaryString = [sharedData objectForKey:[JLString removeNullString:[[summary objectAtIndex:0]objectForKey:@"identify"]]];
    }
    return summaryString;
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

-(BOOL)checkvalidateMaximuminJSON:(NSDictionary*)json
{
    NSString *str = [NSString stringWithFormat:@"%@",json];
    JLLog(@"str %@",str);
    if ([str rangeOfString:@"maximum"].location == NSNotFound) {
        return NO;
    }
    
    else
    {
        return YES;
    }
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
    NSDictionary *dataDic = [formData objectAtIndex:textField.tag];
//
//    
//    
//    
//    if ([[JLString removeNullString:[validateArray objectAtIndex:textField.tag]]isEqualToString:@"YES"]) {
//        NSArray *validateinData = [dataDic objectForKey:@"validate"];
//        JLLog(@"validate count %d",validateinData.count);
//        
//        for (int cValidate = 0; cValidate < validateinData.count; cValidate++) {
//            NSDictionary *dValidate =[validateinData objectAtIndex:cValidate];
//            JLLog(@"validate :%d Message :  %@",cValidate,[dValidate objectForKey:@"message"]);
//            [self setTextFieldData:textField.text Identify:[dataDic objectForKey:@"identify"]];
//
//            if ([self validateWithMyData:textField.text
//                              Myidentify:[JLString removeNullString:[dataDic objectForKey:@"identify"]]
//                                 Operate:[JLString removeNullString:[dValidate objectForKey:@"operate"]]
//                            AlertMessage:[JLString removeNullString:[dValidate objectForKey:@"message"]]
//                                  Value1:[dValidate objectForKey:@"v1"]
//                                  Value2:[dValidate objectForKey:@"v2"]])
//            {
//                
//                return;
//            }
//
//        }
////        [self validateWithMyData:textField.text Operate:<#(NSString *)#> AlertMessage:<#(NSString *)#> Value1:<#(NSString *)#> Value2:<#(NSString *)#>]
//    }
//    EtextField *eTxt = (EtextField*)textField;
//    if ([eTxt.type isEqualToString:@"decimal"]) {
//        
//        textField.text = [TextFormatterUtil formatAmount:eTxt.text];
//    }
    [self setTextFieldData:[textField.text stringByReplacingOccurrencesOfString:@"," withString:@""] Identify:[dataDic objectForKey:@"identify"]];
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
            }else if( [[TaxStep3ViewController numberFormatter] numberFromString:currentString].longLongValue >= 10000000 ){
                newString = currentString;
            }else{
                
                
                [currentString appendString:string];
                [currentString replaceOccurrencesOfString:[TaxStep3ViewController numberFormatter].groupingSeparator withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [currentString length])];
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
    NSNumber *currentValue = [[TaxStep3ViewController numberFormatter] numberFromString:numberStr];
    return [[TaxStep3ViewController numberFormatter] stringFromNumber:currentValue];
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
    return [TaxStep3ViewController numberFormatter];
}
#pragma mark - Set Data
-(void)setTextFieldData:(NSString*)textFielddata Identify:(NSString*)identify
{
    [sharedData setObject:textFielddata forKey:identify];
}
#pragma mark - Validate Static
-(BOOL)validateConditionStaticWithIdentify:(NSString*)cIdentify Operate:(NSString*)cOperate Values:(NSArray*)cValues
{
    JLLog(@"cIdentify:%@ cOperate:%@ cValues:%@",cIdentify,cOperate,cValues);
    JLLog(@"cIdentify:%@ ",[[sharedData objectForKey:@"pickcheckbox"]objectForKey:cIdentify]);
    if ([cOperate isEqualToString:@"equal"]) {
        for (int iValues = 0; iValues < cValues.count; iValues++) {
            
            if ([[JLString removeNullString:[ShareUserDetail retrieveDataWithStringKey:cIdentify]]isEqualToString:[JLString removeNullString:[cValues objectAtIndex:iValues]]]) {
                return YES;
            }
            if ([[JLString removeNullString:[cValues objectAtIndex:iValues]]isEqualToString:@"1"]) {
                if ([[JLString removeNullString:[[sharedData objectForKey:@"pickcheckbox"]objectForKey:cIdentify]]isEqualToString:@"CHECK"]) {
                    return YES;
                }
            }
//            if ([[JLString removeNullString:[cValues objectAtIndex:iValues]]isEqualToString:@"0"]) {
//                if ([[JLString removeNullString:[sharedData objectForKey:cIdentify]]isEqualToString:@"CHECK"]) {
//                    return YES;
//                }
//            }
        }
        return NO;
        
    }
    return NO;
}
-(float)validateStaticWithMyidentify:(NSString*)myidentify Summary:(NSArray*)summary
{
    NSString *cData = @"";
    float sumValue = 0.0f;
    
    for (int cSummary = 0; cSummary < summary.count; cSummary++) {
        NSDictionary *dicSummary = [summary objectAtIndex:cSummary];
        NSString *Identify = [JLString removeNullString:[dicSummary objectForKey:@"identify"]];
        NSString *Value = [JLString removeNullString:[dicSummary objectForKey:@"value"]];
        if ([self checkvalidateMaximuminJSON:dicSummary]) {
           cData = [self calculateSummaryWithIdentify:Identify Values:Value Maximum:[dicSummary objectForKey:@"maximum"]];

        }
        else
        {
           cData = [self calculateSummaryWithIdentify:Identify Values:Value Maximum:nil];

        }
        
        JLLog(@"%@",cData);
        if ([Value isEqualToString:@"+"]) {
            sumValue = [cData floatValue] + sumValue;
        }
        else if ([Value isEqualToString:@"-"]) {
            sumValue = sumValue - [cData floatValue] ;
        }
        else if ([Value hasPrefix:@"*"])
        {
            sumValue = [cData floatValue] * [[Value stringByReplacingOccurrencesOfString:@"*" withString:@""] floatValue];
        }
        
    }
    return sumValue;
}
-(NSString*)calculateSummaryWithIdentify:(NSString*)identify Values:(NSString*)values Maximum:(NSDictionary*)maximum
{
    if (maximum != nil) {
        NSString *maximumValues;

        NSArray *summary = [maximum objectForKey:@"summary"];
        NSDictionary *summaryDic = [summary objectAtIndex:0];
        if ([JLString removeNullString:[summaryDic objectForKey:@"identify"]].length == 0) {
            maximumValues = [JLString removeNullString:[summaryDic objectForKey:@"value"]];
            return maximumValues;
        }
        else
        {
            if ([[JLString removeNullString:[summaryDic objectForKey:@"value"]]isEqualToString:@"+"]) {
                maximumValues = [sharedData objectForKey:[JLString removeNullString:[summaryDic objectForKey:@"identify"]]];
            }
            else if ([[JLString removeNullString:[summaryDic objectForKey:@"value"]] hasPrefix:@"*"])
            {
                float sum = ([[[JLString removeNullString:[summaryDic objectForKey:@"value"]]stringByReplacingOccurrencesOfString:@"*" withString:@""]floatValue] * [[JLString removeNullString:[sharedData objectForKey:[summaryDic objectForKey:@"identify"]]]floatValue]);
                maximumValues = [NSString stringWithFormat:@"%f",sum];
            }
            else
            {
                maximumValues = [sharedData objectForKey:[JLString removeNullString:[summaryDic objectForKey:@"identify"]]];

            }
            
            if ([[JLString removeNullString:[sharedData objectForKey:[JLString removeNullString:identify]]]floatValue] <= [maximumValues floatValue]) {
                return [JLString removeNullString:[sharedData objectForKey:[JLString removeNullString:identify]]];
            }
            else
            {
                return maximumValues;
            }
        }
    }
    else
    {
        if ([values isEqualToString:@"+"]) {
            return  [JLString removeNullString:[sharedData objectForKey:[JLString removeNullString:identify]]];

        }
    }
    return @"";
}
#pragma mark - Validate TextField
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
    JLLog(@"mydata : %@ ||myidentify:%@ ||Operate :%@||V1 :%@|| V2 :%@||",mydata,myidentify, operate,v1,v2);
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
        NSString *dataV1 = @"";
        float sumV1 = 0.0f;
        for (int loopV1 = 0; loopV1 < v1Array.count ; loopV1++) {
            
            NSDictionary *loopV1Dic = [v1Array objectAtIndex:loopV1];
            dataV1 = [sharedData objectForKey:[JLString removeNullString:[loopV1Dic objectForKey:@"identify"]]];
            
            if ([[JLString removeNullString:[loopV1Dic objectForKey:@"value"]]isEqualToString:@"+"]) {
                sumV1 = [dataV1 floatValue] + sumV1;
            }
            else if ([[JLString removeNullString:[loopV1Dic objectForKey:@"value"]]isEqualToString:@"-"]) {
                sumV1 = sumV1 - [dataV1 floatValue];
                
            }
            else if ([[JLString removeNullString:[loopV1Dic objectForKey:@"value"]]hasPrefix:@"*"]) {
                sumV1 = [[dataV1 stringByReplacingOccurrencesOfString:@"*" withString:@""] floatValue] * [[[JLString removeNullString:[loopV1Dic objectForKey:@"value"]]stringByReplacingOccurrencesOfString:@"*" withString:@""]floatValue];
                
            }
            else
            {
                sumV1 = [[JLString removeNullString:[loopV1Dic objectForKey:@"value"]] floatValue];
            }
        }
        
        float sumV2 = 0.0f;
        NSString *dataV2 = @"";
        for (int loopV2 = 0; loopV2 < v2Array.count ; loopV2++) {
            
            NSDictionary *loopV2Dic = [v2Array objectAtIndex:loopV2];
            dataV2 = [sharedData objectForKey:[JLString removeNullString:[loopV2Dic objectForKey:@"identify"]]];
            
            if ([[JLString removeNullString:[loopV2Dic objectForKey:@"value"]]isEqualToString:@"+"]) {
                sumV2 = [dataV2 floatValue] + sumV2;
            }
            else if ([[JLString removeNullString:[loopV2Dic objectForKey:@"value"]]isEqualToString:@"-"]) {
                sumV2 = sumV2 - [dataV2 floatValue];
                
            }
            else if ([[JLString removeNullString:[loopV2Dic objectForKey:@"value"]]hasPrefix:@"*"]) {
                sumV2 = [[dataV2 stringByReplacingOccurrencesOfString:@"*" withString:@""] floatValue] * [[[JLString removeNullString:[loopV2Dic objectForKey:@"value"]]stringByReplacingOccurrencesOfString:@"*" withString:@""]floatValue];
                
            }
            else
            {
                sumV2 = [[JLString removeNullString:[loopV2Dic objectForKey:@"value"]] floatValue];
            }
        }
        
        if (sumV1 >= sumV2) {
            return NO;
        }
        else
        {
            [self alertMessageWithMessage:alertmessage];
            return YES;
        }
//        for (int loopV1 = 0; loopV1 < v1Array.count ; loopV1++) {
//            
//            NSDictionary *loopV1Dic = [v1Array objectAtIndex:loopV1];
//            
//            if ([[JLString removeNullString:[loopV1Dic objectForKey:@"identify"]]isEqualToString:myidentify]) {
//                
//                if ([[JLString removeNullString:[loopV1Dic objectForKey:@"value"]]isEqualToString:@"+"]) {
//                    
//                    NSDictionary *loopV2Dic = [v2Array objectAtIndex:0];
//                    if ([mydata floatValue]>=[[JLString removeNullString:[loopV2Dic objectForKey:@"value"]]floatValue])  {
//                        
//                    }
//                    else
//                    {
//                        
//                        [self alertMessageWithMessage:alertmessage];
//                        return YES;
//                    }
//                }
//                
//            }
//            
//            else
//            {
//                if ([[JLString removeNullString:[loopV1Dic objectForKey:@"value"]]isEqualToString:@"+"]) {
//                    
//                }
//                else
//                {
//                    
//                }
//            }
//        }
        //        for (int loopV2 = 0; loopV2 < v2Array.count ; loopV2++) {
        //
        //            NSDictionary *loopV2Dic = [v2Array objectAtIndex:loopV2];
        //
        //        }
    }
    else if ([operate isEqualToString:@"<="]) {
        
        NSString *dataV1 = @"";
        float sumV1 = 0.0f;
        for (int loopV1 = 0; loopV1 < v1Array.count ; loopV1++) {
            
            NSDictionary *loopV1Dic = [v1Array objectAtIndex:loopV1];
            dataV1 = [sharedData objectForKey:[JLString removeNullString:[loopV1Dic objectForKey:@"identify"]]];

            if ([[JLString removeNullString:[loopV1Dic objectForKey:@"value"]]isEqualToString:@"+"]) {
                sumV1 = [dataV1 floatValue] + sumV1;
            }
            else if ([[JLString removeNullString:[loopV1Dic objectForKey:@"value"]]isEqualToString:@"-"]) {
                sumV1 = sumV1 - [dataV1 floatValue] ;

            }
            else if ([[JLString removeNullString:[loopV1Dic objectForKey:@"value"]]hasPrefix:@"*"]) {
                sumV1 = [[dataV1 stringByReplacingOccurrencesOfString:@"*" withString:@""] floatValue] * [[[JLString removeNullString:[loopV1Dic objectForKey:@"value"]]stringByReplacingOccurrencesOfString:@"*" withString:@""]floatValue];

            }
            else
            {
                sumV1 = [[JLString removeNullString:[loopV1Dic objectForKey:@"value"]] floatValue];
            }
        }

        float sumV2 = 0.0f;
        NSString *dataV2 = @"";
        for (int loopV2 = 0; loopV2 < v2Array.count ; loopV2++) {
            
            NSDictionary *loopV2Dic = [v2Array objectAtIndex:loopV2];
            dataV2 = [sharedData objectForKey:[JLString removeNullString:[loopV2Dic objectForKey:@"identify"]]];
            
            if ([[JLString removeNullString:[loopV2Dic objectForKey:@"value"]]isEqualToString:@"+"]) {
                sumV2 = [dataV2 floatValue] + sumV2;
            }
            else if ([[JLString removeNullString:[loopV2Dic objectForKey:@"value"]]isEqualToString:@"-"]) {
                sumV2 = sumV2 - [dataV2 floatValue] ;
                
            }
            else if ([[JLString removeNullString:[loopV2Dic objectForKey:@"value"]]hasPrefix:@"*"]) {
                sumV2 = [[dataV2 stringByReplacingOccurrencesOfString:@"*" withString:@""] floatValue] * [[[JLString removeNullString:[loopV2Dic objectForKey:@"value"]]stringByReplacingOccurrencesOfString:@"*" withString:@""]floatValue];
                
            }
            else
            {
                sumV2 = [[JLString removeNullString:[loopV2Dic objectForKey:@"value"]] floatValue];
            }
        }
        JLLog(@"sumv1 %f <= sumv2 %f",sumV1,sumV2);
        if (sumV1 <= sumV2) {
            return NO;
        }
        else
        {
            [self alertMessageWithMessage:alertmessage];
            return YES;
        }
        
    }
    else if ([operate isEqualToString:@"chkPin"]) {
        
    }
    
    return NO;
}
#pragma mark - ALERT MESSAGE
-(void)alertMessageWithMessage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:ok otherButtonTitles: nil];
    [alert show];
}
@end

@interface tempTextField : UITextField
{
   
    
}
@property (nonatomic,strong) NSString *identify;


@end
