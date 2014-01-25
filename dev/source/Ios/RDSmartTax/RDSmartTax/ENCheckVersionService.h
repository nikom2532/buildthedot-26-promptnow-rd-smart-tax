//
//  ENCheckVersionService.h
//  RDSmartTax
//
//  Created by fone on 1/16/57 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@protocol ENCheckVersionServiceDelegate <NSObject>

-(void)responseENCheckVersionService:(NSDictionary*)data;

@end

@interface ENCheckVersionService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}
@property (strong,nonatomic) id <ENCheckVersionServiceDelegate> delegate;

- (void) requestENCheckVersionService : (NSString *) version;

@end
