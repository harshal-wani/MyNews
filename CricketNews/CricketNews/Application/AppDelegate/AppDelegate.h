//
//  AppDelegate.h
//  CricketNews
//
//  Created by Harshal Wani on 8/3/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsListViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) NewsListViewController *rootViewController;

@property (strong, nonatomic) UINavigationController *rootNavigationController;


@end

