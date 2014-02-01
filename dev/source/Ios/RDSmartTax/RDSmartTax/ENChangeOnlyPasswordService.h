//
//  ENChangeOnlyPassword.h
//  RDSmartTax
//
//  Created by Noi on 12/16/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@protocol ENChangeOnlyPasswordServiceDelegate <NSObject>
-(void)responseENChangeOnlyPasswordService:(NSDictionary*)data;

@end

@interface ENChangeOnlyPasswordService : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>{
    Susanoo *susanooObject;
}
@property (strong,nonatomic) id <ENChangeOnlyPasswordServiceDelegate,SusanooDelegate> delegate;

- (void) requestENChangeOnlyPasswordService      : (NSString *) nid
                                        password : (NSString *) password;
@end
