//
//  TaxStep1ViewController.h
//  TaxEasy
//
//  Created by Tax on 7/12/56.
//  Copyright (c) พ.ศ. 2556 Tax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENgetFormPnd91.h"
//#import "KeyboardViewController.h"
@interface TaxStep1ViewController : HeaderViewController <ENgetFormPnd91Delegate,UIGestureRecognizerDelegate>
{
    __weak IBOutlet UIScrollView *scrollView;
    IBOutlet UIView *nextView;
    
    IBOutlet UIView *barView;
    IBOutlet UIView *dropdownView;
    __weak IBOutlet UIButton *nextButton;
    __weak IBOutlet UITableView *tableFrom;
    __weak IBOutlet UILabel *headerLabel;
}
@property (nonatomic) ENgetFormPnd91 *engetForm;
- (IBAction)nextClicked:(id)sender;
@end
