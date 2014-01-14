//
//  ENgetPnd91CalTax.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 12/28/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENgetPnd91CalTaxDelegate <NSObject>

-(void)responseENgetPnd91CalTaxService:(NSDictionary*)data;

@end
@interface ENgetPnd91CalTax : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENgetPnd91CalTaxDelegate> delegate;

- (void) requestENCalTaxServiceWithAPIReferenceNo:(NSString*)apirefno DataPnd:(NSDictionary*)dataPnd;

@end
