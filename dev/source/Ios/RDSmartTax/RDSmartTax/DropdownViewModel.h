//
//  DropdownViewModel.h
//  RDSmartTax
//
//  Created by fone on 12/21/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EcheckBox.h"

@interface DropdownViewModel : UIView

@property (weak, nonatomic) IBOutlet UILabel *pTitle;
@property (weak, nonatomic) IBOutlet EcheckBox *pDropdownButton;
@property (weak, nonatomic) IBOutlet UIButton *pHintButton;

@end
