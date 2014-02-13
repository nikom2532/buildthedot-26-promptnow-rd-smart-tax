//
//  ENGetAmphur.h
//  RDSmartTax
//
//  Created by Noi on 1/9/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"


@protocol ENGetAmphurDelegate <NSObject>

-(void)responseENGetAmphur:(NSDictionary*)data;

@end

@interface ENGetAmphur : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENGetAmphurDelegate> delegate;
- (void) requestENGetAmphur: (NSString *) province_id;


@end
