//
//  ENResetPasswordRequest.h
//  RDSmartTax
//
//  Created by Noi on 12/16/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ENResetPasswordRequestServiceDelegate <NSObject>

-(void)responseENResetPasswordRequestService:(NSData*)data;

@end

@interface ENResetPasswordRequestService : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENResetPasswordRequestServiceDelegate> delegate;

- (void) requestENResetPasswordRequestService : (NSString *) nid
                                    birthDate : (NSString *) birthDate
                                      version : (NSString *) version;
@end
