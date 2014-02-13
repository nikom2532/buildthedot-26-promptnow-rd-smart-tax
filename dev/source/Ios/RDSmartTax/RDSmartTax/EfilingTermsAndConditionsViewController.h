//
//  EfilingTermsAndConditionsViewController.h
//  RDSmartTax
//
//  Created by fone on 12/11/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENSaveConditionFillingFirstService.h"

@interface EfilingTermsAndConditionsViewController : HeaderViewController <ENSaveConditionFillingFirstServiceDelegate>
@property (nonatomic) ENSaveConditionFillingFirstService *enSaveConditionFillingFirstService;
@property (weak, nonatomic) IBOutlet UIView *pHeaderView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnAccept;
@property (weak, nonatomic) IBOutlet UITextView *tfTermAndConDetail;

- (IBAction)onCancelButtonClicked:(id)sender;
- (IBAction)onAcceptButtonClicked:(id)sender;

@property (weak,nonatomic) NSString *pConditionDetail;
@property (weak,nonatomic) NSString *pNid;

@end
