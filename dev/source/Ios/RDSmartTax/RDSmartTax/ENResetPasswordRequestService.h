//
//  ENResetPasswordRequest.h
//  RDSmartTax
//
//  Created by Noi on 12/16/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@protocol ENResetPasswordRequestServiceDelegate <NSObject>

-(void)responseENResetPasswordRequestService:(NSDictionary*)data;

@end

@interface ENResetPasswordRequestService : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENResetPasswordRequestServiceDelegate> delegate;

- (void) requestENResetPasswordRequestService : (NSString *) nid
                                    birthDate : (NSString *) birthDate;
@end
