//
//  ENSaveLoginFirstService.h
//  RDSmartTax
//
//  Created by fone on 12/11/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ENSaveLoginFirstServiceDelegate <NSObject>

-(void)responseENSaveLoginFirstService:(NSData*)data;

@end

@interface ENSaveLoginFirstService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENSaveLoginFirstServiceDelegate> delegate;

- (void) requestENSaveLoginFirstServiceWithNid : (NSString *) nid;

@end