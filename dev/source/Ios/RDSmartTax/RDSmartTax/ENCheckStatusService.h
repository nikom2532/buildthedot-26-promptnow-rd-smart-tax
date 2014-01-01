//
//  ENCheckStatusService.h
//  RDSmartTax
//
//  Created by fone on 12/19/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ENCheckStatusServiceDelegate <NSObject>

-(void)responseENCheckStatusService:(NSData*)data;

@end

@interface ENCheckStatusService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENCheckStatusServiceDelegate> delegate;

- (void) requestENCheckStatusServiceWithNid : (NSString *) nid
                                  authenKey : (NSString *) authenKey
                                    version : (NSString *) version
                                       name : (NSString *) name
                                    surname : (NSString *) surname;

@end
