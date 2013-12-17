//
//  ENgetFormPnd91.h
//  TaxEasy
//
//  Created by Tax on 7/12/56.
//  Copyright (c) พ.ศ. 2556 Tax. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ENgetFormPnd91Delegate <NSObject>

-(void)responseENgetFormPnd91Service:(NSData*)data;

@end


@interface ENgetFormPnd91 : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property (strong,nonatomic) id <ENgetFormPnd91Delegate> delegate;

- (void) requestENgetFormPnd91Service;

@end
