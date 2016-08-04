//
//  NetworkUtils.h
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkUtils : NSObject

+ (BOOL)hasNetworkConnection;

+ (BOOL)hasNetworkAndDisplayPopupIfNot;

@end
