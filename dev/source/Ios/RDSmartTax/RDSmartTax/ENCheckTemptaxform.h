//
//  ENCheckTemptaxform.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/4/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENCheckTemptaxformDelegate <NSObject>

-(void)responseENCheckTemptaxformService:(NSDictionary*)data;

@end
@interface ENCheckTemptaxform : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENCheckTemptaxformDelegate> delegate;

- (void) requestENCheckTemptaxformService;

@end
