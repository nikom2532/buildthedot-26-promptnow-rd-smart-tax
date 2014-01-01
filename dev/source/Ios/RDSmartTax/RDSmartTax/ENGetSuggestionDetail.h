//
//  ENGetSuggestionDetail.h
//  RDSmartTax
//
//  Created by Noi on 12/30/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ENGetSuggestionDetailDelegate <NSObject>

-(void)responseENGetSuggestionDetailService:(NSData*)data;

@end

@interface ENGetSuggestionDetail : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENGetSuggestionDetailDelegate> delegate;
- (void) requestENGetSuggestionDetailService: (NSString *) Id;


@end
