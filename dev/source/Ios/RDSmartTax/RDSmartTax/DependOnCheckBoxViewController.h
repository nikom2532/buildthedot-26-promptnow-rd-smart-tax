//
//  DependOnCheckBoxViewController.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 12/23/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EcheckBox.h"
@interface DependOnCheckBoxViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet EcheckBox *checkboxButton;
@property (strong, nonatomic) NSString *identify;
@end
