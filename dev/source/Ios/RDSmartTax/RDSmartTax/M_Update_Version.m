//
//  M_Update_Version.m
//
//  Created by Promptnow MacMini1 on 5/13/13.
//  Copyright (c) 2013 Promptnow. All rights reserved.
//
#import "M_Update_Version.h"
#import "AppDelegate.h"

@implementation M_Update_Version
@synthesize responseDictionary;
@synthesize delegate;
@synthesize errorTitle;
@synthesize errorDescription;


-(id)init
{
    self = [super init];
    if(self)
    {
        susanooObject = [[Susanoo alloc] init];
        [susanooObject setDelegate:self];
    }
    return self;
}


#pragma mark - Send Request

-(void)sendRequest
{
    
    NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"BA6000671", @"username_active",
                                 @"TH", @"language",
                                 @"", @"deviceID",
                                 [[UIDevice currentDevice] model], @"deviceType",
                                 @"1.0.0", @"client_version",
                                 nil];
    
    if ([NSJSONSerialization isValidJSONObject:requestData]) {
        
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&error];
        
        [susanooObject sendRequestToService:@"client-update.service" withJSONData:postData];
    }
}

#pragma mark - Susanoo Delegate
-(void)susanooConnectionDidStart:(SusanooRequest *)request
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [delegate UpdateVersionConnectionDidStart:self];
}

-(void)susanooConnectionDidMakeProgress:(SusanooRequest *)request
{
    [delegate UpdateVersionConnectionDidMakeProgress:self];
}

-(void)susanooConnectionDidFinish:(SusanooResponse *)response
{
    NSError *error = nil;
    
    //JLLog(@"SUSANOO RESPONSE = %@",response.responseData);
    
    responseDictionary = response.responseData;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if(!error)
    {
        
        if([[responseDictionary objectForKey:@"responseStatus"] isEqualToString:@"SUCCESS"])
        {
            
            [delegate UpdateVersionConnectionDidFinish:self];
        }
        else if([[responseDictionary objectForKey:@"responseStatus"] isEqualToString:@"Timeout"])
        {
            errorTitle = nil;
            errorDescription = [NSString stringWithFormat:@"%@",[responseDictionary objectForKey:@"Description"]];
            [delegate UpdateVersionConnectionDidTimeout:self];
        }
        else
        {
            //            errorTitle = [NSString stringWithFormat:@"%@",[responseDictionary objectForKey:@"Response"]];
            errorTitle = nil;
            errorDescription = [NSString stringWithFormat:@"%@",[responseDictionary objectForKey:@"Description"]];
            [delegate UpdateVersionConnectionDidFail:self];
        }
    }
    else
    {
        [delegate UpdateVersionConnectionDidFail:self];
    }
}

-(void)susanooConnectionDidFail:(SusanooResponse *)response
{
   //JLLog(@"%@",response.responseHeader);
    
    
    [delegate UpdateVersionConnectionDidFail:self];
}
-(void)susanooConnectionDidTimeout:(SusanooResponse *)response
{
   //JLLog(@"%@",response.responseHeader);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [delegate UpdateVersionConnectionDidTimeout:self];
}

@end