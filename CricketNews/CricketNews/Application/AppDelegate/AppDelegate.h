//
//  AppDelegate.h
//  CricketNews
//
//  Created by Harshal Wani on 8/3/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "CustomNavController.h"

@class RootViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RootViewController *rootViewController;

@end

