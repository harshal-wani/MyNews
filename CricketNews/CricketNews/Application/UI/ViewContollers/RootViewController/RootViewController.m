//
//  RootViewController.m
//  CricketNews
//
//  Created by Harshal Wani on 8/8/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "RootViewController.h"
#import "CustomNavController.h"
#import "NewsListViewController.h"

@implementation RootViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _newsListViewController = [[NewsListViewController alloc] init];
    
    self.navController = [[CustomNavController alloc] initWithViewController:_newsListViewController];
    [self.view addSubview:self.navController.view];
}

@end
