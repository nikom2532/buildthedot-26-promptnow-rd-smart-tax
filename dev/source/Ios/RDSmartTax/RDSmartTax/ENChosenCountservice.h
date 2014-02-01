//
//  ENChosenCountservice.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/4/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENChosenCountserviceDelegate <NSObject>

-(void)responseENChosenCountserviceService:(NSDictionary*)data;

@end
@interface ENChosenCountservice : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENChosenCountserviceDelegate> delegate;

- (void) requestENChosenCountserviceServiceKeys:(NSDictionary*)keys;



@end
