//
//  EfilingTermsAndConditionsViewController.h
//  RDSmartTax
//
//  Created by fone on 12/11/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENSaveConditionFillingFirstService.h"
#import "ENCheckLoginFirstService.h"

@interface EfilingTermsAndConditionsViewController : UIViewController <ENSaveConditionFillingFirstServiceDelegate, ENCheckLoginFirstServiceDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnAccept;

- (IBAction)onCancelButtonClicked:(id)sender;
- (IBAction)onAcceptButtonClicked:(id)sender;

@property (weak,nonatomic) NSString *pConditionDetail;

@end
