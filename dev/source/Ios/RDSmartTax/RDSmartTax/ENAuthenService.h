//
//  ENAuthenService.h
//  RDSmartTax
//
//  Created by fone on 12/4/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENAuthenServiceDelegate <NSObject>

-(void)responseENAuthenService:(NSDictionary*)data;

@end

@interface ENAuthenService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}
@property (strong,nonatomic) id <ENAuthenServiceDelegate> delegate;

- (void) requestENAuthenServiceWithUserId : (NSString *) userId
                                  password: (NSString *) password;

@end
