//
//  EfilingPrintFormAndReceiptViewController.h
//  RDSmartTax
//
//  Created by fone on 12/26/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENPrintFormReceiptService.h"
#import "PagedFlowView.h"

@interface EfilingPrintFormAndReceiptViewController : HeaderViewController<ENPrintFormReceiptServiceDelegate, PagedFlowViewDelegate,PagedFlowViewDataSource> {
}
@property (nonatomic) ENPrintFormReceiptService *enPrintFormReceiptService;
@property (weak, nonatomic) IBOutlet UIView *pHeaderView;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *btnForm;
@property (weak, nonatomic) IBOutlet UIButton *btnReceipt;
@property (weak, nonatomic) IBOutlet PagedFlowView *hFlowView;
@property (nonatomic, strong) IBOutlet UIPageControl *hPageControl;
- (IBAction)pageControlValueDidChange:(id)sender;

- (IBAction)onButtonPrintFormClicked:(id)sender;
- (IBAction)onButtonPrintReceiptClicked:(id)sender;

@property (nonatomic, assign) BOOL pIsReceipt;

@end
