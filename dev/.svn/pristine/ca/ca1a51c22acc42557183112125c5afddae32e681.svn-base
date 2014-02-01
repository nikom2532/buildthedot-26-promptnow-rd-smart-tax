//
//  ENGetSuggestionTitle.h
//  RDSmartTax
//
//  Created by Noi on 12/30/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@protocol ENGetSuggestionTitleDelegate <NSObject>

-(void)responseENGetSuggestionTitleService:(NSDictionary*)data;

@end

@interface ENGetSuggestionTitle : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>{
    Susanoo *susanooObject;
}


@property (strong,nonatomic) id <ENGetSuggestionTitleDelegate> delegate;
- (void) requestENGetSuggestionTitleService;

@end
