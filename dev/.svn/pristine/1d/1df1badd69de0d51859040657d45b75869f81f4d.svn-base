//
//  ENResetPasswordConfirm.h
//  RDSmartTax
//
//  Created by Noi on 12/16/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ENResetPasswordConfirmServiceDelegate <NSObject>

-(void)responseENResetPasswordConfirmService:(NSData*)data;

@end
@interface ENResetPasswordConfirmService : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENResetPasswordConfirmServiceDelegate> delegate;

- (void) requestENResetPasswordConfirmService : (NSString *) nid
                                         email : (NSString *) email
                                       version : (NSString *) version;

@end
