//
//  ENUpdatePnd91.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/1/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ENgetENUpdatePnd91Delegate <NSObject>

-(void)responseENUpdatePnd91Service:(NSData*)data;

@end
@interface ENUpdatePnd91 : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property (strong,nonatomic) id <ENgetENUpdatePnd91Delegate> delegate;

- (void) requestENUpdatePnd91Service;

@end
