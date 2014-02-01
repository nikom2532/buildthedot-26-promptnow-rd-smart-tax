//
//  EfilingTaxPaymentViewController.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 12/22/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENUpdatePnd91.h"

@interface EfilingTaxPaymentViewController : HeaderViewController<ENgetENUpdatePnd91Delegate>
{
    __weak IBOutlet UIScrollView *scrollview;
    IBOutlet UIView *detailview;
    __weak IBOutlet UILabel *pHeaderLabel;
    __weak IBOutlet UILabel *pRefHLabel;
    __weak IBOutlet UILabel *pRefLabel;
    __weak IBOutlet UILabel *pYearHLabel;
    __weak IBOutlet UILabel *pYearLabel;
    __weak IBOutlet UILabel *pDateHLabel;
    __weak IBOutlet UILabel *pDateLabel;
    __weak IBOutlet UILabel *pTaxAmountHLabel;
    __weak IBOutlet UILabel *pTaxAmountLabel;
    __weak IBOutlet UILabel *pThankLabel;
    __weak IBOutlet UILabel *titleHLabel;
    __weak IBOutlet UIButton *printButton;
    
    __weak IBOutlet UILabel *refnoHLabel;
    __weak IBOutlet UILabel *refnoLabel;
    
    __weak IBOutlet UILabel *payTypeHLabel;
    __weak IBOutlet UILabel *payTypeLabel;
    
    __weak IBOutlet UILabel *payDateHLabel;
    __weak IBOutlet UILabel *payDateLabel;
    
    __weak IBOutlet UILabel *listTaxHLabel;
    __weak IBOutlet UILabel *numberOfTaxHLabel;
    __weak IBOutlet UILabel *numberOfTaxLabel;
    
    __weak IBOutlet UILabel *controlNumberHLabel;
    __weak IBOutlet UILabel *controlNumberLabel;
    __weak IBOutlet UILabel *amountHLabel;
    __weak IBOutlet UILabel *amountLabel;
    
    __weak IBOutlet UILabel *cateOfPayHLabel;
    
    
    __weak IBOutlet UITableView *payTableView;
    IBOutlet UIView *isZeroView;
    __weak IBOutlet UILabel *zHeaderLabel;
    __weak IBOutlet UILabel *zRefHLabel;
    __weak IBOutlet UILabel *zRefLabel;
    __weak IBOutlet UILabel *zYearHLabel;
    __weak IBOutlet UILabel *zYearLabel;
    __weak IBOutlet UILabel *zDateHLabel;
    __weak IBOutlet UILabel *zDateLabel;
    __weak IBOutlet UILabel *zTaxAmountHLabel;
    __weak IBOutlet UILabel *zTaxAmountLabel;
    __weak IBOutlet UILabel *zThankLabel;
    
    __weak IBOutlet UIButton *zNextButton;
 
    __weak IBOutlet UIButton *pNextButton;
    
    __weak IBOutlet UILabel *logo1Label;
    __weak IBOutlet UILabel *logo2Label;
    __weak IBOutlet UILabel *logo3Label;
    __weak IBOutlet UILabel *logo4Label;
    __weak IBOutlet UILabel *logo5Label;
    
}

@property (nonatomic) NSString *formPage;
- (IBAction)printClicked:(id)sender;
- (IBAction)nextClicked:(id)sender;
- (IBAction)paymentClicked:(UIButton *)sender;

@end
