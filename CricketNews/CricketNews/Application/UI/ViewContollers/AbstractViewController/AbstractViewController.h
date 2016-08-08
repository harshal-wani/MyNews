//
//  AbstractViewController.h
//  CricketNews
//
//  Created by Harshal Wani on 8/3/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractViewController : UIViewController

@property (nonatomic, assign) BOOL didSetupConstraints;

@property(nonatomic,retain) UIImageView *navigationBar;

@property(nonatomic,retain) UILabel *navigationBarTitle;

@property(nonatomic,strong) UIButton *navigationBarLeftButton;

@property(nonatomic,strong) UIButton *navigationBarRightButton;

- (void)addNavigationBar;
- (void)addNavBarTitle:(NSString *)navTitle;
- (void)addNavBarLeftButtonWithImage:(NSString*)imageName;
- (void)addNavBarRightButtonWithImage:(NSString*)imageName;

@end
