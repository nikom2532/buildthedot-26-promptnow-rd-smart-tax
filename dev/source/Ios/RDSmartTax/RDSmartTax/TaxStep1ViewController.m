//
//  TaxStep1ViewController.m
//  TaxEasy
//
//  Created by Tax on 7/12/56.
//  Copyright (c) พ.ศ. 2556 Tax. All rights reserved.
//

#import "TaxStep1ViewController.h"
#import "JSONDictionaryExtensions.h"
#import "JLString.h"

#import "CheckboxObjectViewController.h"
#import "DependOnCheckBoxViewController.h"

#import "TaxStep2ViewController.h"
#import "FontUtil.h"

#import "EcheckBox.h"
#import "ShareUserDetail.h"

#define checkbox @"btn_on.png"
#define uncheckbox @"btn_off.png"
#define marginFooter 80
#define spaceForNextView 80


#define screename @"Efiling"
@interface TaxStep1ViewController ()<UIAlertViewDelegate>
{
    NSMutableDictionary *responseData;
    NSMutableArray *formsArray;
    NSMutableArray *filterChecbox;
    NSMutableArray *keepChecboxClass;
    
    NSMutableArray *filterBar;
    NSMutableArray *filterDropdown;
    NSArray *formData;
    
    NSMutableDictionary *pickIdentifyCheckbox;
    NSMutableDictionary *sharedData;

    UIPickerView *dropDownPickerView;
    UIActionSheet *dropDownActionSheet;

    UIButton *currentButton;
    
    BOOL checkPnd91;
    BOOL checkRemainPnd91;

    TaxStep2ViewController *tax2VC;
    
    NSInteger selectIndex;
    NSInteger countCheck;
    
    NSMutableArray *selectionCell;
}
@end

@implementation TaxStep1ViewController
@synthesize engetForm;
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
    self.title = @"ยื่นภาษี";
    // Do any additional setup after loading the view from its nib.
//    if (checkPnd91 == YES) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"ท่านได้ยื่นแบบ ภ.ง.ด. 91 ปีภาษี 2556 ผ่านระบบอิเล็กทรอนิคส์เรียบร้อยแล้ว" delegate:self cancelButtonTitle:@"ยกเลิก" otherButtonTitles:@"ภ.ง.ด. 91", nil];
//        [alert setTag:99];
//        [alert show];
//    }
//    
//    else
//    {
//        if (checkRemainPnd91 == YES) {
//            
//        }
//    }
  
//    JLLog(@"spouseFatherPin:%@",[ShareUserDetail retrieveDataWithStringKey:@"spouseFatherPin"]);
//    JLLog(@"txpFatherPin:%@",[ShareUserDetail retrieveDataWithStringKey:@"txpFatherPin"]);
//    JLLog(@"txpMotherPin:%@",[ShareUserDetail retrieveDataWithStringKey:@"txpMotherPin"]);

    countCheck = 0;
    
    formsArray = [[NSMutableArray alloc]init];
    filterChecbox = [[NSMutableArray alloc]init];
    keepChecboxClass = [[NSMutableArray alloc]init];
    
    pickIdentifyCheckbox = [[NSMutableDictionary alloc]init];
    sharedData = [[NSMutableDictionary alloc]init];
    
    selectionCell = [[NSMutableArray alloc]init];
//    self.title = @"ยื่นภาษี";
    [self requestData];
    [self setLanguage];
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
    
//    [self.labelIdCard setText:[Util stringWithScreenName:@"Login" labelName:@"Nid"]];
//    [self.btnLogin setTitle:[Util stringWithScreenName:@"Login" labelName:@"Title"] forState:UIControlStateNormal];
}

- (void) setFontStyle {
    
    [nextButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
//    [self.labelIdCard setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
//    [self.txtIdCard setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
//    [self.btnLogin.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
   
}

#pragma mark - REQUEST DATA
-(void)requestData
{
    //-- Call Service
    if ([Util isInternetConnect]) {
        //-- check version
        engetForm = [[ENgetFormPnd91 alloc]init];
        engetForm.delegate = self;
        [engetForm requestENgetFormPnd91Service];

    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
    }
    
}
-(void)responseENgetFormPnd91Service:(NSDictionary *)data
{
    NSDictionary *dic = data;//[NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"SUCCESS"]) {
        responseData = [[NSMutableDictionary alloc]initWithDictionary:dic];
        
        [sharedData setObject:[[responseData objectForKey:@"responseData"]objectForKey:@"keys"] forKey:@"keys"];

        [formsArray addObjectsFromArray:[[responseData objectForKey:@"responseData"] objectForKey:@"forms"]];
        [self createviewCheckboxWithData:[formsArray objectAtIndex:0]];
    }
}
#pragma mark - Display Method
-(void)createviewCheckboxWithData:(NSDictionary*)data
{
     NSLog(@"formData1 : %@",data);
    formData = [[NSArray alloc]initWithArray:[[[data objectForKey:@"formData"]objectAtIndex:0] objectForKey:@"fields"]];
    NSLog(@"formData : %@",formData);
    //
    //    NSArray *tempdata = [formData valueForKeyPath:@"@distinctUnionOfObjects.type"];
    //    NSLog(@"tempdata : %@",tempdata);
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 320, 40)];
    headerLabel.text = [JLString removeNullString:[data objectForKey:@"formName"]];
    [headerLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    
    subheaderLabel.text = [JLString removeNullString:[data objectForKey:@"formName"]];
    [subheaderLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
    
    [tableFrom reloadData];
    return;
    
    filterBar = [[NSMutableArray alloc]init];
    filterDropdown = [[NSMutableArray alloc]init];
    
    for (int countData = 0 ; countData < formData.count ; countData++)
    {
        NSDictionary *dataDic = [formData objectAtIndex:countData];
        
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"checkbox"]) {
            [filterChecbox addObject:dataDic];
        }
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"dropdown"]) {
            [filterDropdown addObject:dataDic];
        }
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"bar"]) {
            [filterBar addObject:dataDic];
        }
        
    }
    
    //-- Add data to detailView
    UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    
    for (int countfilter = 0; countfilter < formData.count; countfilter++) {
        NSDictionary *dataDic = [formData objectAtIndex:countfilter];
        CGFloat keepHeight = 0;
        UIView *currentview ;
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"checkbox"]) {
            CheckboxObjectViewController *checkBox = [[CheckboxObjectViewController alloc]initWithNibName:@"CheckboxObjectViewController" bundle:nil];
            [checkBox.view setBackgroundColor:[UIColor clearColor]];

            [checkBox.view setFrame:CGRectMake(0, 0, checkBox.view.frame.size.width, checkBox.view.frame.size.height)];
            
            
            checkBox.dataLabel.text = [JLString removeNullString:[dataDic objectForKey:@"label"]];
            [checkBox.dataLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
            
            checkBox.checkboxButton.identify = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"identify"]]];
            [checkBox.checkboxButton addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
            [checkBox.checkboxButton setTag:countfilter];
            keepHeight = checkBox.view.frame.size.height;
            currentview = checkBox.view;
            
            [keepChecboxClass addObject:checkBox];
        }
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"dropdown"]) {
            UIView *dropdownviewAdd = [[UIView alloc]initWithFrame:CGRectMake(0, 0, detailView.frame.size.width, 35)];
            [dropdownviewAdd setBackgroundColor:[UIColor clearColor]];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, 290, 25)];
            [title setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
            [title setText:[JLString removeNullString:[dataDic objectForKey:@"label"]]];
            
            //            JLLog(@"dependOn### :%@",[JLString removeNullString:[[[dataDic objectForKey:@"dependOn"]objectAtIndex:0] objectForKey:@"fields"]]);
            
            CGFloat dropdownHeight = 0;
            UIView *currentDDview ;
            CGRect dropdownviewFrame = dropdownviewAdd.frame;
            
            NSArray *depOnArray = [[[dataDic objectForKey:@"dependOn"]objectAtIndex:0] objectForKey:@"fields"];
            
            NSMutableArray *filterDependOn = [[NSMutableArray alloc]init];
            for (int cFilter = 0 ; cFilter < depOnArray.count; cFilter++) {
                NSDictionary *dataDependOn = [depOnArray objectAtIndex:cFilter];
                JLLog(@"dataDependOn:%@",dataDependOn);
                NSArray *conditionDep = [dataDependOn objectForKey:@"conditions"];
                
                BOOL checkCon = NO;
                BOOL isAdding = YES;
                
                for (int cCondition = 0; cCondition < conditionDep.count; cCondition++) {
                    NSDictionary *dCondition = [conditionDep objectAtIndex:cCondition];
                    checkCon = [self calculateDataDependOnWithIdentify:[JLString removeNullString:[dCondition objectForKey:@"identify"]]
                                                               Operate:[JLString removeNullString:[dCondition objectForKey:@"operate"]]
                                                                Values:[dCondition objectForKey:@"values"]];
                    JLLog(@"dCondition:%@",dCondition);
                    
                    
                    if (!checkCon) {
                        isAdding = NO;
                        break;
                    }
                }
                
                if (isAdding) {
                    [filterDependOn addObject:dataDependOn];
                }
                
            }
            
            for (int cDependOn = 0; cDependOn < filterDependOn.count; cDependOn++) {
                
                NSDictionary *dataDependOn = [filterDependOn objectAtIndex:cDependOn];
                DependOnCheckBoxViewController *checkBox = [[DependOnCheckBoxViewController alloc]initWithNibName:@"DependOnCheckBoxViewController" bundle:nil];
                
                [checkBox.view setFrame:CGRectMake(0, dropdownviewAdd.frame.size.height, checkBox.view.frame.size.width, checkBox.view.frame.size.height)];
                checkBox.dataLabel.text = [JLString removeNullString:[dataDependOn objectForKey:@"label"]];
                [checkBox.dataLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
                
                checkBox.checkboxButton.identify = [[NSString alloc]initWithString:[JLString removeNullString:[dataDependOn objectForKey:@"identify"]]];
                [checkBox.checkboxButton addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
                
                currentDDview = checkBox.view;
                
                dropdownHeight = checkBox.view.frame.size.height;
                
                dropdownviewFrame.size.height = dropdownviewFrame.size.height + dropdownHeight;
                [dropdownviewAdd setFrame:dropdownviewFrame];
                [dropdownviewAdd addSubview:currentDDview];
                currentDDview = nil;
            }
            
            
            //            NSArray *dependOn = [[dataDic objectForKey:@"dependOn"]objectForKey:@"fields"];
            //            JLLog(@"dependOn:%d",dependOn.count);
            //            UIButton *ddButton = [[UIButton alloc]initWithFrame:CGRectMake(15, title.frame.size.height+title.frame.origin.y, 290, 33)];
            //            [ddButton setTitle:@"กรุณาระบุ" forState:UIControlStateNormal];
            //            [ddButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
            
            //            [ddButton setBackgroundColor:[UIColor blackColor]];
            //
            //            [ddButton setTag:0];//--Edit if implement
            //
            //            [ddButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            //            [dropdownviewAdd addSubview:ddButton];
            
            
            
            [dropdownviewAdd addSubview:title];
            
            keepHeight = dropdownviewAdd.frame.size.height;
            currentview = dropdownviewAdd;
            
            [keepChecboxClass addObject:@""];
            
        }
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"bar"]) {
            //            UIView *barviewAdd = [[UIView alloc]initWithFrame:CGRectMake(0, detailView.frame.size.height, detailView.frame.size.width, 45)];
            //            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 6, 290, 33)];
            //            [title setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
            //            [title setText:[JLString removeNullString:[dataDic objectForKey:@"label"]].length==0?@"title bar no data":[JLString removeNullString:[dataDic objectForKey:@"label"]]];
            //            [barviewAdd addSubview:title];
            //            keepHeight = barviewAdd.frame.size.height;
            //            currentview = barviewAdd;
            //
            //            [keepChecboxClass addObject:@""];
        }
        
        [detailView setFrame:CGRectMake(0, 0, self.view.frame.size.width,detailView.frame.size.height + keepHeight)];
        [detailView addSubview:currentview];
        currentview = nil;
        
    }
    
    //    UIView *checkboxView = [[UIView alloc]init];
    //
    //    CGFloat keepHeight = 100;
    //
    //    for (int count = 0; count < checkboxArray.count; count++) {
    //        UIView *view = [checkboxArray objectAtIndex:count];
    //        keepHeight = keepHeight + view.frame.size.height;
    //        [checkboxView setFrame:CGRectMake(0, 0,scrollView.frame.size.width, keepHeight)];
    //        [checkboxView addSubview:view];
    //    }
    //    for (int countCheckbox = 0; countCheckbox < checkboxArray.count; countCheckbox++) {
    //    }
    
    
    
    //--Create Title Label
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 320, 40)];
    titleLabel.text = [JLString removeNullString:[data objectForKey:@"formName"]];
    [titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [titleLabel setBackgroundColor:[UIColor whiteColor]];
    
    CGRect checkboxFrame = detailView.frame;
    checkboxFrame.origin.y = titleLabel.frame.size.height;
    [detailView setFrame:checkboxFrame];
    
    [scrollView addSubview:titleLabel];
    [scrollView addSubview:detailView];
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, detailView.frame.size.height+marginFooter+spaceForNextView)];
    
    CGFloat hContentSizeHeight = scrollView.contentSize.height;
    CGRect frameNextView = nextView.frame;
    frameNextView.origin.y = hContentSizeHeight-marginFooter;
    [nextView setFrame:frameNextView];
    [scrollView addSubview:nextView];
}

//-(void)createviewCheckboxWithData:(NSDictionary*)data
//{
//    NSArray *formData = [[[data objectForKey:@"formData"]objectAtIndex:0] objectForKey:@"fields"];
//    NSLog(@"formData : %@",formData);
////
////    NSArray *tempdata = [formData valueForKeyPath:@"@distinctUnionOfObjects.type"];
////    NSLog(@"tempdata : %@",tempdata);
//    
//    NSMutableArray *filterBar = [[NSMutableArray alloc]init];
//    NSMutableArray *filterDropdown = [[NSMutableArray alloc]init];
//    for (int countData = 0 ; countData < formData.count ; countData++)
//    {
//        NSDictionary *dataDic = [formData objectAtIndex:countData];
//        
//        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"checkbox"]) {
//            [filterChecbox addObject:dataDic];
//        }
//        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"dropdown"]) {
//            [filterDropdown addObject:dataDic];
//        }
//        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"bar"]) {
//            [filterBar addObject:dataDic];
//        }
//        
//    }
//    
//    //-- Add data to detailView
//    UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
//
//    for (int countfilter = 0; countfilter < formData.count; countfilter++) {
//        NSDictionary *dataDic = [formData objectAtIndex:countfilter];
//        CGFloat keepHeight = 0;
//        UIView *currentview ;
//        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"checkbox"]) {
//            CheckboxObjectViewController *checkBox = [[CheckboxObjectViewController alloc]initWithNibName:@"CheckboxObjectViewController" bundle:nil];
//            [checkBox.view setFrame:CGRectMake(0, detailView.frame.size.height, checkBox.view.frame.size.width, checkBox.view.frame.size.height)];
//            
//            
//            checkBox.dataLabel.text = [JLString removeNullString:[dataDic objectForKey:@"label"]];
//            [checkBox.dataLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
//            
//            checkBox.checkboxButton.identify = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"identify"]]];
//            [checkBox.checkboxButton addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
//            [checkBox.checkboxButton setTag:countfilter];
//            keepHeight = checkBox.view.frame.size.height;
//            currentview = checkBox.view;
//            
//            [keepChecboxClass addObject:checkBox];
//        }
//        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"dropdown"]) {
//            UIView *dropdownviewAdd = [[UIView alloc]initWithFrame:CGRectMake(0, detailView.frame.size.height, detailView.frame.size.width, 35)];
//            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, 290, 25)];
//            [title setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
//            [title setText:[JLString removeNullString:[dataDic objectForKey:@"label"]]];
//            
////            JLLog(@"dependOn### :%@",[JLString removeNullString:[[[dataDic objectForKey:@"dependOn"]objectAtIndex:0] objectForKey:@"fields"]]);
//
//            CGFloat dropdownHeight = 0;
//            UIView *currentDDview ;
//            CGRect dropdownviewFrame = dropdownviewAdd.frame;
//            
//            NSArray *depOnArray = [[[dataDic objectForKey:@"dependOn"]objectAtIndex:0] objectForKey:@"fields"];
//            
//            NSMutableArray *filterDependOn = [[NSMutableArray alloc]init];
//            for (int cFilter = 0 ; cFilter < depOnArray.count; cFilter++) {
//                NSDictionary *dataDependOn = [depOnArray objectAtIndex:cFilter];
//                JLLog(@"dataDependOn:%@",dataDependOn);
//                NSArray *conditionDep = [dataDependOn objectForKey:@"conditions"];
//                
//                BOOL checkCon = NO;
//                BOOL isAdding = YES;
//
//                for (int cCondition = 0; cCondition < conditionDep.count; cCondition++) {
//                    NSDictionary *dCondition = [conditionDep objectAtIndex:cCondition];
//                   checkCon = [self calculateDataDependOnWithIdentify:[JLString removeNullString:[dCondition objectForKey:@"identify"]]
//                                                    Operate:[JLString removeNullString:[dCondition objectForKey:@"operate"]]
//                                                     Values:[dCondition objectForKey:@"values"]];
//                    JLLog(@"dCondition:%@",dCondition);
//                    
//                    
//                    if (!checkCon) {
//                        isAdding = NO;
//                        break;
//                    }
//                }
//                
//                if (isAdding) {
//                    [filterDependOn addObject:dataDependOn];
//                }
//                
//            }
//            
//            for (int cDependOn = 0; cDependOn < filterDependOn.count; cDependOn++) {
//                
//                NSDictionary *dataDependOn = [filterDependOn objectAtIndex:cDependOn];
//                DependOnCheckBoxViewController *checkBox = [[DependOnCheckBoxViewController alloc]initWithNibName:@"DependOnCheckBoxViewController" bundle:nil];
//                
//                [checkBox.view setFrame:CGRectMake(0, dropdownviewAdd.frame.size.height, checkBox.view.frame.size.width, checkBox.view.frame.size.height)];
//                checkBox.dataLabel.text = [JLString removeNullString:[dataDependOn objectForKey:@"label"]];
//                [checkBox.dataLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
//                
//                checkBox.checkboxButton.identify = [[NSString alloc]initWithString:[JLString removeNullString:[dataDependOn objectForKey:@"identify"]]];
//                [checkBox.checkboxButton addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
//
//                currentDDview = checkBox.view;
//                
//                dropdownHeight = checkBox.view.frame.size.height;
//                
//                dropdownviewFrame.size.height = dropdownviewFrame.size.height + dropdownHeight;
//                [dropdownviewAdd setFrame:dropdownviewFrame];
//                [dropdownviewAdd addSubview:currentDDview];
//                currentDDview = nil;
//            }
//            
//            
////            NSArray *dependOn = [[dataDic objectForKey:@"dependOn"]objectForKey:@"fields"];
////            JLLog(@"dependOn:%d",dependOn.count);
////            UIButton *ddButton = [[UIButton alloc]initWithFrame:CGRectMake(15, title.frame.size.height+title.frame.origin.y, 290, 33)];
////            [ddButton setTitle:@"กรุณาระบุ" forState:UIControlStateNormal];
////            [ddButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
//            
////            [ddButton setBackgroundColor:[UIColor blackColor]];
////            
////            [ddButton setTag:0];//--Edit if implement
////            
////            [ddButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
//            
////            [dropdownviewAdd addSubview:ddButton];
//            
//            
//            
//            [dropdownviewAdd addSubview:title];
//
//            keepHeight = dropdownviewAdd.frame.size.height;
//            currentview = dropdownviewAdd;
//
//            [keepChecboxClass addObject:@""];
//
//        }
//        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"bar"]) {
////            UIView *barviewAdd = [[UIView alloc]initWithFrame:CGRectMake(0, detailView.frame.size.height, detailView.frame.size.width, 45)];
////            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 6, 290, 33)];
////            [title setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
////            [title setText:[JLString removeNullString:[dataDic objectForKey:@"label"]].length==0?@"title bar no data":[JLString removeNullString:[dataDic objectForKey:@"label"]]];
////            [barviewAdd addSubview:title];
////            keepHeight = barviewAdd.frame.size.height;
////            currentview = barviewAdd;
////
////            [keepChecboxClass addObject:@""];
//        }
//        
//        [detailView setFrame:CGRectMake(0, 0, self.view.frame.size.width,detailView.frame.size.height + keepHeight)];
//        [detailView addSubview:currentview];
//        currentview = nil;
//
//    }
//    
////    UIView *checkboxView = [[UIView alloc]init];
////    
////    CGFloat keepHeight = 100;
////    
////    for (int count = 0; count < checkboxArray.count; count++) {
////        UIView *view = [checkboxArray objectAtIndex:count];
////        keepHeight = keepHeight + view.frame.size.height;
////        [checkboxView setFrame:CGRectMake(0, 0,scrollView.frame.size.width, keepHeight)];
////        [checkboxView addSubview:view];
////    }
////    for (int countCheckbox = 0; countCheckbox < checkboxArray.count; countCheckbox++) {
////    }
//    
//    
//    
//    //--Create Title Label
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 320, 40)];
//    titleLabel.text = [JLString removeNullString:[data objectForKey:@"formName"]];
//    [titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
//    
//    CGRect checkboxFrame = detailView.frame;
//    checkboxFrame.origin.y = titleLabel.frame.size.height;
//    [detailView setFrame:checkboxFrame];
//    
//    [scrollView addSubview:titleLabel];
//    [scrollView addSubview:detailView];
//    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, detailView.frame.size.height+marginFooter+spaceForNextView)];
//    
//    CGFloat hContentSizeHeight = scrollView.contentSize.height;
//    CGRect frameNextView = nextView.frame;
//    frameNextView.origin.y = hContentSizeHeight-marginFooter;
//    [nextView setFrame:frameNextView];
//    [scrollView addSubview:nextView];
//}
-(IBAction)dropdownClicked:(id)sender
{
    JLLog(@"clicked");
    UIButton *button = (UIButton*) sender;
    currentButton = button;
    [self showDropDownViewWithTag:currentButton.tag Delegate:self];
}
-(void)showDropDownViewWithTag:(NSInteger)tag Delegate:(id)delegate

{
    dropDownActionSheet = [[UIActionSheet alloc] init];
    dropDownActionSheet.tag = tag;
    
    if(tag == 0)
    {
        dropDownPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
        dropDownPickerView.showsSelectionIndicator = YES;
        dropDownPickerView.dataSource = delegate;
        dropDownPickerView.delegate = delegate;
        dropDownPickerView.tag = tag;
    }
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackTranslucent;
    [toolBar sizeToFit];
    
    UIBarButtonItem *bb_flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:delegate action:nil];
    UIBarButtonItem *bb_done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:delegate action:@selector(closePickerWithItem:)];
    bb_done.tag = tag;
    
    NSArray *barItems = @[bb_flex, bb_done];
    
    [toolBar setItems:barItems animated:YES];
    
    [dropDownActionSheet addSubview:toolBar];
    [dropDownActionSheet addSubview:dropDownPickerView];

    [dropDownActionSheet showInView:self.view];
    [dropDownActionSheet setBounds:CGRectMake(0, 0, self.view.frame.size.width, 464)];

}

-(void)closePickerWithItem:(UIBarButtonItem *)item;
{
    JLLog(@"Tag : %d \nSelected : %d",item.tag,[dropDownPickerView selectedRowInComponent:0]);

    switch (item.tag) {
        case 0:
        {
            [currentButton setTitle:[NSString stringWithFormat:@"test data : %d",[dropDownPickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
        }
    }
    
    [dropDownActionSheet dismissWithClickedButtonIndex:0 animated:YES];

}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag == 0)
    {
//        if(row == 0)
//        {
//            return [JLString ThaiString:@"--โปรดระบุ--" EngString:@"Please Specify"];
//        }
//        
//        NSDictionary *prefixDetail = [prefixList objectAtIndex:row-1];
        return [NSString stringWithFormat:@"test data : %d",row];
    }
    return @"";
}

#pragma mark - CheckBox Action
-(IBAction)checkboxClicked:(UIButton*)sender
{
    EcheckBox *eCheckBox = (EcheckBox*)sender;
    UIImage* uncheckImg=[UIImage imageNamed:@"btn_off.png"];
    if (sender.currentImage == uncheckImg)//--Uncheck to check
    {
        
        [sender setImage:[UIImage imageNamed:checkbox] forState:UIControlStateNormal];
        [pickIdentifyCheckbox setObject:@"CHECK" forKey:eCheckBox.identify];
        countCheck = countCheck + 1;
    }
    else //--Check to Uncheck
    {
        
        [sender setImage:[UIImage imageNamed:uncheckbox] forState:UIControlStateNormal];
        [pickIdentifyCheckbox setObject:@"UNCHECK" forKey:eCheckBox.identify];
        
        countCheck = countCheck - 1;

    }
//    JLLog(@"keepCheckbox %@",keepChecboxClass);
//    CheckboxObjectViewController *checkboxRecive = [keepChecboxClass objectAtIndex:sender.tag];
//    JLLog(@"identify : %@",checkboxRecive.dataLabel);;
//    if ([[JLString removeNullString:[keepChecboxClass objectAtIndex:sender.tag]]isEqualToString:@""])
//    {
//        
//    }
//    else
//    {
//        checkboxRecive = (CheckboxObjectViewController*)[keepChecboxClass objectAtIndex:sender.tag];
//        JLLog(@"identify : %@",checkboxRecive.identify);
//        
//        UIImage* uncheckImg=[UIImage imageNamed:@"bg_check.png"];
//        if (sender.currentImage == uncheckImg)//--Uncheck to check
//        {
//
//            [sender setImage:[UIImage imageNamed:checkbox] forState:UIControlStateNormal];
//            [pickIdentifyCheckbox setObject:@"CHECK" forKey:checkboxRecive.identify];
//
//        }
//        else //--Check to Uncheck
//        {
//
//            [sender setImage:[UIImage imageNamed:uncheckbox] forState:UIControlStateNormal];
//            [pickIdentifyCheckbox setObject:@"UNCHECK" forKey:checkboxRecive.identify];
//
//            
//        }
//    }
    
    
}
- (IBAction)nextClicked:(id)sender {
    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"ต้องการสร้างรายการเป็น Template หรือไม่" delegate:self cancelButtonTitle:@"ยกเลิก" otherButtonTitles:@"ตกลง", nil];
//    [alert setTag:1];
//    [alert show];
    
    [sharedData setObject:pickIdentifyCheckbox forKey:@"pickcheckbox"];
    [sharedData setObject:[NSString stringWithFormat:@"%d",countCheck] forKey:@"countcheck"];
    [sharedData setObject:[[responseData objectForKey:@"responseData"]objectForKey:@"apiRefNo"] forKey:@"apiRefNo"];

//    if (!tax2VC) {
//        tax2VC = [[TaxStep2ViewController alloc]initWithNibName:@"TaxStep2ViewController" bundle:nil];
//        tax2VC.formsArray = formsArray;
//        tax2VC.sharedData = sharedData;
//    }
    TaxStep2ViewController *tax2 = [[TaxStep2ViewController alloc]initWithNibName:@"TaxStep2ViewController" bundle:nil];
    tax2.formsArray = formsArray;
    tax2.sharedData = sharedData;
    [self.navigationController pushViewController:tax2 animated:YES];

}
#pragma mark - Calculate data in dependon
-(BOOL)calculateDataDependOnWithIdentify:(NSString*)identify Operate:(NSString*)operate Values:(NSArray*)values
{
    NSString *myData = [JLString removeNullString:[ShareUserDetail retrieveDataWithStringKey:identify]];
    JLLog(@"chkParent60###### : %@",[JLString removeNullString:[ShareUserDetail retrieveDataWithStringKey:@"chkParent60"]])

    JLLog(@"myData : %@ // operate : %@",myData,operate);
    
    if ([operate isEqualToString:@"not_null"]) {
        BOOL checkData = NO;
        (myData.length != 0) ? (checkData = YES) : (checkData = NO);
        return checkData;
    }
    else if ([operate isEqualToString:@"equal"]) {
        
        if (values.count == 0) {
            return YES;
        }
        else
        {
            for (int cValues = 0; cValues < values.count; cValues++) {
                NSString *iValues = [JLString removeNullString:[values objectAtIndex:cValues]];
                
                JLLog(@"iValues## : %@",iValues);
                if ([myData isEqualToString:iValues]) {
                    return YES;
                }
//                else
//                {
//                    return NO;
//                }
            }
            return NO;

        }
    }
    return YES;
}
#pragma mark - UITABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return formData.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<=formData.count-1)
    {
        NSDictionary *dataDic = [formData objectAtIndex:indexPath.row];
        
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"checkbox"]) {
            return 50;
        }
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"dropdown"]) {
            
            UIView *dropdownviewAdd = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, 290, 25)];
            [title setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
            [title setText:[JLString removeNullString:[dataDic objectForKey:@"label"]]];
            [dropdownviewAdd addSubview:title];
            //            JLLog(@"dependOn### :%@",[JLString removeNullString:[[[dataDic objectForKey:@"dependOn"]objectAtIndex:0] objectForKey:@"fields"]]);
            for (int cSelection = 0; cSelection < selectionCell.count; cSelection++) {
                if ([[JLString removeNullString:[selectionCell objectAtIndex:cSelection]]isEqualToString:[NSString stringWithFormat:@"%d",indexPath.row]]) {
                    CGFloat dropdownHeight = 0;
                    UIView *currentDDview ;
                    CGRect dropdownviewFrame = dropdownviewAdd.frame;
                    
                    NSArray *depOnArray = [[[dataDic objectForKey:@"dependOn"]objectAtIndex:0] objectForKey:@"fields"];
                    
                    NSMutableArray *filterDependOn = [[NSMutableArray alloc]init];
                    for (int cFilter = 0 ; cFilter < depOnArray.count; cFilter++) {
                        NSDictionary *dataDependOn = [depOnArray objectAtIndex:cFilter];
                        JLLog(@"dataDependOn:%@",dataDependOn);
                        NSArray *conditionDep = [dataDependOn objectForKey:@"conditions"];
                        
                        BOOL checkCon = NO;
                        BOOL isAdding = YES;
                        
                        for (int cCondition = 0; cCondition < conditionDep.count; cCondition++) {
                            NSDictionary *dCondition = [conditionDep objectAtIndex:cCondition];
                            checkCon = [self calculateDataDependOnWithIdentify:[JLString removeNullString:[dCondition objectForKey:@"identify"]]
                                                                       Operate:[JLString removeNullString:[dCondition objectForKey:@"operate"]]
                                                                        Values:[dCondition objectForKey:@"values"]];
                            JLLog(@"dCondition:%@",dCondition);
                            
                            
                            if (!checkCon) {
                                isAdding = NO;
                                break;
                            }
                        }
                        
                        if (isAdding) {
                            [filterDependOn addObject:dataDependOn];
                        }
                        
                    }
                    
                    for (int cDependOn = 0; cDependOn < filterDependOn.count; cDependOn++) {
                        
                        NSDictionary *dataDependOn = [filterDependOn objectAtIndex:cDependOn];
                        DependOnCheckBoxViewController *checkBox = [[DependOnCheckBoxViewController alloc]initWithNibName:@"DependOnCheckBoxViewController" bundle:nil];
                        
                        [checkBox.view setFrame:CGRectMake(0, dropdownviewAdd.frame.size.height, checkBox.view.frame.size.width, checkBox.view.frame.size.height)];
                        checkBox.dataLabel.text = [JLString removeNullString:[dataDependOn objectForKey:@"label"]];
                        [checkBox.dataLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
                        
                        checkBox.checkboxButton.identify = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"identify"]]];
                        if ([[pickIdentifyCheckbox objectForKey:[dataDic objectForKey:@"identify"]]isEqualToString:@"CHECK"]) {
                            [checkBox.checkboxButton setImage:[UIImage imageNamed:checkbox] forState:UIControlStateNormal];
                        }
                        [checkBox.checkboxButton addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
                        
                        currentDDview = checkBox.view;
                        
                        dropdownHeight = checkBox.view.frame.size.height;
                        
                        dropdownviewFrame.size.height = dropdownviewFrame.size.height + dropdownHeight;
                        [dropdownviewAdd setFrame:dropdownviewFrame];
                        [dropdownviewAdd addSubview:currentDDview];
                        currentDDview = nil;
                    }
                    
                    return dropdownviewAdd.frame.size.height;
                }
            }
//            if (selectIndex == indexPath.row) {
//               
//            }
//            else
//            {
//                return 50;
//            }
            
            
            return 50;
            
        }
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"bar"]) {
            return 0;
        }
    }
   
    if (indexPath.row>formData.count-1) {
        return nextView.frame.size.height;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row<=formData.count-1)
    {
        NSDictionary *dataDic = [formData objectAtIndex:indexPath.row];
        
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"checkbox"]) {
            CheckboxObjectViewController *checkBox = [[CheckboxObjectViewController alloc]initWithNibName:@"CheckboxObjectViewController" bundle:nil];
            [checkBox.view setFrame:CGRectMake(0, 0, checkBox.view.frame.size.width, checkBox.view.frame.size.height)];
            [checkBox.view setBackgroundColor:[UIColor clearColor]];

            
            checkBox.dataLabel.text = [JLString removeNullString:[dataDic objectForKey:@"label"]];
            [checkBox.dataLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
            
            checkBox.checkboxButton.identify = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"identify"]]];
            if ([[pickIdentifyCheckbox objectForKey:[dataDic objectForKey:@"identify"]]isEqualToString:@"CHECK"]) {
                [checkBox.checkboxButton setImage:[UIImage imageNamed:checkbox] forState:UIControlStateNormal];
            }
            
            [checkBox.checkboxButton addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
            //        [checkBox.checkboxButton setTag:countfilter];
            //        keepHeight = checkBox.view.frame.size.height;
            //        currentview = checkBox.view;
            [cell addSubview:checkBox.view];
        }
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"dropdown"]) {
            UIView *dropdownviewAdd = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, 290, 25)];
            [title setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
            [title setText:[JLString removeNullString:[dataDic objectForKey:@"label"]]];
            [dropdownviewAdd addSubview:title];
            [dropdownviewAdd setBackgroundColor:[UIColor clearColor]];

            //            JLLog(@"dependOn### :%@",[JLString removeNullString:[[[dataDic objectForKey:@"dependOn"]objectAtIndex:0] objectForKey:@"fields"]]);
            for (int cSelection = 0; cSelection < selectionCell.count; cSelection++) {
                if ([[JLString removeNullString:[selectionCell objectAtIndex:cSelection]]isEqualToString:[NSString stringWithFormat:@"%d",indexPath.row]]) {
                    
                    CGFloat dropdownHeight = 0;
                    UIView *currentDDview ;
                    CGRect dropdownviewFrame = dropdownviewAdd.frame;
                    
                    NSArray *depOnArray = [[[dataDic objectForKey:@"dependOn"]objectAtIndex:0] objectForKey:@"fields"];
                    
                    NSMutableArray *filterDependOn = [[NSMutableArray alloc]init];
                    for (int cFilter = 0 ; cFilter < depOnArray.count; cFilter++) {
                        NSDictionary *dataDependOn = [depOnArray objectAtIndex:cFilter];
                        JLLog(@"dataDependOn:%@",dataDependOn);
                        NSArray *conditionDep = [dataDependOn objectForKey:@"conditions"];
                        
                        BOOL checkCon = NO;
                        BOOL isAdding = YES;
                        
                        for (int cCondition = 0; cCondition < conditionDep.count; cCondition++) {
                            NSDictionary *dCondition = [conditionDep objectAtIndex:cCondition];
                            checkCon = [self calculateDataDependOnWithIdentify:[JLString removeNullString:[dCondition objectForKey:@"identify"]]
                                                                       Operate:[JLString removeNullString:[dCondition objectForKey:@"operate"]]
                                                                        Values:[dCondition objectForKey:@"values"]];
                            JLLog(@"dCondition:%@",dCondition);
                            
                            
                            if (!checkCon) {
                                isAdding = NO;
                                break;
                            }
                        }
                        NSLog(isAdding?@"########## YES":@"########## NO");
                        if (isAdding) {
                            [filterDependOn addObject:dataDependOn];
                        }
                        
                    }
                    
                    for (int cDependOn = 0; cDependOn < filterDependOn.count; cDependOn++) {
                        
                        NSDictionary *dataDependOn = [filterDependOn objectAtIndex:cDependOn];
                        DependOnCheckBoxViewController *checkBox = [[DependOnCheckBoxViewController alloc]initWithNibName:@"DependOnCheckBoxViewController" bundle:nil];
                        
                        [checkBox.view setFrame:CGRectMake(0, dropdownviewAdd.frame.size.height, checkBox.view.frame.size.width, checkBox.view.frame.size.height)];
                        checkBox.dataLabel.text = [JLString removeNullString:[dataDependOn objectForKey:@"label"]];
                        [checkBox.dataLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
                        
                        checkBox.checkboxButton.identify = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"identify"]]];
                        if ([[pickIdentifyCheckbox objectForKey:[dataDic objectForKey:@"identify"]]isEqualToString:@"CHECK"]) {
                            [checkBox.checkboxButton setImage:[UIImage imageNamed:checkbox] forState:UIControlStateNormal];
                        }
                        [checkBox.checkboxButton addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
                        
                        currentDDview = checkBox.view;
                        
                        dropdownHeight = checkBox.view.frame.size.height;
                        
                        dropdownviewFrame.size.height = dropdownviewFrame.size.height + dropdownHeight;
                        [dropdownviewAdd setFrame:dropdownviewFrame];
                        [dropdownviewAdd addSubview:currentDDview];
                        currentDDview = nil;
                    }

                    
                }
            }

            
//            if (selectIndex == indexPath.row) {
//                           }
//            else
//            {
//                
//            }
            
            
            [cell addSubview:dropdownviewAdd];
            
        }
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"bar"]) {
            
        }
    }
  
     if (indexPath.row>formData.count-1) {
         [cell addSubview:nextView];
     }
    // Configure the cell...
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.row == selectIndex)
//    {
//        selectIndex = -1;
//    }
//    else
//    {
        if (selectionCell.count == 0) {
            [selectionCell addObject:[NSString stringWithFormat:@"%d",indexPath.row]];

        }
        else
        {
            BOOL isAdding = YES;
            for (int cSelection = 0; cSelection < selectionCell.count; cSelection++) {
                if ([[JLString removeNullString:[selectionCell objectAtIndex:cSelection]]isEqualToString:[NSString stringWithFormat:@"%d",indexPath.row]]) {
                    [selectionCell removeObject:[NSString stringWithFormat:@"%d",indexPath.row]];
                    isAdding = NO;
                }
            }
            if (isAdding) {
                [selectionCell addObject:[NSString stringWithFormat:@"%d",indexPath.row]];
//                selectIndex = indexPath.row;
            }
        }
        
    JLLog(@"selectionCell### : %@",selectionCell);
//    }
    
//    [tableFrom reloadData];
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - UIALERTVIEW DELEGATE
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            //-- non Send To server
            
        }
        else if (buttonIndex == 1) {
            //-- Send To server
        }
        
//        [sharedData setObject:pickIdentifyCheckbox forKey:@"pickcheckbox"];
        
//        TaxStep2ViewController *tax2VC = [[TaxStep2ViewController alloc]initWithNibName:@"TaxStep2ViewController" bundle:nil];
//        tax2VC.formsArray = formsArray;
//        tax2VC.sharedData = sharedData;
//        [self.navigationController pushViewController:tax2VC animated:YES];
    }
    if (alertView.tag == 99) {
        
        if (buttonIndex == 0) {
            
        }
        else if (buttonIndex == 1) {
            
        }
    }
}

@end


