//
//  SharedObjects.h
//  SusanooLib
//
//  Created by Promptnow on 12/25/13.
//  Copyright (c) 2013 Promptnow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedObjects : NSObject
{
    unsigned char encryptionKey[32];
    unsigned char decryptionKey[32];
    unsigned char encryptionIV[16];
    BOOL keyExchanged;
}

//@property unsigned char encryptionKey;
//@property unsigned char decryptionKey;
@property BOOL keyExchanged;

- (void) setEncryptionKey: (unsigned char *) newEncryptionKey;
- (void) setDecryptionKey: (unsigned char *) newDecryptionKey;
- (void) setEncryptionIV: (unsigned char *) newEncryptionIV;
-(unsigned char*)getEncryptionKey;
-(unsigned char*)getDecryptionKey;
-(unsigned char*)getEncryptionIV;
+(SharedObjects*)sharedInstance;
@end
