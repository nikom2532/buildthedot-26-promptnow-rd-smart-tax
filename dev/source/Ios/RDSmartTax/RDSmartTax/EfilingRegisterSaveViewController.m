//
//  EfilingRegisterSaveViewController.m
//  RDSmartTax
//
//  Created by Noi on 12/7/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingRegisterSaveViewController.h"
#import "EfilingRegisterConfirmViewController.h"
#import "TextFieldModel.h"

#import "Util.h"
#import "FontUtil.h"
#import "TextFormatterUtil.h"
#import "JSONDictionaryExtensions.h"
#import "ShareUserDetail.h"
#import "FormUtil.h"

@interface EfilingRegisterSaveViewController (){
    ENRegisterSaveService *enRegisterSaveService;
    
    NSArray *loginDetailArray;
    NSArray *loginDetailPlaceHolder;
    NSArray *forgetPasswordArray;
    NSArray *forgetPasswordPlaceHolder;
    NSArray *userProfileArray;
    NSArray *userProfilePlaceHolder;
    NSArray *questionIdArray;
    NSDictionary *responseDataConfirmDic;
    
    TextFieldModel *textFieldModel;
    BOOL isCallMoi;
}


@end

@implementation EfilingRegisterSaveViewController

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
    
    isCallMoi = NO;
    
    //test
    self.pNid = @"1234567890123";
    self.pThaiNation = @"0";
    
    dataArray = [[NSMutableArray alloc] init];
    //questionArray = [[NSArray alloc]init];
    
	self.password  = @"" ;
    self.confirmPassword  = @"" ;
    
    self.email = @"" ;
    self.birthDate  = @"" ;
    self.questionId = @"" ;
    self.answer = @"" ;
    
    self.name     = @"" ;
	self.surname = @"" ;
    self.telephone = @"" ;
    self.telephoneExtension = @"" ;
    self.mobile = @"" ;
    self.fatherName = @"" ;
    self.motherName = @"" ;
    self.passportNo = @"" ;
	self.countryCode = @"" ;
    
    
    //------------------------------- Value Login Detail ----------------------------------------------------------
    loginDetailArray = [[NSArray alloc]initWithObjects:
                        @"เลขประจำตัวประชาชน/เลขประจำตัวผ้เูสียภาษีอากร",
                        @"รหัสผ่าน",
                        @"ระบุรหัสผ่านอีกครั้ง",
                        nil];
    loginDetailPlaceHolder = [[NSArray alloc]initWithObjects:
                              @"เลขประจำตัวประชาชน/เลขประจำตัวผ้เูสียภาษีอากร",
                              @"รหัสผ่าน",
                              @"ระบุรหัสผ่านอีกครั้ง",
                              nil];
    
    NSDictionary *loginDetailDic = [NSDictionary dictionaryWithObject:loginDetailArray forKey:@"data"];
    [dataArray addObject:loginDetailDic];
    
    //------------------------------- Value Forget Password ----------------------------------------------------------
    
    forgetPasswordArray = [[NSArray alloc]initWithObjects:
                           @"อีเมล",
                           @"วันเดือนปีเกิด",
                           @"คำถาม",
                           @"คำตอบ",
                           nil];
    forgetPasswordPlaceHolder = [[NSArray alloc]initWithObjects:
                                 @"อีเมล",
                                 @"วันเดือนปีเกิด",
                                 @"คำถาม",
                                 @"คำตอบ",
                                 nil];
    
    NSDictionary *forgetPasswordDic = [NSDictionary dictionaryWithObject:forgetPasswordArray forKey:@"data"];
    [dataArray addObject:forgetPasswordDic];
    
    //------------------------------- Value User Profile ----------------------------------------------------------
    
    if ([self.pThaiNation isEqualToString:@"1"]) {
        
        userProfileArray = [[NSArray alloc]initWithObjects:
                            @"ชื่อ(ไม่ต้องระบุคำนำหน้าชื่อ)",
                            @"ชื่อสกุล",
                            @"หมายเลขโทรศัพท์",
                            @"เบอร์ต่อ",
                            @"หมายเลขโทรศัพท์มือถือ",
                            @"ชื่อ-ชื่อสกุลบิดา (ไม่ต้องระบุคำนำหน้าชื่อ)",
                            @"ชื่อ-ชื่อสกุลมารดา (ไม่ต้องระบุคำนำหน้าชื่อ)",
                            @"",
                            nil];
        userProfilePlaceHolder = [[NSArray alloc]initWithObjects:
                                  @"ชื่อ(ไม่ต้องระบุคำนำหน้าชื่อ)",
                                  @"ชื่อสกุล",
                                  @"หมายเลขโทรศัพท์",
                                  @"เบอร์ต่อ",
                                  @"หมายเลขโทรศัพท์มือถือ",
                                  @"ชื่อ-ชื่อสกุลบิดา (ไม่ต้องระบุคำนำหน้าชื่อ)",
                                  @"ชื่อ-ชื่อสกุลมารดา (ไม่ต้องระบุคำนำหน้าชื่อ)",
                                  nil];
        
    } else {
        
        userProfileArray = [[NSArray alloc]initWithObjects:
                            @"ชื่อ(ไม่ต้องระบุคำนำหน้าชื่อ)",
                            @"ชื่อสกุล",
                            @"หมายเลขโทรศัพท์",
                            @"เบอร์ต่อ",
                            @"หมายเลขโทรศัพท์มือถือ",
                            @"เลขที่หนังสือเดินทาง (กรณีชาวต่างชาติ)",
                            @"ประเทศหนังสือเดินทาง (กรณีชาวต่างชาติ)",
                            @"",
                            nil];
        userProfilePlaceHolder = [[NSArray alloc]initWithObjects:
                                  @"ชื่อ(ไม่ต้องระบุคำนำหน้าชื่อ)",
                                  @"ชื่อสกุล",
                                  @"หมายเลขโทรศัพท์",
                                  @"เบอร์ต่อ",
                                  @"หมายเลขโทรศัพท์มือถือ",
                                  @"ชื่อ-ชื่อสกุลบิดา (ไม่ต้องระบุคำนำหน้าชื่อ)",
                                  @"ชื่อ-ชื่อสกุลมารดา (ไม่ต้องระบุคำนำหน้าชื่อ)",
                                  nil];
    }
    
    NSDictionary *userProfileDic = [NSDictionary dictionaryWithObject:userProfileArray forKey:@"data"];
    [dataArray addObject:userProfileDic];
    
    //------------------------------- Value question ----------------------------------------------------------
    //    questionIdArray = [[NSArray alloc]initWithObjects:
    //                        @"One",
    //                        @"Two",
    //                        @"Three",
    //                        @"Four",
    //                        @"Five",
    //                        nil];
    //    //NSDictionary *questionDic = [NSDictionary dictionaryWithObject:questionArray forKey:@"data"];
    //    self.questionArray = questionIdArray;
    //    for (int i =0;i<[self.questionArray count];i++) {
    //        NSLog(@"q-> i%@",[self.questionArray objectAtIndex:i]);
    //    }
    //     questionField_ = [[UIPickerView alloc] init];
    //    [questionField_ setDataSource: self];
    //    [questionField_ setDelegate: self];
    //    questionField_.showsSelectionIndicator = YES;
    //    [self.view addSubview: questionField_];
    
    
    //-- Add Tap Gesture -----------------------------------------------------
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    //passwordField_.delegate = self;
    
    
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
    if ( textField == passwordField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.password"] integerValue]) {
            return NO;
        }
        
	}else if ( textField == confirmPasswordField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.password"] integerValue]) {
            return NO;
        }
    }else if ( textField == emailField_ ) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.email"] integerValue]) {
            return NO;
        }
    }else if (textField == telephoneField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.contractNo"] integerValue]) {
            return NO;
        }
    }else if (textField == mobileField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.contractNo"] integerValue]) {
            return NO;
        }
    }else if (textField == nameField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
    }else if (textField == surnameField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.surname"] integerValue]) {
            return NO;
        }
    }else if (textField == motherNameField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
    }else if (textField == fatherNameField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.name"] integerValue]) {
            return NO;
        }
    }else if (textField == passportNoField_) {
		if (range.location == [[Util retrieveValidateConfigFromKey:@"rd.length.passportNo"] integerValue]) {
            return NO;
        }
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    txtActiveEditing = nil;
    if ( textField == nameField_ ) {
		self.name = textField.text ;
	} else if ( textField == surnameField_ ) {
		self.surname = textField.text ;
	} else if ( textField == birthDateField_ ) {
		self.birthDate = textField.text ;
	}else if ( textField == passportNoField_ ) {
		self.passportNo = textField.text ;
	}else if ( textField == countryCodeField_ ) {
		self.countryCode = textField.text ;
	}else if ( textField == fatherNameField_ ) {
		self.fatherName = textField.text ;
	}else if ( textField == motherNameField_ ) {
		self.motherName = textField.text ;
	}else if ( textField == telephoneField_ ) {
		self.telephone = textField.text ;
	}else if ( textField == telephoneExtensionField_ ) {
		self.telephoneExtension = textField.text ;
	}else if ( textField == mobileField_ ) {
		self.mobile = textField.text ;
	}else if ( textField == passwordField_ ) {
		self.password = textField.text ;
	}else if ( textField == confirmPasswordField_ ) {
		self.confirmPassword = textField.text ;
	}else if ( textField == questionIdField_ ) {
		self.questionId = textField.text ;
	}else if ( textField == answerField_ ) {
		self.answer = textField.text ;
	}else if ( textField == emailField_ ) {
		self.email = textField.text ;
	}
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dataArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dictionary = [dataArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"data"];
    //NSLog(@"\ncount > %ld", (unsigned long)[array count]);
    return [array count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel * sectionHeader = [[UILabel alloc] initWithFrame:CGRectZero];
    sectionHeader.backgroundColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    sectionHeader.textAlignment = UITextAlignmentCenter;
    sectionHeader.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    //    sectionHeader.textColor = [UIColor whiteColor];
    if(section == 0)
    {
        sectionHeader.text = @"ข้อมูลเพื่อเข้าใช้ระบบ";
    }
    else if(section == 1)
    {
        sectionHeader.text = @"ข้อมูลกรณีลืมรหัสผ่าน";
    }
    else
    {
        sectionHeader.text = @"ข้อมูลส่วนบุคคล";
    }
    return sectionHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	UITextField* tf = nil ;
    //
    textFieldModel = [Util loadViewWithNibName:@"TextFieldModel"];
    textFieldModel.frame = CGRectMake(0, 0, 320, 75);
    textFieldModel.layer.masksToBounds = YES;
    textFieldModel.pTxt.delegate = self;
    textFieldModel.pTitle.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold];
    textFieldModel.pTxt.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    [textFieldModel.pButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    
    if (indexPath.section == 0) {
        textFieldModel.pTitle.text =[loginDetailArray objectAtIndex:indexPath.row];
        switch ( indexPath.row ) {
            case 0: {
                textFieldModel.pTxt.hidden = YES;
                textFieldModel.pButton.hidden = YES;
                NSString *nid = [TextFormatterUtil formatIdCard:self.pNid];
                [textFieldModel addSubview:[FormUtil initLabelWithSubTitleText:nid]];
                [cell addSubview:textFieldModel];
                break ;
            }
            case 1: {
                textFieldModel.pTxt.text = self.password;
                textFieldModel.pTxt.placeholder = [loginDetailPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = passwordField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                
                break ;
            }
            case 2: {
                textFieldModel.pTxt.text = self.confirmPassword;
                textFieldModel.pTxt.placeholder = [loginDetailPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = confirmPasswordField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
            }
                
        }
    } else if (indexPath.section == 1) {
        textFieldModel.pTitle.text = [forgetPasswordArray objectAtIndex:indexPath.row];

        switch (indexPath.row) {
                
            case 0: {
                textFieldModel.pTxt.text = self.email;
                textFieldModel.pTxt.placeholder = [forgetPasswordPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = emailField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];

                break ;
            }
            case 1: {
                textFieldModel.pTxt.text = self.birthDate;
                textFieldModel.pTxt.placeholder = [forgetPasswordPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = birthDateField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
            }
            case 2: {
                textFieldModel.pTxt.text = self.questionId;
                textFieldModel.pTxt.placeholder = [forgetPasswordPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = questionIdField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
            }
            case 3: {
                textFieldModel.pTxt.text = self.answer;
                textFieldModel.pTxt.placeholder = [forgetPasswordPlaceHolder objectAtIndex:indexPath.row];
                textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                textFieldModel.pButton.hidden = YES;
                tf = answerField_ = textFieldModel.pTxt;
                [cell addSubview:textFieldModel];
                break ;
            }
        }
    } else {
        textFieldModel.pTitle.text = [userProfileArray objectAtIndex:indexPath.row];
        if ([self.pThaiNation isEqualToString:@"1"]) {
            
            switch ( indexPath.row ) {
                case 0: {
                    textFieldModel.pTxt.text = self.name;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = nameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];

                    break ;
                }
                case 1: {
                    textFieldModel.pTxt.text = self.surname;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = surnameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];

                    break ;
                }
                case 2: {
                    textFieldModel.pTxt.text = self.telephone;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                    textFieldModel.pButton.hidden = YES;
                    tf = telephoneField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];

                    break ;
                }
                case 3: {
                    textFieldModel.pTxt.text = self.telephoneExtension;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                    textFieldModel.pButton.hidden = YES;
                    tf = telephoneExtensionField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
    
                    break ;
                }
                case 4: {
                    textFieldModel.pTxt.text = self.mobile;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                    textFieldModel.pButton.hidden = YES;
                    tf = mobileField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 5: {
                    textFieldModel.pTxt.text = self.fatherName;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = fatherNameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 6: {
                    textFieldModel.pTxt.text = self.motherName;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = motherNameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];

                    break ;
                }
            }
        }else{
            textFieldModel.pTitle.text = [userProfileArray objectAtIndex:indexPath.row];
            switch ( indexPath.row ) {
                case 0: {
                    textFieldModel.pTxt.text = self.name;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = nameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 1: {
                    textFieldModel.pTxt.text = self.surname;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeAlphabet;
                    textFieldModel.pButton.hidden = YES;
                    tf = surnameField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 2: {
                    textFieldModel.pTxt.text = self.telephone;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                    textFieldModel.pButton.hidden = YES;
                    tf = telephoneField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;

                }
                case 3: {
                    textFieldModel.pTxt.text = self.telephoneExtension;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                    textFieldModel.pButton.hidden = YES;
                    tf = telephoneExtensionField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 4: {
                    textFieldModel.pTxt.text = self.mobile;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                    textFieldModel.pButton.hidden = YES;
                    tf = mobileField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 5: {
                    textFieldModel.pTxt.text = self.passportNo;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                    textFieldModel.pButton.hidden = YES;
                    tf = passportNoField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                case 6: {
                    textFieldModel.pTxt.text = self.countryCode;
                    textFieldModel.pTxt.placeholder = [userProfilePlaceHolder objectAtIndex:indexPath.row];
                    textFieldModel.pTxt.keyboardType = UIKeyboardTypeNumberPad;
                    textFieldModel.pButton.hidden = YES;
                    tf = countryCodeField_ = textFieldModel.pTxt;
                    [cell addSubview:textFieldModel];
                    
                    break ;
                }
                    
            }
        }
        
    }
//    NSInteger sectionsAmount = [tableView numberOfSections];
//    NSInteger rowsAmount = [tableView numberOfRowsInSection:[indexPath section]];
//    if ([indexPath section] == sectionsAmount - 1 && [indexPath row] == rowsAmount - 1) {
//        UIButton *bt = [FormUtil initNextButtonWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Save"]];
//        [bt addTarget:self action:@selector(onSaveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:bt];
//    }
    NSInteger sectionsAmount = [tableView numberOfSections];
    NSInteger rowsAmount = [tableView numberOfRowsInSection:[indexPath section]];
    if ([indexPath section] == sectionsAmount - 1 && [indexPath row] == rowsAmount - 1) {
        UIButton *bt = [FormUtil initNextButtonWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Save"]];
        [bt addTarget:self action:@selector(onSaveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:bt];
    }
    
    [tf addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];
    tf.delegate = self ;
    return cell;
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//
//    UIView *footerContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 300,100)];
//    UIButton *btnFooter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [footerContainer addSubview:btnFooter];
//    [self.tableFooterView addSubview:btnFooter];
//
//    return [self tableFooterView];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 30.0; // return your button's height
//}

- (IBAction)textFieldFinished:(id)sender {
    //[sender resignFirstResponder];
}

- (void) onSaveButtonClicked :(UIButton*)button {
//    if ([self validateField] == YES) {
//        
//        [self callRegisterSaveService];
//    }
    //    NSLog(@"\n password : %@", self.password);
    //    NSLog(@"\n confirmpassword : %@", self.confirmPassword);
    //    NSLog(@"\n email : %@", self.email);
    //    NSLog(@"\n birthdate : %@", self.birthDate);
    //    NSLog(@"\n questionId : %@", self.questionId);
    //    NSLog(@"\n answer : %@", self.answer);
    //    NSLog(@"\n name : %@", self.name);
    //    NSLog(@"\n surname : %@", self.surname);
    //    NSLog(@"\n father : %@", self.fatherName);
    //    NSLog(@"\n mother : %@", self.motherName);
    //    NSLog(@"\n telephone : %@", self.telephone);
    
}
- (BOOL) validateField {

    
    if([self.pThaiNation isEqualToString: @"1"]){
        if([Util validatePasswordIsEqualConfirmPassword:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"Password field not match ");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if ([Util validatePasswordIsCorrectFormat:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"the string contains illegal characters");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
            
        }else if([Util validatePasswordIsEmpty:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"Password field must be 8 character ");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([Util validatePasswordIsExceptWord:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"Password field must not be password ");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.email]){
            NSLog(@"email not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.birthDate]){
            NSLog(@"birthdate not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.questionId]){
            NSLog(@"question not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }
        else if([Util validateEmptyFieldWithString:self.answer]){
            NSLog(@"answer not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.name]){
            NSLog(@"name not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.surname]){
            NSLog(@"surname not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.telephone]){
            NSLog(@"telephone not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.fatherName]){
            NSLog(@"fathername not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([Util validateEmptyFieldWithString:self.motherName]){
            NSLog(@"mothername not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else{
            return YES;
        }
    }else{
        
        if([Util validatePasswordIsEqualConfirmPassword:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"Password field not match ");
            return NO;
        }else if ([Util validatePasswordIsCorrectFormat:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"the string contains illegal characters");
            return NO;
            
        }else if([Util validatePasswordIsEmpty:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"Password field must be 8 character ");
            return NO;
        }else if([Util validatePasswordIsExceptWord:self.password confirmPassword:self.confirmPassword]){
            NSLog(@"Password field must not be password ");
            return NO;
        }else if([self.email isEqualToString:@""]){
            NSLog(@"email not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([self.birthDate isEqualToString:@""]){
            NSLog(@"birthdate not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([self.questionId isEqualToString:@""]){
            NSLog(@"question not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }
        else if([self.answer isEqualToString:@""]){
            NSLog(@"answer not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([self.name isEqualToString:@""]){
            NSLog(@"name not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([self.surname isEqualToString:@""]){
            NSLog(@"surname not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([self.telephone isEqualToString:@""]){
            NSLog(@"telephone not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([self.passportNo isEqualToString:@""]){
            NSLog(@"passport not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else if([self.countryCode isEqualToString:@""]){
            NSLog(@"countrycode not corect");
            [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:@""];
            return NO;
        }else{
            return YES;
        }
        
    }
    
}
#pragma - picker view question
//// Number of components.
//-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
//    return 1;
//}
//
//// Total rows in our component.
//-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    return [questionArray count];
//}
//
//// Display each row's data.
//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    return [self.questionArray objectAtIndex: row];
//}
//
//// Do something with the selected row.
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    NSLog(@"You selected this: %@", [questionArray objectAtIndex: row]);
//}

#pragma - call service
- (void) callRegisterSaveService{
    enRegisterSaveService = [[ENRegisterSaveService alloc]init];
    enRegisterSaveService.delegate = self;
    NSLog(@"\n call enRegisterSaveService");
    NSString *version= [Util loadAppSettingWithName:@"Version"];
    
    if([self.pThaiNation isEqualToString:@"1"]){
        NSLog(@"\n thai ");
        [enRegisterSaveService requestENRegisterSaveService:self.pNid
                                                   password:self.password
                                                      email:self.email
                                                  birthDate:self.birthDate
                                                 questionId:self.questionId
                                                     answer:self.answer
                                                       name:self.name
                                                    surname:self.surname
                                                  telephone:self.telephone
                                         telephoneExtension:self.telephoneExtension
                                                 fatherName:self.fatherName
                                                 motherName:self.motherName
                                                 passportNo:@""
                                                countryCode:@""
                                                    moiFlag:@"N"
                                                    version:version];
    }else{
        [enRegisterSaveService requestENRegisterSaveService:self.pNid
                                                   password:self.password
                                                      email:self.email
                                                  birthDate:self.birthDate
                                                 questionId:self.questionId
                                                     answer:self.answer
                                                       name:self.name
                                                    surname:self.surname
                                                  telephone:self.telephone
                                         telephoneExtension:self.telephoneExtension
                                                 fatherName:@""
                                                 motherName:@""
                                                 passportNo:self.passportNo
                                                countryCode:self.countryCode
                                                    moiFlag:@"N"
                                                    version:version];
        
        
    }
}
- (void) callRegisterSaveServiceWithMOI{
    isCallMoi = YES;
    
    enRegisterSaveService = [[ENRegisterSaveService alloc]init];
    enRegisterSaveService.delegate = self;
    NSLog(@"\n call enRegisterSaveService");
    NSString *version= [Util loadAppSettingWithName:@"Version"];
    
    if([self.pThaiNation isEqualToString:@"1"]){
        NSLog(@"\n thai ");
        [enRegisterSaveService requestENRegisterSaveService:self.pNid
                                                   password:self.password
                                                      email:self.email
                                                  birthDate:self.birthDate
                                                 questionId:self.questionId
                                                     answer:self.answer
                                                       name:self.name
                                                    surname:self.surname
                                                  telephone:self.telephone
                                         telephoneExtension:self.telephoneExtension
                                                 fatherName:self.fatherName
                                                 motherName:self.motherName
                                                 passportNo:@""
                                                countryCode:@""
                                                    moiFlag:@"Y"
                                                    version:version];
    }else{
        [enRegisterSaveService requestENRegisterSaveService:self.pNid
                                                   password:self.password
                                                      email:self.email
                                                  birthDate:self.birthDate
                                                 questionId:self.questionId
                                                     answer:self.answer
                                                       name:self.name
                                                    surname:self.surname
                                                  telephone:self.telephone
                                         telephoneExtension:self.telephoneExtension
                                                 fatherName:@""
                                                 motherName:@""
                                                 passportNo:self.passportNo
                                                countryCode:self.countryCode
                                                    moiFlag:@"N"
                                                    version:version];
        
        
    }
}

- (void) responseENRegisterSaveService:(NSData *)data{
    
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    NSLog(@"response : %@", dic);
    
    NSString *result = @"CONFIRM";
//    [dic objectForKey:@"responseStatus"]
    if ([result isEqualToString:@"OK"]) {
        
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        
        if (isCallMoi) {
            
            nameField_.text = [responseDataDic objectForKey:@"name"];
            surnameField_.text = [responseDataDic objectForKey:@"surname"];
            
            isCallMoi = NO;
            
        } else {
            
            [responseDataDic objectForKey:@"name"];
            [responseDataDic objectForKey:@"surname"];
            [responseDataDic objectForKey:@"buildName"];
            [responseDataDic objectForKey:@"roomNo"];
            [responseDataDic objectForKey:@"floorNo"];
            [responseDataDic objectForKey:@"addressNo"];
            [responseDataDic objectForKey:@"soi"];
            [responseDataDic objectForKey:@"village"];
            [responseDataDic objectForKey:@"mooNo"];
            [responseDataDic objectForKey:@"street"];
            [responseDataDic objectForKey:@"tambol"];
            [responseDataDic objectForKey:@"amphur"];
            [responseDataDic objectForKey:@"province"];
            [responseDataDic objectForKey:@"postcode"];
            
            
            EfilingRegisterConfirmViewController *vc = [[EfilingRegisterConfirmViewController alloc]initWithNibName:@"EfilingRegisterConfirmViewController" bundle:nil];
            
            vc.pNid = self.pNid; // hard code for test
            vc.pBuildName = [responseDataDic objectForKey:@"buildName"];
            vc.pRoomNo = [responseDataDic objectForKey:@"roomNo"];
            vc.pFloorNo = [responseDataDic objectForKey:@"floorNo"];
            vc.pAddressNo = [responseDataDic objectForKey:@"addressNo"];
            vc.pSoi = [responseDataDic objectForKey:@"soi"];
            vc.pVillage = [responseDataDic objectForKey:@"village"];
            vc.pMooNo = [responseDataDic objectForKey:@"mooNo"];
            vc.pStreet = [responseDataDic objectForKey:@"street"];
            vc.pTumbol = [responseDataDic objectForKey:@"tambol"];
            vc.pAmphur = [responseDataDic objectForKey:@"amphur"];
            vc.pProvince = [responseDataDic objectForKey:@"province"];
            vc.pPostcode = [responseDataDic objectForKey:@"postcode"];
            vc.pContractNo = [responseDataDic objectForKey:@"contractNo"];
            NSLog(@"contractNo %@",vc.pContractNo);
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }
    if([result isEqualToString:@"CONFIRM"]) {
         responseDataConfirmDic = [dic objectForKey:@"responseData"];
        [responseDataConfirmDic objectForKey:@"name"];
        [responseDataConfirmDic objectForKey:@"surname"];
        [responseDataConfirmDic objectForKey:@"buildName"];
        [responseDataConfirmDic objectForKey:@"roomNo"];
        [responseDataConfirmDic objectForKey:@"floorNo"];
        [responseDataConfirmDic objectForKey:@"addressNo"];
        [responseDataConfirmDic objectForKey:@"soi"];
        [responseDataConfirmDic objectForKey:@"village"];
        [responseDataConfirmDic objectForKey:@"mooNo"];
        [responseDataConfirmDic objectForKey:@"street"];
        [responseDataConfirmDic objectForKey:@"tambol"];
        [responseDataConfirmDic objectForKey:@"amphur"];
        [responseDataConfirmDic objectForKey:@"province"];
        [responseDataConfirmDic objectForKey:@"postcode"];
        
        [self alertYesNoWithTitle:@"" detail:[Util stringWithScreenName:@"Register" labelName:@"ResConfirm"] yes:[Util stringWithScreenName:@"Common" labelName:@"Yes"] no:[Util stringWithScreenName:@"Common" labelName:@"No"]];

    }
    if([[dic objectForKey:@"responseStatus"] isEqualToString:@"ERROR"]) {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
}

#pragma mark - Alert with condition
- (void) alertYesNoWithTitle : (NSString *)title detail:(NSString *)detail yes:(NSString *)yes no:(NSString *)no {
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:title];
    [alert setMessage:detail];
    [alert setDelegate:self];
    [alert addButtonWithTitle:yes];
    [alert addButtonWithTitle:no];
    [alert show];
}
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self callRegisterSaveServiceWithMOI];
        
    } else if (buttonIndex == 1){
        EfilingRegisterConfirmViewController *vc = [[EfilingRegisterConfirmViewController alloc]initWithNibName:@"EfilingRegisterConfirmViewController" bundle:nil];
        
        vc.pNid = self.pNid;
        vc.pBuildName = [responseDataConfirmDic objectForKey:@"buildName"];
        vc.pRoomNo = [responseDataConfirmDic objectForKey:@"roomNo"];
        vc.pFloorNo = [responseDataConfirmDic objectForKey:@"floorNo"];
        vc.pAddressNo = [responseDataConfirmDic objectForKey:@"addressNo"];
        vc.pSoi = [responseDataConfirmDic objectForKey:@"soi"];
        vc.pVillage = [responseDataConfirmDic objectForKey:@"village"];
        vc.pMooNo = [responseDataConfirmDic objectForKey:@"mooNo"];
        vc.pStreet = [responseDataConfirmDic objectForKey:@"street"];
        vc.pTumbol = [responseDataConfirmDic objectForKey:@"tambol"];
        vc.pAmphur = [responseDataConfirmDic objectForKey:@"amphur"];
        vc.pProvince = [responseDataConfirmDic objectForKey:@"province"];
        vc.pPostcode = [responseDataConfirmDic objectForKey:@"postcode"];
        vc.pContractNo = [responseDataConfirmDic objectForKey:@"contractNo"];
        NSLog(@"contractNo %@",vc.pContractNo);
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)save:(id)sender {
    if ([self validateField] == YES) {
        
        [self callRegisterSaveService];
    }
}
@end
