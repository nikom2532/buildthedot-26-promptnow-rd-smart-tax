//
//  TaxStep2ViewController.h
//  TaxEasy
//
//  Created by saritwat anutakonpatipan on 12/8/2556 BE.
//  Copyright (c) 2556 Tax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
@interface TaxStep2ViewController : UIViewController <UIGestureRecognizerDelegate>
{
    __weak IBOutlet UIScrollView *scrollView;
    IBOutlet UIView *nextView;
    
}
@property (nonatomic,strong) NSMutableArray *formsArray;
@property (nonatomic,strong) NSMutableDictionary *sharedData;

- (IBAction)nextClicked:(id)sender;
@end
