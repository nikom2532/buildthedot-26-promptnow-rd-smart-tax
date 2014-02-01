//
//  Susanoo.h
//  SusanooLib
//
//  Created by Promptnow on 12/25/13.
//  Copyright (c) 2013 Promptnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SusanooRequest.h"
#import "SusanooResponse.h"
//#import "configuration.h"
#import "UTCryptoHelper.h"
#import "tommath.h"

@protocol SusanooDelegate <NSObject>

- (void) susanooConnectionDidStart : (SusanooRequest *) request;
- (void) susanooConnectionDidMakeProgress : (SusanooRequest *) request;
- (void) susanooConnectionDidFail : (SusanooResponse *) response;
- (void) susanooConnectionDidFinish : (SusanooResponse *) response;
- (void) susanooConnectionDidTimeout : (SusanooResponse *) response;

@end

@protocol getKeyExchangeDelegate <NSObject>

-(void) getKeyExchageDidFinish:(NSDictionary *) result;

@end

@interface Susanoo : NSObject
{
	// temporary for DH key-exchange
	mp_int bnPrimeModulus;
	mp_int bnBaseExponent;
	mp_int bnPrivate;
	mp_int bnPublic;
    
	// application state
	BOOL keyExchanged;
	unsigned char encryptionIV[16];
	unsigned char encryptionKey[32];
	unsigned char decryptionKey[32];
    
    id delegate;
    SusanooRequest *susanooRequest;
    SusanooResponse *susanooResponse;
    NSMutableData *downloadData;
    NSMutableData *keyDownload;
    NSMutableData *secureData;
    NSURLConnection *keyExchangeConnection;
    NSURLConnection *requestConnection;
    NSURLConnection *secureConnection;
    
}

@property (nonatomic, assign) id<SusanooDelegate> delegate;
@property (nonatomic, assign) id<getKeyExchangeDelegate>keyDelegate;

@property (nonatomic, retain) SusanooRequest *susanooRequest;
@property (nonatomic, retain) SusanooResponse *susanooResponse;
@property (nonatomic, retain) NSURLConnection *currentConnection;
@property (nonatomic, retain) NSMutableData *downloadData;

-(BOOL) getKeyExchange;
- (void) didFinishRequestWithResponse:(SusanooResponse *) response;
- (void) cancelRequest;
- (void) sendNoSecureRequestToService:(NSString *) serviceName withJSONData:(NSData *)JSONData;
- (void) sendRequestToService:(NSString *) serviceName withJSONData:(NSData *)JSONData;
- (void) sendSecuredRequestToService:(NSString *) serviceName withJSONData:(NSData *)JSONData;
- (void) sendSecuredRequestToService:(NSString *) serviceName withXMLString:(NSString *) xmlString;

@end