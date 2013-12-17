//
//  ENConfirmQuestion.h
//  RDSmartTax
//
//  Created by Noi on 12/16/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ENConfirmQuestionServiceDelegate <NSObject>

-(void)responseENConfirmQuestionService:(NSData*)data;

@end

@interface ENConfirmQuestionService : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property (strong,nonatomic) id <ENConfirmQuestionServiceDelegate> delegate;

- (void) requestENConfirmQuestion : (NSString *) nid
                           answer : (NSString *) answer
                       questionId : (NSString *) questionId
                          version : (NSString *) version;
@end
