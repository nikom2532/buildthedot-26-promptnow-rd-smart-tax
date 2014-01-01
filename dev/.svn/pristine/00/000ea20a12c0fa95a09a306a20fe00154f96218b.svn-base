//
//  ENChangePassword.h
//  RDSmartTax
//
//  Created by Noi on 12/21/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ENChangePasswordServiceDelegate <NSObject>

-(void)responseENChangePasswordService:(NSData*)data;

@end

@interface ENChangePassword : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENChangePasswordServiceDelegate> delegate;
- (void) requestENChangePasswordService : (NSString *) userId
                            oldPassword : (NSString *) oldPassword
                            newPassword : (NSString *) newPassword
                                version : (NSString *) version;

@end
