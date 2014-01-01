//
//  ENCheckStatusService.m
//  RDSmartTax
//
//  Created by fone on 12/19/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "ENCheckStatusService.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"

#define kServiceUrl @"http://kimhun55.com/llnun/TestServiceRD/mobile/4serve/checkStatus.json"

@implementation ENCheckStatusService {
    NSData *receivedData;
}

- (void) requestENCheckStatusServiceWithNid : (NSString *) nid
                                  authenKey : (NSString *) authenKey
                                    version : (NSString *) version
                                       name : (NSString *) name
                                    surname : (NSString *) surname {
    
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kServiceUrl]];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"postValues" forHTTPHeaderField:@"METHOD"];
    
    //-- create data that will be sent in the post
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:nid forKey:@"nid"];
    [dictionary setValue:authenKey forKey:@"authenKey"];
    [dictionary setValue:version forKey:@"version"];
    [dictionary setValue:name forKey:@"name"];
    [dictionary setValue:surname forKey:@"surname"];
    
    //-- serialize the dictionary data as json
    NSData *data = [[dictionary copy] JSONValue];
    
    //-- set the data as the post body
    [request setHTTPBody:data];
    [request addValue:[NSString stringWithFormat:@"%d",data.length] forHTTPHeaderField:@"Content-Length"];
    
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
    [self.delegate responseENCheckStatusService:receivedData]; //send the data to the delegate
}

@end
