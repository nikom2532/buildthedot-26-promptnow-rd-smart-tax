//
//  M_Login.h
//
//  Created by Promptnow on 12/25/13.
//  Copyright (c) 2013 Promptnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@class M_Login;

@protocol LoginServiceDelegate <NSObject>

-(void)LoginServiceConnectionDidStart:(M_Login *)sender;
-(void)LoginServiceConnectionDidMakeProgress:(M_Login *)sender;
-(void)LoginServiceConnectionDidFinish:(M_Login *)sender;
-(void)LoginServiceConnectionDidFail:(M_Login *)sender;
-(void)LoginServiceConnectionDidTimeout:(M_Login *)sender;
@end

@interface M_Login : NSObject <SusanooDelegate>
{
    Susanoo *susanooObject;
    
    NSDictionary *responseDictionary;
    
    NSString *errorTitle;
    NSString *errorDescription;
}

@property (nonatomic, retain) NSDictionary *responseDictionary;
@property (nonatomic, retain) NSString *errorTitle;
@property (nonatomic, retain) NSString *errorDescription;
@property (nonatomic, assign) NSObject <LoginServiceDelegate> *delegate;

-(void)sendRequestWithUserName:(NSString *)username Password:(NSString *)password;

@end
