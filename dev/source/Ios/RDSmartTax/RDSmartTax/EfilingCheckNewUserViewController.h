//
//  EfilingCheckNewUserViewController.h
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "ENCheckNewUserService.h"


@interface EfilingCheckNewUserViewController : KeyboardViewController <UITextFieldDelegate, ENCheckNewUserServiceDelegate>
{
   
    
   
}

@property (weak, nonatomic) IBOutlet UILabel *labelTitle1;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle2;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle3;
@property (weak, nonatomic) IBOutlet UITextField *txtIdCard;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UITextView *tvDetail;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *pHeaderView;


- (IBAction)onLoginButtonClicked:(id)sender;

@end

