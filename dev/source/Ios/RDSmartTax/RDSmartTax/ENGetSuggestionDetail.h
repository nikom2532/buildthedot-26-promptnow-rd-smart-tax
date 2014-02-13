//
//  ENGetSuggestionDetail.h
//  RDSmartTax
//
//  Created by Noi on 12/30/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@protocol ENGetSuggestionDetailDelegate <NSObject>

-(void)responseENGetSuggestionDetailService:(NSDictionary*)data;

@end

@interface ENGetSuggestionDetail : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>{
    Susanoo *susanooObject;
}


@property (strong,nonatomic) id <ENGetSuggestionDetailDelegate> delegate;
- (void) requestENGetSuggestionDetailService: (NSString *) explanation_id;


@end
