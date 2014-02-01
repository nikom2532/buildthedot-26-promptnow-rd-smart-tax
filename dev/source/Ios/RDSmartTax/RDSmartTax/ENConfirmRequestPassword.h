//
//  ENConfirmRequestPassword.h
//  RDSmartTax
//
//  Created by Noi on 12/20/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"

@protocol ENConfirmRequestPasswordServiceDelegate <NSObject>

-(void)responseENConfirmRequestPasswordService:(NSDictionary*)data;

@end
@interface ENConfirmRequestPassword : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENConfirmRequestPasswordServiceDelegate> delegate;

- (void) requestENConfirmRequestPasswordService : (NSString *) nid
                                           name : (NSString *) name
                                        surName : (NSString *) surName
                                       birthDate: (NSString *) birthDate
                                      fatherName: (NSString *) fatherName
                                      motherName: (NSString *) motherName
                                      passportNo: (NSString *) passportNo
                                     countryCode: (NSString *) countryCode
;
@end
