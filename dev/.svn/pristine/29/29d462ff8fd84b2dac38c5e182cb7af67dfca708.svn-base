//
//  ENCheckStatusService.h
//  RDSmartTax
//
//  Created by fone on 12/19/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@class ENCheckStatusService;

@protocol ENCheckStatusServiceDelegate <NSObject>

-(void)ENCheckStatusServiceConnectionDidStart:(ENCheckStatusService *)sender;
-(void)ENCheckStatusServiceConnectionDidMakeProgress:(ENCheckStatusService *)sender;
-(void)ENCheckStatusServiceConnectionDidFinish:(ENCheckStatusService *)sender;
-(void)ENCheckStatusServiceConnectionDidFail:(ENCheckStatusService *)sender;
-(void)ENCheckStatusServiceConnectionDidTimeout:(ENCheckStatusService *)sender;

-(void)responseENCheckStatusService:(NSDictionary*)data;

@end

@interface ENCheckStatusService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENCheckStatusServiceDelegate> delegate;

- (void) requestENCheckStatusServiceWithNid : (NSString *) nid
                                  authenKey : (NSString *) authenKey
                                    version : (NSString *) version
                                       name : (NSString *) name
                                    surname : (NSString *) surname;

@end
