//
//  ENSaveConditionFillingFirstService.h
//  RDSmartTax
//
//  Created by fone on 12/11/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENSaveConditionFillingFirstServiceDelegate <NSObject>

-(void)responseENSaveConditionFillingFirstService:(NSDictionary*)data;

@end

@interface ENSaveConditionFillingFirstService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENSaveConditionFillingFirstServiceDelegate> delegate;

- (void) requestENSaveConditionFillingFirstServiceWithNid : (NSString *) nid;

@end