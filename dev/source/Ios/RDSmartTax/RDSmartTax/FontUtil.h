//
//  FontUtil.h
//  POCTax
//
//  Created by fone on 11/21/56 BE.
//  Copyright (c) 2556 BuildTheDot. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFontName @"PSL-Kittithada"
#define kFontSizeSmall 20.0
#define kFontSizeNormal 22.0
#define kFontSizeBig 29.0
#define kFontPattern @"%@-%@"
#define kFontStyleBold @"Bold"
#define kFontStyleItalic @"Italic"
#define kFontStyleBoldItalic @"BoldItalic"

typedef enum
{
    eFontSizeSmall = 1,
    eFontSizeNormal,
    eFontSizeBig
}eFontSize;

typedef enum
{
    eFontStyleNormal = 1,
    eFontStyleBold,
    eFontStyleItalic,
    eFontStyleBoldItalic
}eFontStyle;

@interface FontUtil : NSObject

+(float) getPointFontSize:(eFontSize)fontSize;
+(UIFont *)fontWithFontSize:(eFontSize)fontSize Style:(eFontStyle)fontStyle;

@end
