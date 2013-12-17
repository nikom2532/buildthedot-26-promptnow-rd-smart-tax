//
//  EfilingPrintViewController.h
//  RDSmartTax
//
//  Created by fone on 12/15/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENPrintFormReceiptService.h"

@interface EfilingPrintViewController : UIViewController<ENPrintFormReceiptServiceDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)segmentedControlIndexChanged:(id)sender;

@property (nonatomic, assign) BOOL pIsReceipt;

@end
