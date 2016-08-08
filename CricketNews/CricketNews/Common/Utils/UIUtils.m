//
//  UIUtils.m
//  CricketNews
//
//  Created by Harshal Wani on 8/3/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "UIUtils.h"
#import "CommonImports.h"

@implementation UIUtils

#pragma mark - Calculate points according to device size

+ (float)pointsToPixels:(float)points
{
    if (IS_IPAD)
        return points;
    
    float baseWidth = 320;
    float screenWidth = SCREEN_MIN_LENGTH;
    
    return (points * screenWidth) / baseWidth;
}

#pragma mark - Color Methods

+ (UIColor *)colorFromHexColor:(NSString *)hexColor
{
    unsigned int red = 0, green = 0, blue = 0;
    NSRange range;
    
    range.length = 2;
    
    range.location = 0;
    
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float) (red / 255.0)
                           green:(float) (green / 255.0)
                            blue:(float) (blue / 255.0)
                           alpha:1.0];
}

#pragma mark -  One Button AlertView

+ (void)alertView:(NSString *)message
        withTitle:(NSString *)title {
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleCancel
                         handler: ^(UIAlertAction *action)
                         {
                             [alertController
                              dismissViewControllerAnimated:YES
                              completion:nil];
                         }];
    [alertController addAction:ok];
    
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];
}
#pragma mark -  ImageView

+ (UIImageView *)createImageView:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initForAutoLayout];
    
    if ([StringUtils isStringPresent:imageName])
    {
        [imageView setImage:[UIImage imageNamed:imageName]];
    }
    
    return imageView;
}
#pragma mark -  Label

+ (UILabel *)createLabelWithText:(NSString *)text
                withTextColorHex:(NSString *)HexValue
               withTextAlignment:(NSTextAlignment)alignment
                        withFont:(NSString *)fontName
                     andFontSize:(float)fontSize
{
    UILabel *label = [[UILabel alloc] initForAutoLayout];
    
    [label setBackgroundColor:[UIColor clearColor]];
    [label setText:text];
    
    if ([StringUtils isStringPresent:fontName])
    {
        [label setFont:[UIFont fontWithName:fontName
                                       size:fontSize]];
    }
    else
    {
        [label setFont:[UIFont systemFontOfSize:fontSize]];
    }
    
    [label setTextColor:[UIUtils colorFromHexColor:HexValue]];
    
    [label setTextAlignment:alignment];
    
    return label;
}
#pragma mark -  Button -

+ (UIButton*)createButtonWithImage:(NSString*)imageName
                    andEventTarget:(id)targetedObject
                         andAction:(SEL)action
                            andTag:(int)tagNo
{
    
    UIButton *button = [[UIButton alloc] initForAutoLayout];
    
    if ([StringUtils isStringPresent:imageName]) {
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
    }
    
    [button addTarget:targetedObject action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setTag:tagNo];
    
    return button;
}

@end
