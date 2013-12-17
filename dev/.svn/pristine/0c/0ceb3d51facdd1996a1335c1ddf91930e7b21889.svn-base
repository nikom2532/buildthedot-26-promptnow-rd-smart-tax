//
//  ENRegisterSaveService.h
//  RDSmartTax
//
//  Created by Noi on 12/7/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ENRegisterSaveServiceDelegate <NSObject>

-(void)responseENRegisterSaveService:(NSData*)data;

@end


@interface ENRegisterSaveService : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong,nonatomic) id <ENRegisterSaveServiceDelegate> delegate;

- (void) requestENRegisterSaveService :(NSString *)nid
                              password:(NSString *)password
                                 email:(NSString *)email
                             birthDate:(NSString *)birthDate
                            questionId:(NSString *)questionId
                                answer:(NSString *)answer
                                  name:(NSString *)name
                               surname:(NSString *)surname
                             telephone:(NSString *)telephone
                    telephoneExtension:(NSString *)telephoneExtension
                            fatherName:(NSString *)fatherName
                            motherName:(NSString *)motherName
                            passportNo:(NSString *)passportNo
                           countryCode:(NSString *)countryCode
                               moiFlag:(NSString *)moiFlag
                               version:(NSString *)version;


@end
