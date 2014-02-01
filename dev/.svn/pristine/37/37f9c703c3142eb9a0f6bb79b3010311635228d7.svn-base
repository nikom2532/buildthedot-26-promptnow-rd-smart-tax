//
//  ENUpdatePnd91.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/1/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENgetENUpdatePnd91Delegate <NSObject>

-(void)responseENUpdatePnd91Service:(NSDictionary*)data;

@end
@interface ENUpdatePnd91 : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}
@property (strong,nonatomic) id <ENgetENUpdatePnd91Delegate> delegate;

- (void) requestENUpdatePnd91ServiceWithAPIReferenceNo:(NSString*)apirefno DataPnd:(NSDictionary*)dataPnd;

@end
