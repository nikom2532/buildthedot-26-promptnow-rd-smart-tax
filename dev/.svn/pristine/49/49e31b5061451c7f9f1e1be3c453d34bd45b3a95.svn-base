//
//  ENUpdatePnd91.m
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/1/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import "ENUpdatePnd91.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"
#import "ShareUserDetail.h"
#define kServiceUrl @"http://kimhun55.com/llnun/TestServiceRD/mobile/pnd91/updatePnd91CalTax.json"
@implementation ENUpdatePnd91
{
    NSDictionary *receivedData;
}

- (void) requestENUpdatePnd91ServiceWithAPIReferenceNo:(NSString*)apirefno DataPnd:(NSDictionary*)dataPnd
{
//    susanooObject = [[Susanoo alloc] init];
//    [susanooObject setDelegate:self];
    
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kServiceUrl]];
    
    [request setHTTPMethod:@"GET"];
    //    [request addValue:@"postValues" forHTTPHeaderField:@"METHOD"];
    
    //-- create data that will be sent in the post
    //    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    //    [dictionary setValue:[Util loadAppSettingWithName:@"Version"] forKey:@"version"];
    
    //-- serialize the dictionary data as json
    //    NSData *data = [[dictionary copy] JSONValue];
    
    //    //-- set the data as the post body
    //    [request setHTTPBody:data];
    //    [request addValue:[NSString stringWithFormat:@"%d",data.length] forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        NSLog(@"Connection Failed");
    }
    
//    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
//    [dictionary setValue:[Util loadAppSettingWithName:@"Session"] forKey:@"sessionID"];
//    NSString *lang;
//    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
//        lang = @"TH";
//    } else {
//        lang = @"EN";
//    }
//    [dictionary setValue:lang forKey:@"language"];
//    [dictionary setValue:@"" forKey:@"latitude"];
//    [dictionary setValue:@"" forKey:@"longitude"];
//    [dictionary setValue:[OpenUDID value] forKey:@"deviceID"];
//    [dictionary setValue:[Util loadAppSettingWithName:@"DeviceType"] forKey:@"deviceType"];
//    
//    [dictionary setValue:[ShareUserDetail retrieveDataWithStringKey:@"nid"] forKey:@"nid"];
//    [dictionary setValue:[ShareUserDetail retrieveDataWithStringKey:@"authenKey"] forKey:@"authenKey"];
//    [dictionary setValue:apirefno forKey:@"apiRefNo"];
//    [dictionary setValue:dataPnd forKey:@"keys"];
//
//
//    
//    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
//        NSError *error;
//        NSData *postData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
//        
//        [susanooObject sendSecuredRequestToService:@"fl-update-pnd91caltax.service" withJSONData:postData];
//    }

}
//-(void)susanooConnectionDidStart:(SusanooRequest *)request
//{
//    JLLog(@"start");
//    
//}
//-(void)susanooConnectionDidMakeProgress:(SusanooRequest *)request
//{
//    JLLog(@"make Progress");
//    
//}
//-(void)susanooConnectionDidFinish:(SusanooResponse *)response
//{
//    JLLog(@"finish");
//    receivedData = response.responseData;
//    [_delegate responseENUpdatePnd91Service:receivedData];
//    [SVProgressHUD dismiss];
//    
//}
//-(void)susanooConnectionDidFail:(SusanooResponse *)response
//{
//    JLLog(@"fail");
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:response.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alert show];
//}

#pragma mark - Data connection delegate -
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    receivedData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];//data;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Connection failed with error: %@",error.localizedDescription);
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [SVProgressHUD dismiss];
    [self.delegate responseENUpdatePnd91Service:receivedData]; //send the data to the delegate
}

@end
