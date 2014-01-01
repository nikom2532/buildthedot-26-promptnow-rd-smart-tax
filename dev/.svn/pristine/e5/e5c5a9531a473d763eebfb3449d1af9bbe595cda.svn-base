//
//  M_GetKeyExchange.m
//  SCB
//
//  Created by Teeraphan Jaroenpitak on 3/26/12.
//  Copyright (c) 2012 Jorlek Co., Ltd. All rights reserved.
//

#import "M_GetKeyExchange.h"

@implementation M_GetKeyExchange
@synthesize delegate;
@synthesize errorTitle;
@synthesize errorDescription;

-(id)init
{
    self = [super init];
    if(self)
    {
        susanooObject = [[Susanoo alloc] init];
        [susanooObject setKeyDelegate:self];
    }
    return self;
}


-(void)sendRequest
{
    NSLog(@"======================================================");
    NSLog(@"Getting Keyexchange...");
    [susanooObject getKeyExchange];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [delegate keyExchangeConnectionDidStart:self];
}


-(void)getKeyExchageDidFinish:(NSDictionary *)result
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSLog(@"KEY EXCHANGE FINISH");
    NSLog(@"KEY EXCHANGE = %@",result);
    
    if(result)
    {
        if([[result objectForKey:@"status"] isEqualToString:@"error"])
        {
            errorTitle = nil;
            errorDescription = [result objectForKey:@"message"];
            [delegate keyExchangeConnectionDidFail:self];
        }
        else {
            //[SCBDate addSession];
            [delegate keyExchangeConnectionDidFinish:self];
        }
    }
    else {
        errorTitle = @"Error";
        errorDescription = @"Connection Error";
        [delegate keyExchangeConnectionDidFail:self];
    }
}

-(void)susanooConnectionDidTimeout:(SusanooResponse *)response
{
    //JLLog(@"%@",response.responseData);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [delegate keyExchangeConnectionDidTimeout:self];
}

@end
