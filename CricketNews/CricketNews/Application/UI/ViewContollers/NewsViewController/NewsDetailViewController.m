//
//  NewsDetailViewController.m
//  CricketNews
//
//  Created by Harshal Wani on 8/9/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "CommonImports.h"

#import "NewsDetailsProxy.h"

@implementation NewsDetailViewController


 -(void)loadView {


    self.view = [UIView new];

    [self addNavigationBar];
    [self addNavBarTitle:NSLocalizedString(@"News Details", nil)];
    [self addNavBarLeftButtonWithImage:@"btn_back"];

    [self initializeData];

    [self configureUI];

    [self.view setNeedsUpdateConstraints];
 }


 -(void)updateViewConstraints {

    [super updateViewConstraints];

    //All the constraints in the ViewController should be written only in this method
    if (!self.didSetupConstraints) {





        self.didSetupConstraints = YES;
    }


 }
 #pragma mark – UI Configuration & Data initialization
//Data which is needed to initialize the UI
 - (void)initializeData {

 }

//Add other custom views like LLabelRLabel in this method
 - (void)configureUI {


    //Add Custom Views here
    //Add other views in here eg. [self.view addSubview:self.scrollview];


 }


 #pragma mark – UI Creation


 #pragma mark – View Life Cycle


 - (void)viewDidLoad {
    [super viewDidLoad];

     [self callGetNewsDetailsAPI];
 
}

 #pragma mark – Event Handling
 - (void)navigationBarLeftButtonClicked
 {
     [APP_DELEGATE.rootViewController.navController popViewControllerAnimated:YES];
 }


 #pragma mark – Private Methods



 #pragma mark - Public Methods
 #pragma mark – Delegate Methods
#pragma mark – API Call and Delegate Methods

-(void)callGetNewsDetailsAPI{
    
    
    [CommonMethodHelper checkNetworkAndShowHudForView:self.view];
    
    [[NewsDetailsProxy new] getNewsDetails:self.newsID WithSuccess:^(NSDictionary *responseDict) {
        
        [CommonMethodHelper hideHudForView:self.view];
 
        
    } withFailure:^(NSDictionary *responseDict) {
        
        [CommonMethodHelper hideHudForView:self.view];
 
    }];
}

@end
