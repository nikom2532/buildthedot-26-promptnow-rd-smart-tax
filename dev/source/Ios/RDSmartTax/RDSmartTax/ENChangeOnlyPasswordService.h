//
//  ENChangeOnlyPassword.h
//  RDSmartTax
//
//  Created by Noi on 12/16/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ENChangeOnlyPasswordServiceDelegate <NSObject>
-(void)responseENChangeOnlyPasswordService:(NSData*)data;

@end

@interface ENChangeOnlyPasswordService : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property (strong,nonatomic) id <ENChangeOnlyPasswordServiceDelegate> delegate;

- (void) requestENChangeOnlyPasswordService      : (NSString *) nid
                                        password : (NSString *) password
                                         version : (NSString *) version;
@end
