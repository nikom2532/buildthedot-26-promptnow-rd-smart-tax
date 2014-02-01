//
//  ENCheckNewUserService.h
//  RDSmartTax
//
//  Created by fone on 12/4/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@protocol ENCheckNewUserServiceDelegate <NSObject>

-(void)responseENCheckNewUserService:(NSDictionary*)data;

@end

@interface ENCheckNewUserService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
     Susanoo *susanooObject;
}
@property (strong,nonatomic) id <ENCheckNewUserServiceDelegate> delegate;

- (void) requestENCheckNewUserServiceWithIdCard : (NSString *) idCard;

@end

