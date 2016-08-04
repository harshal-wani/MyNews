//
//  NetworkUtils.m
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NetworkUtils.h"
#import "CommonImports.h"

@implementation NetworkUtils

+ (BOOL)hasNetworkConnection
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
    {
        return NO;
    }
    else
    {
        return YES;
        DebugLog(@"There IS internet connection");
    }
}

+ (BOOL)hasNetworkAndDisplayPopupIfNot
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
    {
        [UIUtils alertView:NSLocalizedString(@"The Internet connection appears to be offline.", nil) withTitle:NSLocalizedString(@"Alert", nil)];
        return NO;
    }
    else
    {
        return YES;
        DebugLog(@"There is internet connection");
    }
}

@end
