//
//  ENConfirmRequestPassword.h
//  RDSmartTax
//
//  Created by Noi on 12/20/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ENConfirmRequestPasswordServiceDelegate <NSObject>

-(void)responseENConfirmRequestPasswordService:(NSData*)data;

@end
@interface ENConfirmRequestPassword : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENConfirmRequestPasswordServiceDelegate> delegate;

- (void) requestENConfirmRequestPasswordService : (NSString *) nid
                                           name : (NSString *) name
                                        surName : (NSString *) surName
                                       birthDate: (NSString *) birthDate
                                      fatherName: (NSString *) fatherName
                                      motherName: (NSString *) motherName
                                        version : (NSString *) version;
@end
