//
//  EfilingArrearViewController.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 12/31/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EfilingArrearViewController : HeaderViewController
{
    IBOutlet UIView *detailView;
    
    __weak IBOutlet UIScrollView *scrollView;
    
    __weak IBOutlet UILabel *headerLabel;
    
    __weak IBOutlet UILabel *taxidHLabel;
    __weak IBOutlet UILabel *taxidLabel;
    __weak IBOutlet UILabel *refHLabel;
    __weak IBOutlet UILabel *refLabel;
    __weak IBOutlet UILabel *dateHLabel;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UILabel *taxpayHLabel;
    __weak IBOutlet UILabel *taxpayLabel;
}
- (IBAction)paymentClicked:(id)sender;
- (IBAction)cancelClicked:(id)sender;
- (IBAction)showPnd91Clicked:(id)sender;

@end
