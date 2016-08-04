//
//  UIUtils.m
//  CricketNews
//
//  Created by Harshal Wani on 8/3/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils


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

@end
