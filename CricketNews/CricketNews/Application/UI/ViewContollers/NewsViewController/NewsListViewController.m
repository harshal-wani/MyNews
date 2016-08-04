//
//  NewsListViewController.m
//  CricketNews
//
//  Created by Harshal Wani on 8/3/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NewsListViewController.h"
#import "CommonImports.h"
#import "NewsProxy.h"
#import "NewsModel.h"

@interface NewsListViewController()

@property (nonatomic, strong) NSMutableArray *newsArray;

@property (nonatomic, strong) NSString *newsDetailURL;

@end
@implementation NewsListViewController

 -(void)loadView {


    self.view = [UIView new];

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

     [self callGetNewsListAPI];
 }

 #pragma mark – Event Handling


 - (void)navigationBarLeftButtonClicked
 {
    [self.navigationController popViewControllerAnimated:YES];

 }


 #pragma mark – Private Methods



 #pragma mark - Public Methods
 #pragma mark – Delegate Methods
 #pragma mark – API Call and Delegate Methods

-(void)callGetNewsListAPI{
    
    
    [CommonMethodHelper checkNetworkAndShowHudForView:self.view];
    
    [[NewsProxy new] getNewsListWithSuccess:^(NSDictionary *responseDict) {
        
        self.newsArray = responseDict[@"news"];
        self.newsDetailURL = responseDict[@"detailed_URL"];
//        [self.newCollectionView reloadData];
        
        [CommonMethodHelper hideHudForView:self.view];
        
    } withFailure:^(NSDictionary *responseDict) {
        
        
    }];
}

@end
