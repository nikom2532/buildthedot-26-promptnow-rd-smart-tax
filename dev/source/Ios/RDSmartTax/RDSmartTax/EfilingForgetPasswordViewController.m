//
//  EfilingForgetPasswordViewController.m
//  RDSmartTax
//
//  Created by Noi on 12/16/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingForgetPasswordViewController.h"
#import "TextFieldModel.h"

#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"
@interface EfilingForgetPasswordViewController (){
    ENResetPasswordRequestService *enResetPasswordRequestService;
    NSArray *requestPasswordArray;
    NSArray *requestPasswordPlaceHolder;
    TextFieldModel *textFieldModel;
}

@end

@implementation EfilingForgetPasswordViewController

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
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //test
     self.pNid = [ShareUserDetail retrieveDataWithStringKey:@"nid"];
    self.birthDate = @"";
    
    //------------------------------- Value Forget Password ----------------------------------------------------------
    requestPasswordArray = [[NSArray alloc]initWithObjects:
                        @"เลขประจำตัวประชาชน/เลขประจำตัวผ้เูสียภาษีอากร",
                        @"วันเกิด",
                        nil];
    requestPasswordPlaceHolder = [[NSArray alloc]initWithObjects:
                                  @"เลขประจำตัวประชาชน/เลขประจำตัวผ้เูสียภาษีอากร",
                                  @"วันเกิด",
                                  nil];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}
#pragma mark -
#pragma mark Textfield
-(void)hideKeyboard
{
    if(txtActiveEditing) {
        [txtActiveEditing resignFirstResponder];
    }
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL]; [UIView setAnimationDuration:0.35f]; CGRect frame = self.view.frame; frame.origin.y = -100; [self.view setFrame:frame]; [UIView commitAnimations];
    txtActiveEditing = textField;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ( textField == birthDateField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.birthDate"] integerValue]) {
            return NO;
        }
        
	}
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    txtActiveEditing = nil;
    if ( textField == birthDateField_ ) {
		self.birthDate = textField.text ;
	}
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [requestPasswordArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	UITextField* tf = nil ;
    
    textFieldModel = [Util loadViewWithNibName:@"TextFieldModel"];
    textFieldModel.frame = CGRectMake(0, 0, 320, 75);
    textFieldModel.layer.masksToBounds = YES;
    textFieldModel.pTxt.delegate = self;
    textFieldModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    textFieldModel.pTxt.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    [textFieldModel.pButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
    textFieldModel.pTitle.text =[requestPasswordArray objectAtIndex:indexPath.row];
    textFieldModel.pTxt.placeholder = [requestPasswordPlaceHolder objectAtIndex:indexPath.row];
    textFieldModel.pButton.hidden = YES;
    [cell addSubview:textFieldModel];
    
    [tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    tf.delegate = self ;
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (IBAction)textFieldFinished:(id)sender {
    //[sender resignFirstResponder];
}

@end