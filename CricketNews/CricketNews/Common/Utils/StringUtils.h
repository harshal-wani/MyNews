//
//  StringUtils.h
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

+ (NSString *)stringByStrippingWhitespace:(NSString *)string;
+ (BOOL)isBlank:(NSString *)string;
+ (BOOL)isStringPresent:(NSString *)string;
+ (BOOL)isNull:(NSString *)string;

@end
