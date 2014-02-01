//
//  SusanooResponse.h
//  SusanooLib
//
//  Created by Promptnow on 12/25/13.
//  Copyright (c) 2013 Promptnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SusanooRequest.h"

@interface SusanooResponse : NSObject
{
    SusanooRequest *request;
    NSDictionary *responseHeader;
    NSDictionary *responseData;
}

@property (nonatomic, retain) SusanooRequest *request;
@property (nonatomic, retain) NSDictionary *responseHeader;
@property (nonatomic, retain) NSDictionary *responseData;

@end
