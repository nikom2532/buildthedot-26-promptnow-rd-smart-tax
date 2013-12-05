//
//  FontUtil.m
//  POCTax
//
//  Created by fone on 11/21/56 BE.
//  Copyright (c) 2556 BuildTheDot. All rights reserved.
//

#import "FontUtil.h"

@implementation FontUtil

+(float) getPointFontSize:(eFontSize)fontSize
{
    switch (fontSize)
    {
        case eFontSizeSmall:
            return kFontSizeSmall;
            
        case eFontSizeNormal:
            return kFontSizeNormal;
            
        case eFontSizeBig:
            return kFontSizeBig;
            
        default:
            return kFontSizeNormal;
    }
    return kFontSizeNormal;
}

+(UIFont *)fontWithFontSize:(eFontSize)fontSize Style:(eFontStyle)fontStyle
{
    float fSize = [FontUtil getPointFontSize:fontSize];
    return [FontUtil fontWithPointSize:fSize Style:fontStyle];
}

+(UIFont *)fontWithPointSize:(float)point Style:(eFontStyle)fontStyle
{
    NSString *fontName = @"";
    if(fontStyle == eFontStyleBold) {
        fontName = [NSString stringWithFormat:kFontPattern,kFontName,kFontStyleBold];
    } else if(fontStyle == eFontStyleItalic) {
        fontName = [NSString stringWithFormat:kFontPattern,kFontName,kFontStyleItalic];
    } else if (fontStyle == eFontStyleBoldItalic){
        fontName = [NSString stringWithFormat:kFontPattern,kFontName,kFontStyleBoldItalic];
    } else {
        fontName = kFontName;
    }
    
    return [UIFont fontWithName:fontName size:point];
    
}

@end
