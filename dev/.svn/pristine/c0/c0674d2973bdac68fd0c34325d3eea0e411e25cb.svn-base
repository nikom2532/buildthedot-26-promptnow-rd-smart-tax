//
//  ENPrintFormreceipt.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/4/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENPrintFormreceiptDelegate <NSObject>

-(void)responseENPrintFormreceiptService:(NSDictionary*)data;

@end
@interface ENPrintFormreceipt : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENPrintFormreceiptDelegate> delegate;

- (void) requestENPrintFormreceiptServiceWithFormCode:(NSString*)formcode
                                             FormType:(NSString*)formtype
                                              TaxYear:(NSString*)taxyear;

@end
