//
//  ENDeleteForm.h
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/4/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENDeleteFormDelegate <NSObject>

-(void)responseENDeleteFormService:(NSDictionary*)data;

@end
@interface ENDeleteForm : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENDeleteFormDelegate> delegate;

- (void) requestENDeleteFormServiceWithSysRefNo:(NSString*)sysRefNo;


@end
