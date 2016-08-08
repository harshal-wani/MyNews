//
//  CustomNavController.h
//  CricketNews
//
//  Created by Harshal Wani on 8/8/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PureLayout.h"

#define TOP_EDGE @"TOP_EDGE"
#define BOTTOM_EDGE @"BOTTOM_EDGE"
#define LEFT_EDGE @"LEFT_EDGE"
#define RIGHT_EDGE @"RIGHT_EDGE"

@interface CustomNavController : UIViewController

@property (readonly, nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) NSMutableArray *constraintsArray;
@property (nonatomic, assign) NSInteger currentControllerIndex;
@property (readonly, strong) UIView *contentView;


- (id)initWithViewController:(UIViewController *)viewController;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)popViewControllerAnimated:(BOOL)animated;

- (void)popToRootViewController:(BOOL)animated;

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated ;

- (UIViewController *)currentTopViewController;

- (void)pushViewControllerUp:(UIViewController *)viewController animated:(BOOL)animated;

- (void)popViewControllerDownAnimated:(BOOL)animated;

@end
