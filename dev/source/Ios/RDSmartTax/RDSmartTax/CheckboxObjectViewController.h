//
//  CheckboxObjectViewController.h
//  TaxEasy
//
//  Created by saritwat anutakonpatipan on 12/8/2556 BE.
//  Copyright (c) 2556 Tax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EcheckBox.h"
@interface CheckboxObjectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet EcheckBox *checkboxButton;
@property (strong, nonatomic) NSString *identify;

@end
