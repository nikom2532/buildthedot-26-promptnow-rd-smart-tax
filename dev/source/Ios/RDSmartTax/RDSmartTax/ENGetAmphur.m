//
//  ENGetAmphur.m
//  RDSmartTax
//
//  Created by Noi on 1/9/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import "ENGetAmphur.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"

@implementation ENGetAmphur{
    NSDictionary *receivedData;
}
- (void) requestENGetAmphur: (NSString *) province_id
{
    susanooObject = [[Susanoo alloc] init];
    [susanooObject setDelegate:self];
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    
    //-- create data that will be sent in the post
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:[Util loadAppSettingWithName:@"Session"] forKey:@"sessionID"];
    NSString *lang;
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        lang = @"TH";
    } else {
        lang = @"EN";
    }
    [dictionary setValue:lang forKey:@"language"];
    [dictionary setValue:@"" forKey:@"latitude"];
    [dictionary setValue:@"" forKey:@"longitude"];
    [dictionary setValue:[OpenUDID value] forKey:@"deviceID"];
    [dictionary setValue:[Util loadAppSettingWithName:@"DeviceType"] forKey:@"deviceType"];
    [dictionary setValue:province_id forKey:@"province_id"];
    
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
        
        [susanooObject sendSecuredRequestToService:@"rq-amphur.service" withJSONData:postData];
    }
    
    
}

-(void)susanooConnectionDidStart:(SusanooRequest *)request
{
    JLLog(@"start");
    
}
-(void)susanooConnectionDidMakeProgress:(SusanooRequest *)request
{
    JLLog(@"make Progress");
    
}
-(void)susanooConnectionDidFinish:(SusanooResponse *)response
{
    JLLog(@"finish");
    receivedData = response.responseData;
    [_delegate responseENGetAmphur:receivedData];
    [SVProgressHUD dismiss];
}
-(void)susanooConnectionDidFail:(SusanooResponse *)response
{
    JLLog(@"fail");
    receivedData = response.responseData;
    [_delegate responseENGetAmphur:receivedData];
    [SVProgressHUD dismiss];
}
-(void)susanooConnectionDidTimeout:(SusanooResponse *)response
{
    //    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    JLLog(@"time out");
    [SVProgressHUD dismiss];
}


@end
