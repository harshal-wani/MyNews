//
//  UIUtils.h
//  CricketNews
//
//  Created by Harshal Wani on 8/3/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIUtils : NSObject

//Set Color Using Hex
+ (UIColor *)colorFromHexColor:(NSString *)hexColor;

//Create One button AlertView
+ (void)alertView:(NSString *)message
        withTitle:(NSString *)title;

@end
