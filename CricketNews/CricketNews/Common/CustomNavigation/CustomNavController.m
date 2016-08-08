//
//  CustomNavController.m
//  CricketNews
//
//  Created by Harshal Wani on 8/8/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "CustomNavController.h"
#import "CommonImports.h"

static const float NC_ANIMATION_DURATION = 0.5f;

@interface CustomNavController ()

-(void)commonInit:(UIViewController *)viewController;
-(void)setupViews;

@end

@implementation CustomNavController

#pragma mark - Private methods

- (void)setupViews {
    
    //DebugLog(@"%f",self.view.frame.size.height);
    
    _contentView = [[UIView alloc] initForAutoLayout];
    
    [self.view addSubview:_contentView];
    
    [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    [self.contentView setBackgroundColor:[UIUtils colorFromHexColor:WHITE_HEX_FFFFFF]];

}

- (void)removeConstraintForView:(NSDictionary*)dictionary {
    
    [[dictionary valueForKey:BOTTOM_EDGE] autoRemove];
    
    [[dictionary valueForKey:TOP_EDGE] autoRemove];
    
    [[dictionary valueForKey:LEFT_EDGE] autoRemove];
    
    [[dictionary valueForKey:RIGHT_EDGE] autoRemove];
    
}


#pragma mark - Public methods


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.viewControllers addObject:viewController];
    
    UIViewController *previousViewController = [self.viewControllers objectAtIndex:self.currentControllerIndex];
    
    NSMutableDictionary *goingViewConstraintDictionary = [self.constraintsArray objectAtIndex:self.currentControllerIndex];
    
    [self.contentView addSubview:viewController.view];
    
    UIView *coming = viewController.view;
    
    UIView *going = previousViewController.view;
    
    NSLayoutConstraint *comingTop = [coming autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    NSLayoutConstraint *comingBottom = [coming autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    
    
    if (animated) {
        
        NSLayoutConstraint *commingLeft = [coming autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.contentView];
        
        NSLayoutConstraint *commingRight = [coming autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:self.contentView.frame.size.width];
        
        [self.view layoutIfNeeded];
        
        [UIView animateWithDuration:NC_ANIMATION_DURATION
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             [[goingViewConstraintDictionary valueForKey:LEFT_EDGE] autoRemove];
                             
                             [[goingViewConstraintDictionary valueForKey:RIGHT_EDGE] autoRemove];
                             
                             NSLayoutConstraint *goingLeft = [going autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:-(self.contentView.frame.size.width)];
                             
                             NSLayoutConstraint *goingRight = [going autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-(self.contentView.frame.size.width)];
                             
                             [goingViewConstraintDictionary setValue:goingLeft forKey:LEFT_EDGE];
                             
                             
                             [goingViewConstraintDictionary setValue:goingRight forKey:RIGHT_EDGE];
                             
                             [commingLeft autoRemove];
                             
                             [commingRight autoRemove];
                             
                             NSLayoutConstraint *comingLeft = [coming autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
                             
                             NSLayoutConstraint *comingRight = [coming autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
                             
                             NSMutableDictionary *contraintDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:comingTop,TOP_EDGE,
                                                                         comingBottom,BOTTOM_EDGE,
                                                                         comingLeft,LEFT_EDGE,
                                                                         comingRight,RIGHT_EDGE,nil];
                             
                             [self.constraintsArray  addObject:contraintDictionary];
                             
                             [self.view layoutIfNeeded];
                             
                         }
                         completion:^(BOOL finished){
                             
                             [self removeConstraintForView:goingViewConstraintDictionary];
                             
                             [previousViewController.view removeFromSuperview];
                             
                             
                         }];
        
        self.currentControllerIndex++;
        
    } else {
        
        self.currentControllerIndex++;
        
        NSLayoutConstraint *comingLeft = [coming autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
        
        NSLayoutConstraint *comingRight = [coming autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
        
        NSMutableDictionary *contraintDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:comingTop,TOP_EDGE,
                                                    comingBottom,BOTTOM_EDGE,
                                                    comingLeft,LEFT_EDGE,
                                                    comingRight,RIGHT_EDGE,nil];
        
        [self.constraintsArray  addObject:contraintDictionary];
        
        
        [self.view layoutIfNeeded];
        
        [self removeConstraintForView:goingViewConstraintDictionary];
        
        [previousViewController.view removeFromSuperview];
        
        
    }
    
}


- (void)popViewControllerAnimated:(BOOL)animated {
    
    if(self.currentControllerIndex < 1) {
        
        return;
    }
    
    UIViewController *currentViewController = [self.viewControllers objectAtIndex:self.currentControllerIndex];
    
    UIViewController *previousViewController = [self.viewControllers objectAtIndex:self.currentControllerIndex - 1];
    
    NSMutableDictionary *goingViewConstraintDictionary = [self.constraintsArray objectAtIndex:self.currentControllerIndex];
    
    NSMutableDictionary *comingViewConstraintDictionary = [self.constraintsArray objectAtIndex:self.currentControllerIndex - 1];
    
    UIView *coming = previousViewController.view;
    
    UIView *going = currentViewController.view;
    
    [self.contentView insertSubview:previousViewController.view atIndex:self.currentControllerIndex - 1];
    
    NSLayoutConstraint *commingTop = [coming autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    
    NSLayoutConstraint *comingBottom = [coming autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    
    [comingViewConstraintDictionary setValue:commingTop forKey:TOP_EDGE];
    
    [comingViewConstraintDictionary setValue:comingBottom forKey:BOTTOM_EDGE];
    
    
    
    if (animated) {
        
        NSLayoutConstraint *commingRight = [coming autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.contentView];
        
        
        [UIView animateWithDuration:NC_ANIMATION_DURATION
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             
                             [[goingViewConstraintDictionary valueForKey:LEFT_EDGE] autoRemove];
                             [[goingViewConstraintDictionary valueForKey:RIGHT_EDGE] autoRemove];
                             
                             
                             NSLayoutConstraint *goingRight = [going autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:(self.contentView.frame.size.width)];
                             
                             NSLayoutConstraint *goingLeft = [going autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:(self.contentView.frame.size.width)];
                             
                             [goingViewConstraintDictionary setValue:goingLeft forKey:LEFT_EDGE];
                             
                             [goingViewConstraintDictionary setValue:goingRight forKey:RIGHT_EDGE];
                             
                             [commingRight autoRemove];
                             
                             NSLayoutConstraint *comingLeft = [coming autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
                             
                             NSLayoutConstraint *comingRight = [coming autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
                             
                             
                             [comingViewConstraintDictionary setValue:comingLeft forKey:LEFT_EDGE];
                             
                             [comingViewConstraintDictionary setValue:comingRight forKey:RIGHT_EDGE];
                             
                             
                             [self.view layoutIfNeeded];
                             
                         }
                         completion:^(BOOL finished){
                             
                             [self removeConstraintForView:goingViewConstraintDictionary];
                             
                             [currentViewController didReceiveMemoryWarning];
                             [currentViewController.view removeFromSuperview];
                             
                             
                         }];
        
        
        self.currentControllerIndex--;
        
    } else {
        
        
        NSLayoutConstraint *comingRight = [coming autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
        NSLayoutConstraint *comingLeft = [coming autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
        
        
        [comingViewConstraintDictionary setValue:comingRight forKey:RIGHT_EDGE];
        
        [comingViewConstraintDictionary setValue:comingLeft forKey:LEFT_EDGE];
        
        [self.view layoutIfNeeded];
        
        [self removeConstraintForView:goingViewConstraintDictionary];
        
        [currentViewController didReceiveMemoryWarning];
        [currentViewController.view removeFromSuperview];
        
        self.currentControllerIndex--;
    }
    
    [self.viewControllers removeObject:currentViewController];
    
    [self.constraintsArray removeObject:goingViewConstraintDictionary];
    
}


- (void)pushViewControllerUp:(UIViewController *)viewController
                    animated:(BOOL)animated {
    
    
    [self.viewControllers addObject:viewController];
    
    UIViewController *previousViewController = [self.viewControllers objectAtIndex:self.currentControllerIndex];
    
    NSMutableDictionary *goingViewConstraintDictionary = [self.constraintsArray objectAtIndex:self.currentControllerIndex];
    
    [self.contentView addSubview:viewController.view];
    
    UIView *coming = viewController.view;
    
    NSLayoutConstraint *comingLeft = [coming autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    NSLayoutConstraint *comingRight = [coming autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    
    
    if (animated) {
        
        NSLayoutConstraint *commingTop = [coming autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.contentView];
        
        
        NSLayoutConstraint *commingBottom = [coming autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView withOffset:self.contentView.frame.size.height];
        
        [self.view layoutIfNeeded];
        
        
        [UIView animateWithDuration:NC_ANIMATION_DURATION
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             
                             [commingTop autoRemove];
                             
                             [commingBottom autoRemove];
                             
                             NSLayoutConstraint *comingTop = [coming autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
                             
                             NSLayoutConstraint *comingBottom = [coming autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
                             
                             NSMutableDictionary *contraintDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:comingTop,TOP_EDGE,
                                                                         comingBottom,BOTTOM_EDGE,
                                                                         comingLeft,LEFT_EDGE,
                                                                         comingRight,RIGHT_EDGE,nil];
                             
                             [self.constraintsArray  addObject:contraintDictionary];
                             
                             [self.view layoutIfNeeded];
                             
                         }
                         completion:^(BOOL finished){
                             
                             [self removeConstraintForView:goingViewConstraintDictionary];
                             
                             
                             [previousViewController.view removeFromSuperview];
                             
                             
                         }];
        
        self.currentControllerIndex++;
        
    } else {
        
        self.currentControllerIndex++;
        
        NSLayoutConstraint *comingTop = [coming autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
        
        NSLayoutConstraint *comingBottom = [coming autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
        
        NSMutableDictionary *contraintDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:comingTop,TOP_EDGE,
                                                    comingBottom,BOTTOM_EDGE,
                                                    comingLeft,LEFT_EDGE,
                                                    comingRight,RIGHT_EDGE,nil];
        
        [self.constraintsArray  addObject:contraintDictionary];
        
        
        [self.view layoutIfNeeded];
        
        [self removeConstraintForView:goingViewConstraintDictionary];
        
        [previousViewController.view removeFromSuperview];
        
        
    }
    
    
}

- (void)popViewControllerDownAnimated:(BOOL)animated {
    
    
    if(self.currentControllerIndex < 1) {
        return;
    }
    
    UIViewController *currentViewController = [self.viewControllers objectAtIndex:self.currentControllerIndex];
    
    UIViewController *previousViewController = [self.viewControllers objectAtIndex:self.currentControllerIndex - 1];
    
    NSMutableDictionary *goingViewConstraintDictionary = [self.constraintsArray objectAtIndex:self.currentControllerIndex];
    
    NSMutableDictionary *comingViewConstraintDictionary = [self.constraintsArray objectAtIndex:self.currentControllerIndex - 1];
    
    UIView *coming = previousViewController.view;
    
    UIView *going = currentViewController.view;
    
    
    [self.contentView removeConstraints:coming.constraints];
    
    
    [self.contentView insertSubview:previousViewController.view atIndex:self.currentControllerIndex - 1];
    
    
    
    NSLayoutConstraint *commingTop = [coming autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    NSLayoutConstraint *comingBottom = [coming autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    NSLayoutConstraint *commingLeft = [coming autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    NSLayoutConstraint *commingRight = [coming autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    
    
    [comingViewConstraintDictionary setValue:commingLeft forKey:LEFT_EDGE];
    
    [comingViewConstraintDictionary setValue:commingRight forKey:RIGHT_EDGE];
    
    [comingViewConstraintDictionary setValue:commingTop forKey:TOP_EDGE];
    
    [comingViewConstraintDictionary setValue:comingBottom forKey:BOTTOM_EDGE];
    
    [self.view layoutIfNeeded];
    
    
    if (animated) {
        
        [UIView animateWithDuration:NC_ANIMATION_DURATION
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             
                             [[goingViewConstraintDictionary valueForKey:TOP_EDGE] autoRemove];
                             [[goingViewConstraintDictionary valueForKey:BOTTOM_EDGE] autoRemove];
                             
                             
                             NSLayoutConstraint *goingTop = [going autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:(self.contentView.frame.size.height)];
                             
                             NSLayoutConstraint *goingBottom = [going autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView withOffset:(self.contentView.frame.size.height)];
                             
                             [goingViewConstraintDictionary setValue:goingTop forKey:LEFT_EDGE];
                             
                             [goingViewConstraintDictionary setValue:goingBottom forKey:RIGHT_EDGE];
                             
                             
                             [self.view layoutIfNeeded];
                             
                         }
                         completion:^(BOOL finished){
                             
                             
                             [self.contentView removeConstraints:going.constraints];
                             
                             [currentViewController.view removeFromSuperview];
                             
                             
                         }];
        
        
        self.currentControllerIndex--;
        
    } else {
        
        [self.view layoutIfNeeded];
        
        [self removeConstraintForView:goingViewConstraintDictionary];
        
        [currentViewController.view removeFromSuperview];
        
        self.currentControllerIndex--;
    }
    
    [self.viewControllers removeObject:currentViewController];
    
    [self.constraintsArray removeObject:goingViewConstraintDictionary];
    
}



- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    NSInteger popToIndex = (NSInteger)[self.viewControllers indexOfObject:viewController];
    
    if (self.currentControllerIndex > popToIndex) {
        
        if ([self.viewControllers count] > 2) {
            
            for (NSInteger i = self.currentControllerIndex - 1; i > popToIndex ; i--) {
                
                [self.viewControllers removeObjectAtIndex:i];
                [self.constraintsArray removeObjectAtIndex:i];
                
            }
            
            self.currentControllerIndex = popToIndex + 1;
        }
        
        [self popViewControllerAnimated:animated];
        
        
    }
}


- (void)popToRootViewController:(BOOL)animated {
    
    if (self.currentControllerIndex > 0) {
        
        if ([self.viewControllers count] > 2) {
            
            for (int i = (int)(self.viewControllers.count - 2); i >= 1 ; i--) {
                [self.viewControllers removeObjectAtIndex:i];
                [self.constraintsArray removeObjectAtIndex:i];
                
            }
            
            self.currentControllerIndex = 1;
        }
        
        [self popViewControllerAnimated:animated];
        
    }
}

- (UIViewController *)currentTopViewController {
    
    if (self.viewControllers.count > self.currentControllerIndex) {
        return [self.viewControllers objectAtIndex:self.currentControllerIndex];
    } else {
        return nil;
    }
}


#pragma mark - Init and dealloc

- (void)commonInit:(UIViewController*)viewController {
    
    [self setupViews];
    
    _viewControllers = [[NSMutableArray alloc] initWithCapacity:10];
    self.currentControllerIndex = -1;
    
    if(viewController) {
        
        [self.viewControllers addObject:viewController];
        [self.contentView addSubview:viewController.view];
        self.currentControllerIndex = 0;
    }
    
    
    if (!_constraintsArray) {
        
        _constraintsArray = [[NSMutableArray alloc] init];
        
    }
    
    
    NSLayoutConstraint *topEdge = [viewController.view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
    NSLayoutConstraint *bottomEdge  = [viewController.view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    NSLayoutConstraint *leftEdge  = [viewController.view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
    NSLayoutConstraint *rightEdge  = [viewController.view autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
    NSMutableDictionary *contraintDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:topEdge,TOP_EDGE,
                                                bottomEdge,BOTTOM_EDGE,
                                                leftEdge,LEFT_EDGE,
                                                rightEdge,RIGHT_EDGE,nil];
    
    [self.constraintsArray addObject:contraintDictionary];
    
}


- (id)initWithViewController: (UIViewController *) viewController {
    
    self = [super init];
    
    if (self) {
        [self commonInit:viewController];
    }
    
    return self;
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
