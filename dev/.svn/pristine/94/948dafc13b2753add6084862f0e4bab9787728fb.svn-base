//
//  ENGetTemplate.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/4/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENGetTemplateDelegate <NSObject>

-(void)responseENGetTemplateService:(NSDictionary*)data;

@end
@interface ENGetTemplate : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENGetTemplateDelegate> delegate;

- (void) requestENGetTemplateService;

@end
