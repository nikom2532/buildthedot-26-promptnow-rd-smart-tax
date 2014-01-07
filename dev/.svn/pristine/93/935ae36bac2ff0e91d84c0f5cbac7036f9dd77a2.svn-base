//
//  ENConfirmQuestion.h
//  RDSmartTax
//
//  Created by Noi on 12/16/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@protocol ENConfirmQuestionServiceDelegate <NSObject>

-(void)responseENConfirmQuestionService:(NSDictionary*)data;

@end

@interface ENConfirmQuestionService : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>{
    Susanoo *susanooObject;
}
@property (strong,nonatomic) id <ENConfirmQuestionServiceDelegate> delegate;

- (void) requestENConfirmQuestion : (NSString *) nid
                           answer : (NSString *) answer
                       questionId : (NSString *) questionId;
@end
