//
//  ENSaveConditionFillingFirstService.m
//  RDSmartTax
//
//  Created by fone on 12/11/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "ENSaveConditionFillingFirstService.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"
#import "ShareUserDetail.h"
#import "AppDelegate.h"
//#define kServiceUrl @"http://kimhun55.com/llnun/TestServiceRD/susanoo/check/saveConditionFillingFirst.json"

@implementation ENSaveConditionFillingFirstService {
    NSDictionary *receivedData;
}

- (void) requestENSaveConditionFillingFirstServiceWithNid : (NSString *) nid {
    
    susanooObject = [[Susanoo alloc] init];
    [susanooObject setDelegate:self];
    
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    
    //-- create data that will be sent in the post
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:nid forKey:@"nid"];
    NSLog(@"nid: %@",nid);
    

    NSString *lang;
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        lang = @"TH";
    } else {
        lang = @"EN";
    }

  
    [dictionary setValue:nid forKey:@"nid"];
    [dictionary setValue:@"" forKey:@"sessionID"];
    [dictionary setValue:lang forKey:@"language"];
    [dictionary setValue:@"" forKey:@"latitude"];
    [dictionary setValue:@"" forKey:@"longitude"];
    [dictionary setValue:[OpenUDID value] forKey:@"deviceID"];
    [dictionary setValue:[Util loadAppSettingWithName:@"DeviceType"] forKey:@"deviceType"];
    
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
        
        [susanooObject sendSecuredRequestToService:@"lg-save-termsconditionfirst.service" withJSONData:postData];
    }
//    //-- serialize the dictionary data as json
//    NSData *data = [[dictionary copy] JSONValue];
//    
//    //-- set the data as the post body
//    [request setHTTPBody:data];
//    [request addValue:[NSString stringWithFormat:@"%d",data.length] forHTTPHeaderField:@"Content-Length"];
//    
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    if(!connection){
//        NSLog(@"Connection Failed");
//    }
    
}

//#pragma mark - Data connection delegate -
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    receivedData = data;
//}
//
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
//    NSLog(@"Connection failed with error: %@",error.localizedDescription);
//}
//
//-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
//}
//
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
//    [SVProgressHUD dismiss];
//    [self.delegate responseENSaveConditionFillingFirstService:receivedData]; //send the data to the delegate
//}

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
    [_delegate responseENSaveConditionFillingFirstService:receivedData];
    [SVProgressHUD dismiss];
    
}
-(void)susanooConnectionDidFail:(SusanooResponse *)response
{
    JLLog(@"fail");
    receivedData = response.responseData;
    [_delegate responseENSaveConditionFillingFirstService:receivedData];
    [SVProgressHUD dismiss];
}
-(void)susanooConnectionDidTimeout:(SusanooResponse *)response
{
    //    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    JLLog(@"time out");
    [SVProgressHUD dismiss];
}

@end
