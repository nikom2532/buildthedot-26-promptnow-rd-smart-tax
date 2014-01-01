//
//  ENgetPnd91CalTax.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 12/28/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ENgetPnd91CalTaxDelegate <NSObject>

-(void)responseENgetPnd91CalTaxService:(NSData*)data;

@end
@interface ENgetPnd91CalTax : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property (strong,nonatomic) id <ENgetPnd91CalTaxDelegate> delegate;

- (void) requestENgetPnd91CalTaxService;

@end
