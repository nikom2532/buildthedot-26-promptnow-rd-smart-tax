//
//  ENLogoutService.h
//  RDSmartTax
//
//  Created by fone on 1/13/57 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@protocol ENLogoutServiceDelegate <NSObject>

-(void)responseENLogoutService:(NSDictionary*)data;

@end

@interface ENLogoutService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}
@property (strong,nonatomic) id <ENLogoutServiceDelegate> delegate;

- (void) requestENLogoutServiceWithNid : (NSString *) nid;

@end
