//
//  ENAuthenService.h
//  RDSmartTax
//
//  Created by fone on 12/4/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ENAuthenServiceDelegate <NSObject>

-(void)responseENAuthenService:(NSData*)data;

@end

@interface ENAuthenService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENAuthenServiceDelegate> delegate;

- (void) requestENAuthenServiceWithUserId : (NSString *) userId
                                  password: (NSString *) password;

@end
