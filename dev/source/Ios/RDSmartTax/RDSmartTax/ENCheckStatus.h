//
//  ENCheckStatus.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/4/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENCheckStatusDelegate <NSObject>

-(void)responseENCheckStatusService:(NSDictionary*)data;

@end
@interface ENCheckStatus : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENCheckStatusDelegate> delegate;

- (void) requestENCheckStatusService;

@end
