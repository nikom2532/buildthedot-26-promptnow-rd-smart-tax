//
//  ENSendEmailService.h
//  RDSmartTax
//
//  Created by fone on 1/17/57 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENSendEmailServiceServiceDelegate <NSObject>

-(void)responseENSendEmailService:(NSDictionary*)data;

@end

@interface ENSendEmailService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}
@property (strong,nonatomic) id <ENSendEmailServiceServiceDelegate> delegate;

- (void) requestENSendEmailService : (NSString *) emailTo pdfLink : (NSString *) pdfLink;

@end

