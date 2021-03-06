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

//Calculate points according to device size
+ (float)pointsToPixels:(float)points;

//Create ImageView
+ (UIImageView *)createImageView:(NSString *)imageName;

//Create UILabel
+ (UILabel *)createLabelWithText:(NSString *)text
                withTextColorHex:(NSString *)HexValue
               withTextAlignment:(NSTextAlignment)alignment
                        withFont:(NSString *)fontName
                     andFontSize:(float)fontSize;

//Create Button with Image
+ (UIButton*)createButtonWithImage:(NSString*)imageName
                    andEventTarget:(id)targetedObject
                         andAction:(SEL)action
                            andTag:(int)tagNo;
@end
