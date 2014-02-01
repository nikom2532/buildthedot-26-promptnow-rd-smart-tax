//
//  ENGetProvince.h
//  RDSmartTax
//
//  Created by Noi on 1/9/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@protocol ENGetProvinceDelegate <NSObject>

-(void)responseENGetProvince:(NSDictionary*)data;

@end


@interface ENGetProvince : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>{
    Susanoo *susanooObject;
}


@property (strong,nonatomic) id <ENGetProvinceDelegate> delegate;
- (void) requestENGetProvince;

@end
