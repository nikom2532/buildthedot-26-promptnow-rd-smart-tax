//
//  ENResetPasswordConfirm.h
//  RDSmartTax
//
//  Created by Noi on 12/16/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@protocol ENResetPasswordConfirmServiceDelegate <NSObject>

-(void)responseENResetPasswordConfirmService:(NSDictionary*)data;

@end
@interface ENResetPasswordConfirmService : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENResetPasswordConfirmServiceDelegate> delegate;

- (void) requestENResetPasswordConfirmService : (NSString *) nid
                                         email : (NSString *) email;

@end
