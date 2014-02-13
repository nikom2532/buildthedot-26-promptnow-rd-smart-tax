//
//  ENPrintFormReceiptService.h
//  RDSmartTax
//
//  Created by fone on 12/15/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENPrintFormReceiptServiceDelegate <NSObject>

-(void)responseENPrintFormReceiptService:(NSDictionary*)data;

@end

@interface ENPrintFormReceiptService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}
@property (strong,nonatomic) id <ENPrintFormReceiptServiceDelegate> delegate;

- (void) requestENPrintFormReceiptServiceWithNid : (NSString *) nid
                                       authenKey : (NSString *) authenKey
                                        formCode : (NSString *) formCode
                                        formType : (NSString *) formType
                                         taxYear : (NSString *) taxYear;

@end
