//
//  M_GetKeyExchange.h
//  SCB
//
//  Created by Promptnow on 12/25/13.
//  Copyright (c) 2013 Promptnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@class M_GetKeyExchange;

@protocol KeyExchangeDelegate <NSObject>

-(void)keyExchangeConnectionDidStart:(M_GetKeyExchange *)sender;
-(void)keyExchangeConnectionDidFinish:(M_GetKeyExchange *)sender;
-(void)keyExchangeConnectionDidFail:(M_GetKeyExchange *)sender;
-(void)keyExchangeConnectionDidTimeout:(M_GetKeyExchange *)sender;

@end

@interface M_GetKeyExchange : NSObject <getKeyExchangeDelegate>
{
    Susanoo *susanooObject;
    
    NSString *errorTitle;
    NSString *errorDescription;
}

@property (nonatomic, retain) NSString *errorTitle;
@property (nonatomic, retain) NSString *errorDescription;
@property (nonatomic, assign) NSObject <KeyExchangeDelegate> *delegate;

-(void)sendRequest;

@end
