//
//  HeaderViewController.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/1/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderViewController : UIViewController
{
    __weak IBOutlet UIView *headerView;
    
}
@property (nonatomic,weak) Header *header;
@end
