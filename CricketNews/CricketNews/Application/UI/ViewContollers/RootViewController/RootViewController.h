//
//  RootViewController.h
//  CricketNews
//
//  Created by Harshal Wani on 8/8/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "AbstractViewController.h"

@class NewsListViewController;
@class CustomNavController;

@interface RootViewController : AbstractViewController

@property (strong, nonatomic) CustomNavController *navController;

@property (strong, nonatomic) NewsListViewController *newsListViewController;

@end
