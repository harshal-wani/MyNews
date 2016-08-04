//
//  CommonMethodHelper.h
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonMethodHelper : NSObject

#pragma mark - HUD Related

+ (void)checkNetworkAndShowHudForView:(UIView *)view;

+ (void)hideHudForView:(UIView *)view;

@end
