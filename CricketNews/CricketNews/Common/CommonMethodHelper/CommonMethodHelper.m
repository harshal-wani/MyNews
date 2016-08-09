//
//  CommonMethodHelper.m
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "CommonMethodHelper.h"
#import "CommonImports.h"

@implementation CommonMethodHelper

+ (void)checkNetworkAndShowHudForView:(UIView *)view
{
    if (![NetworkUtils hasNetworkAndDisplayPopupIfNot])
    {
        return;
    }
    MBProgressHUD *HUB = [MBProgressHUD showHUDAddedTo:view
                                              animated:YES];
    HUB.color = [UIUtils colorFromHexColor:GREEN_HEADER_HEX_1BB38B];
}

+ (void)hideHudForView:(UIView *)view
{
    [MBProgressHUD hideHUDForView: view
                         animated: YES];
}

@end
