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
    
    [MBProgressHUD showHUDAddedTo:view
                         animated:YES];
}

+ (void)hideHudForView:(UIView *)view
{
    [MBProgressHUD hideHUDForView: view
                         animated: YES];
}

@end
