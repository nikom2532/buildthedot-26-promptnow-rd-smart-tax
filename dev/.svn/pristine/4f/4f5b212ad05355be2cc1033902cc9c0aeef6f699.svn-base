//
//  ENPrintFormReceiptService.h
//  RDSmartTax
//
//  Created by fone on 12/15/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ENPrintFormReceiptServiceDelegate <NSObject>

-(void)responseENPrintFormReceiptService:(NSData*)data;

@end

@interface ENPrintFormReceiptService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENPrintFormReceiptServiceDelegate> delegate;

- (void) requestENPrintFormReceiptServiceWithNid : (NSString *) nid
                                         version : (NSString *) version
                                       authenKey : (NSString *) authenKey
                                        formCode : (NSString *) formCode
                                        formType : (NSString *) formType
                                         taxYear : (NSString *) taxYear;

@end
