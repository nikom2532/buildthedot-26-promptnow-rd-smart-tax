//
//  ENSaveConditionFillingFirstService.h
//  RDSmartTax
//
//  Created by fone on 12/11/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ENSaveConditionFillingFirstServiceDelegate <NSObject>

-(void)responseENSaveConditionFillingFirstService:(NSData*)data;

@end

@interface ENSaveConditionFillingFirstService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENSaveConditionFillingFirstServiceDelegate> delegate;

- (void) requestENSaveConditionFillingFirstServiceWithNid : (NSString *) nid;

@end