//
//  EfilingSendEmailViewController.h
//  RDSmartTax
//
//  Created by Noi on 12/18/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "ENResetPasswordConfirmService.h"
#import "ENConfirmQuestionService.h"

@interface EfilingSendEmailViewController : HeaderViewController<UIAlertViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,ENResetPasswordConfirmServiceDelegate>

@property (nonatomic,copy) NSString* pNid;
@property (nonatomic,copy) NSString* pEmail;
@property (strong, nonatomic) IBOutlet UILabel *txtEmail;
@property (strong, nonatomic) IBOutlet UILabel *labelTxtSendEmail1;
@property (strong, nonatomic) IBOutlet UILabel *labelTxtSendEmail2;
@property (strong, nonatomic) IBOutlet UIButton *btnConfirmRequestPassword;

- (IBAction)onConfirmButtonClicked:(id)sender;

@end
