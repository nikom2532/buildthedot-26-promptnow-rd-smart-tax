//
//  ENGetSuggestionDetail.m
//  RDSmartTax
//
//  Created by Noi on 12/30/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "ENGetSuggestionDetail.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"
#import "ShareUserDetail.h"

#define kServiceUrl @"http://kimhun55.com/llnun/TestServiceRD/susanoo/getInstructionsDetail.json"

@implementation ENGetSuggestionDetail{
     NSData *receivedData;
}
- (void) requestENGetSuggestionDetailService: (NSString *) Id{
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kServiceUrl]];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"postValues" forHTTPHeaderField:@"METHOD"];
    
    //-- create data that will be sent in the post
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:Id forKey:@"Id"];
    
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
    [self.delegate responseENGetSuggestionDetailService:receivedData]; //send the data to the delegate
}


@end
