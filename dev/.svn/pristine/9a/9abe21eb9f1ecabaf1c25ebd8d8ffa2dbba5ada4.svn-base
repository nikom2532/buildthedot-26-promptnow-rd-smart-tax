//
//  M_Update_Version.h
//
//  Created by Promptnow on 12/25/13.
//  Copyright (c) 2013 Promptnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@class M_Update_Version;

@protocol UpdateVersionDelegate <NSObject>

-(void)UpdateVersionConnectionDidStart:(M_Update_Version *)sender;
-(void)UpdateVersionConnectionDidMakeProgress:(M_Update_Version *)sender;
-(void)UpdateVersionConnectionDidFinish:(M_Update_Version *)sender;
-(void)UpdateVersionConnectionDidFail:(M_Update_Version *)sender;
-(void)UpdateVersionConnectionDidTimeout:(M_Update_Version *)sender;
@end

@interface M_Update_Version : NSObject <SusanooDelegate>
{
    Susanoo *susanooObject;
    
    NSDictionary *responseDictionary;
    
    NSString *errorTitle;
    NSString *errorDescription;
}

@property (nonatomic, retain) NSDictionary *responseDictionary;
@property (nonatomic, retain) NSString *errorTitle;
@property (nonatomic, retain) NSString *errorDescription;
@property (nonatomic, assign) NSObject <UpdateVersionDelegate> *delegate;

-(void)sendRequest;

@end