//
//  M_Login.m
//
//  Created by Promptnow MacMini1 on 5/14/13.
//  Copyright (c) 2013 Promptnow. All rights reserved.
//

#import "M_Login.h"
#import "AppDelegate.h"


@implementation M_Login
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

-(void)sendRequestWithUserName:(NSString *)username Password:(NSString *)password{

    NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 username, @"username",
                                 password, @"password",
                                 @"TH", @"language",
                                 @"", @"diviceID",
                                 [[UIDevice currentDevice] model], @"deviceType",
                                 @"1.0.0", @"deviceOSversion",
                                 @"100.0", @"latitude",
                                 @"100.0", @"longitude",
                                 nil];
    
    
    if ([NSJSONSerialization isValidJSONObject:requestData]) {
        
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&error];
        
        [susanooObject sendSecuredRequestToService:@"login.service" withJSONData:postData];
    }
    
  }

#pragma mark - Susanoo Delegate
-(void)susanooConnectionDidStart:(SusanooRequest *)request
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [delegate LoginServiceConnectionDidStart:self];
}

-(void)susanooConnectionDidMakeProgress:(SusanooRequest *)request
{
    [delegate LoginServiceConnectionDidMakeProgress:self];
}

-(void)susanooConnectionDidFinish:(SusanooResponse *)response
{
    NSError *error = nil;
    
   NSLog(@"SUSANOO RESPONSE LOGIN = %@",response.responseData);
    
    responseDictionary = response.responseData;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    if(!error)
    {
        
        if([[responseDictionary objectForKey:@"responseStatus"] isEqualToString:@"SUCCESS"])
        {
            
            [delegate LoginServiceConnectionDidFinish:self];
        }else if([[responseDictionary objectForKey:@"responseStatus"] isEqualToString:@"ERROR"]){
            
            [delegate LoginServiceConnectionDidFail:self];
            
        }else if([[responseDictionary objectForKey:@"responseStatus"] isEqualToString:@"Timeout"])
        {
            errorTitle = nil;
            errorDescription = [NSString stringWithFormat:@"%@",[responseDictionary objectForKey:@"Description"]];
            [delegate LoginServiceConnectionDidTimeout:self];
        }
        else
        {
            //            errorTitle = [NSString stringWithFormat:@"%@",[responseDictionary objectForKey:@"Response"]];
            errorTitle = nil;
            errorDescription = [NSString stringWithFormat:@"%@",[responseDictionary objectForKey:@"Description"]];
            [delegate LoginServiceConnectionDidFail:self];
        }
    }
    else
    {
         [delegate LoginServiceConnectionDidFail:self];
    }
}

-(void)susanooConnectionDidFail:(SusanooResponse *)response
{
   //JLLog(@"%@",response.responseData);
    
    
     [delegate LoginServiceConnectionDidFail:self];
}
-(void)susanooConnectionDidTimeout:(SusanooResponse *)response
{
   //JLLog(@"%@",response.responseData);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [delegate LoginServiceConnectionDidTimeout:self];
}

@end
