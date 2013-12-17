//
//  ENCheckLoginFirstService.h
//  RDSmartTax
//
//  Created by fone on 12/11/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ENCheckLoginFirstServiceDelegate <NSObject>

-(void)responseENCheckLoginFirstService:(NSData*)data;

@end

@interface ENCheckLoginFirstService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENCheckLoginFirstServiceDelegate> delegate;

- (void) requestENCheckLoginFirstServiceWithNid : (NSString *) nid;

@end