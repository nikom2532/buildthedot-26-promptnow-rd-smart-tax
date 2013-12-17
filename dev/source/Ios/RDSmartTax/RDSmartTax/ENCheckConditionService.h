//
//  ENCheckConditionService.h
//  RDSmartTax
//
//  Created by fone on 12/14/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ENCheckConditionServiceDelegate <NSObject>

-(void)responseENCheckConditionService:(NSData*)data;

@end

@interface ENCheckConditionService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENCheckConditionServiceDelegate> delegate;

- (void) requestENCheckConditionServiceWithNid : (NSString *) nid;

@end