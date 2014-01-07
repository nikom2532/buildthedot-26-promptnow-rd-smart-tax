//
//  EfilingPrintFormAndReceiptViewController.h
//  RDSmartTax
//
//  Created by fone on 12/26/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENPrintFormReceiptService.h"

@interface EfilingPrintFormAndReceiptViewController : HeaderViewController<ENPrintFormReceiptServiceDelegate>

@property (weak, nonatomic) IBOutlet UIView *pHeaderView;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *btnForm;
@property (weak, nonatomic) IBOutlet UIButton *btnReceipt;
@property (weak, nonatomic) IBOutlet UIButton *btnLastYear;
@property (weak, nonatomic) IBOutlet UIButton *btnCurrentYear;

- (IBAction)onButtonPrintFormClicked:(id)sender;
- (IBAction)onButtonPrintReceiptClicked:(id)sender;
- (IBAction)onButtonLastYearClicked:(id)sender;
- (IBAction)onButtonCurrentYearClicked:(id)sender;

//- (IBAction)segmentedControlIndexChanged:(id)sender;

@property (nonatomic, assign) BOOL pIsReceipt;

@end
