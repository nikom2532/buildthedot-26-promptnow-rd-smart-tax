//
//  ENGetSuggestionTitle.h
//  RDSmartTax
//
//  Created by Noi on 12/30/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ENGetSuggestionTitleDelegate <NSObject>

-(void)responseENGetSuggestionTitleService:(NSData*)data;

@end

@interface ENGetSuggestionTitle : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENGetSuggestionTitleDelegate> delegate;
- (void) requestENGetSuggestionTitleService;

@end
