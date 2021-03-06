//
//  TaxStep3ViewController.h
//  TaxEasy
//
//  Created by saritwat anutakonpatipan on 12/8/2556 BE.
//  Copyright (c) 2556 Tax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaxStep3ViewController : HeaderViewController <UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    __weak IBOutlet UIScrollView *scrollView;
    IBOutlet UIView *nextView;
    __weak IBOutlet UIButton *nextButton;
    __weak IBOutlet UILabel *headerLabel;
    __weak IBOutlet UILabel *subheaderLabel;
    
}
@property (nonatomic,strong) NSMutableArray *formsArray;
@property (nonatomic,strong) NSMutableDictionary *sharedData;

- (IBAction)nextClicked:(id)sender;

@end
