//
//  ENgetFormPnd91.m
//  TaxEasy
//
//  Created by Tax on 7/12/56.
//  Copyright (c) พ.ศ. 2556 Tax. All rights reserved.
//

#import "ENgetFormPnd91.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"

#define kServiceUrl @"http://kimhun55.com/llnun/TestServiceRD/mobile/pnd91/getFormPnd91.json"

@implementation ENgetFormPnd91
{
    NSData *receivedData;
}

- (void) requestENgetFormPnd91Service
{
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

}
#pragma mark - Data connection delegate -
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    receivedData = data;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Connection failed with error: %@",error.localizedDescription);
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [SVProgressHUD dismiss];
    [self.delegate responseENgetFormPnd91Service:receivedData]; //send the data to the delegate
}

@end