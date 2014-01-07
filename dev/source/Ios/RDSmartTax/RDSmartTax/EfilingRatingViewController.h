//
//  EfilingRatingViewController.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 12/22/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EfilingRatingViewController : HeaderViewController
{
    
    __weak IBOutlet UILabel *headerLabel;
    __weak IBOutlet UILabel *statusLabel;
}
- (IBAction)voteClicked:(UIButton *)sender;
- (IBAction)sliderChange:(UISlider *)sender;

- (IBAction)sendDataClicked:(id)sender;
@end
