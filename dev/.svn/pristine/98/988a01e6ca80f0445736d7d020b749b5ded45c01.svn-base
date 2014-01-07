//
//  ENSaveTemplate.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/4/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENSaveTemplateDelegate <NSObject>

-(void)responseENSaveTemplateService:(NSDictionary*)data;

@end
@interface ENSaveTemplate : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENSaveTemplateDelegate> delegate;

- (void) requestENSaveTemplateService;

@end
