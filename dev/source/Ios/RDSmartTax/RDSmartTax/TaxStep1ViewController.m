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

#import "TaxStep2ViewController.h"

#define checkbox @"bg_checked.png"
#define uncheckbox @"bg_check.png"
#define marginFooter 80
#define spaceForNextView 80
@interface TaxStep1ViewController ()
{
    NSMutableDictionary *responseData;
    NSMutableArray *formsArray;
    NSMutableArray *filterChecbox;
    NSMutableArray *keepChecboxClass;
    
    NSMutableDictionary *pickIdentifyCheckbox;
    NSMutableDictionary *sharedData;

    UIPickerView *dropDownPickerView;
    UIActionSheet *dropDownActionSheet;

    UIButton *currentButton;
    
    //--test
}
@end

@implementation TaxStep1ViewController

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
    formsArray = [[NSMutableArray alloc]init];
    filterChecbox = [[NSMutableArray alloc]init];
    keepChecboxClass = [[NSMutableArray alloc]init];
    
    pickIdentifyCheckbox = [[NSMutableDictionary alloc]init];
    sharedData = [[NSMutableDictionary alloc]init];
    
    self.title = @"ยื่นภาษี";
    [self requestData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - REQUEST DATA
-(void)requestData
{
    //-- Call Service
    ENgetFormPnd91 *engetForm = [[ENgetFormPnd91 alloc]init];
    engetForm.delegate = self;
    [engetForm requestENgetFormPnd91Service];
}
-(void)responseENgetFormPnd91Service:(NSData *)data
{
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"OK"]) {
        responseData = [[NSMutableDictionary alloc]initWithDictionary:[NSDictionary dictionaryWithJSONData:data]];

        [formsArray addObjectsFromArray:[[responseData objectForKey:@"responseData"] objectForKey:@"forms"]];
        [self createviewCheckboxWithData:[formsArray objectAtIndex:0]];
    }
}
#pragma mark - Display Method
-(void)createviewCheckboxWithData:(NSDictionary*)data
{
    NSArray *formData = [[[data objectForKey:@"formData"]objectAtIndex:0] objectForKey:@"fields"];
    NSLog(@"formData : %@",formData);
//
//    NSArray *tempdata = [formData valueForKeyPath:@"@distinctUnionOfObjects.type"];
//    NSLog(@"tempdata : %@",tempdata);
    
    NSMutableArray *filterBar = [[NSMutableArray alloc]init];
    NSMutableArray *filterDropdown = [[NSMutableArray alloc]init];
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
            [checkBox.view setFrame:CGRectMake(0, detailView.frame.size.height, checkBox.view.frame.size.width, checkBox.view.frame.size.height)];
            
            
            checkBox.dataLabel.text = [JLString removeNullString:[dataDic objectForKey:@"label"]];
            checkBox.identify = [[NSString alloc]initWithString:[JLString removeNullString:[dataDic objectForKey:@"identify"]]];
            [checkBox.checkboxButton addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
            [checkBox.checkboxButton setTag:countfilter];
            keepHeight = checkBox.view.frame.size.height;
            currentview = checkBox.view;
            
            [keepChecboxClass addObject:checkBox];
        }
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"dropdown"]) {
            UIView *dropdownviewAdd = [[UIView alloc]initWithFrame:CGRectMake(0, detailView.frame.size.height, detailView.frame.size.width, 95)];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 6, 290, 33)];
            [title setText:[JLString removeNullString:[dataDic objectForKey:@"label"]]];
            
            UIButton *ddButton = [[UIButton alloc]initWithFrame:CGRectMake(15, title.frame.size.height+title.frame.origin.y, 290, 33)];
            [ddButton setTitle:@"กรุณาระบุ" forState:UIControlStateNormal];
            [ddButton setBackgroundColor:[UIColor blackColor]];
            
            [ddButton setTag:0];//--Edit if implement
            
            [ddButton addTarget:self action:@selector(dropdownClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [dropdownviewAdd addSubview:title];
            [dropdownviewAdd addSubview:ddButton];
            
            keepHeight = dropdownviewAdd.frame.size.height;
            currentview = dropdownviewAdd;

            [keepChecboxClass addObject:@""];

        }
        if ([[JLString removeNullString:[dataDic objectForKey:@"type"]]isEqualToString:@"bar"]) {
            UIView *barviewAdd = [[UIView alloc]initWithFrame:CGRectMake(0, detailView.frame.size.height, detailView.frame.size.width, 45)];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 6, 290, 33)];
            [title setText:[JLString removeNullString:[dataDic objectForKey:@"label"]].length==0?@"title bar no data":[JLString removeNullString:[dataDic objectForKey:@"label"]]];
            [barviewAdd addSubview:title];
            keepHeight = barviewAdd.frame.size.height;
            currentview = barviewAdd;

            [keepChecboxClass addObject:@""];
        }
        
        [detailView setFrame:CGRectMake(0, 0, self.view.frame.size.width,detailView.frame.size.height + keepHeight)];
        [detailView addSubview:currentview];
        currentview = nil;
//        NSDictionary *dataDic = [filterChecbox objectAtIndex:countfilter];
        
//        CheckboxObjectViewController *checkBox = [[CheckboxObjectViewController alloc]initWithNibName:@"CheckboxObjectViewController" bundle:nil];
//        [checkBox.view setFrame:CGRectMake(0, checkBox.view.frame.size.height*countfilter, checkBox.view.frame.size.width, checkBox.view.frame.size.height)];
//        
//        
//        checkBox.dataLabel.text = [JLString removeNullString:[JLString removeNullString:[dataDic objectForKey:@"label"]]];
//        [checkBox.checkboxButton addTarget:self action:@selector(checkboxClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [checkboxArray addObject:checkBox.view];
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
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 320, 50)];
    titleLabel.text = [JLString removeNullString:[data objectForKey:@"formName"]];
    
    
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

-(IBAction)checkboxClicked:(UIButton*)sender
{
    JLLog(@"keepCheckbox %@",keepChecboxClass);
    CheckboxObjectViewController *checkboxRecive = [keepChecboxClass objectAtIndex:sender.tag];
    JLLog(@"identify : %@",checkboxRecive.dataLabel);;
    if ([[JLString removeNullString:[keepChecboxClass objectAtIndex:sender.tag]]isEqualToString:@""])
    {
        
    }
    else
    {
        checkboxRecive = (CheckboxObjectViewController*)[keepChecboxClass objectAtIndex:sender.tag];
        JLLog(@"identify : %@",checkboxRecive.identify);
        
        UIImage* uncheckImg=[UIImage imageNamed:@"bg_check.png"];
        if (sender.currentImage == uncheckImg)//--Uncheck to check
        {

            [sender setImage:[UIImage imageNamed:checkbox] forState:UIControlStateNormal];
            [pickIdentifyCheckbox setObject:@"CHECK" forKey:checkboxRecive.identify];

        }
        else //--Check to Uncheck
        {

            [sender setImage:[UIImage imageNamed:uncheckbox] forState:UIControlStateNormal];
            [pickIdentifyCheckbox setObject:@"UNCHECK" forKey:checkboxRecive.identify];

            
        }
    }
    
    
}
- (IBAction)nextClicked:(id)sender {
    [sharedData setObject:pickIdentifyCheckbox forKey:@"pickcheckbox"];
    
    TaxStep2ViewController *tax2VC = [[TaxStep2ViewController alloc]initWithNibName:@"TaxStep2ViewController" bundle:nil];
    tax2VC.formsArray = formsArray;
    tax2VC.sharedData = sharedData;
    [self.navigationController pushViewController:tax2VC animated:YES];
}
@end
