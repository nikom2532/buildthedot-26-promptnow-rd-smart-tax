//
//  EfilingTaxPaymentOtherViewController.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 12/31/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EfilingTaxPaymentOtherViewController : HeaderViewController
{
    __weak IBOutlet UIScrollView *scrollviewATM;
    __weak IBOutlet UILabel *headerLabel;

    __weak IBOutlet UILabel *taxidHLabel;
    __weak IBOutlet UILabel *taxidLabel;
    __weak IBOutlet UILabel *amountHLabel;
    __weak IBOutlet UILabel *amountLabel;
    __weak IBOutlet UILabel *controlHLabel;
    __weak IBOutlet UILabel *controlLabel;
    __weak IBOutlet UILabel *footerLabel;
}
@property (nonatomic) NSDictionary *resposeData;
@end
