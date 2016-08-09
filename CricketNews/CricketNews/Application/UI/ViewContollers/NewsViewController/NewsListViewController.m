//
//  NewsListViewController.m
//  CricketNews
//
//  Created by Harshal Wani on 8/3/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsDetailViewController.h"

#import "CommonImports.h"
#import "NewsViewCell.h"
#import "NewsProxy.h"
#import "NewsModel.h"

@interface NewsListViewController()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *newCollectionView;

@property (nonatomic, strong) NSMutableArray *newsArray;
@property (nonatomic, strong) NSString *newsDetailURL;

@end

@implementation NewsListViewController

-(void)loadView {
    
    self.view = [UIView new];
    
    [self addNavigationBar];
    [self addNavBarTitle:NSLocalizedString(@"News", nil)];
    
    //     [self addNavBarRightButtonWithImage:@"news_filter"];
    //     [self addNavBarRightButtonWithImage:@""];
    
    [self initializeData];
    [self configureUI];
    
    [self.view setNeedsUpdateConstraints];
}


 -(void)updateViewConstraints {

    [super updateViewConstraints];

    //All the constraints in the ViewController should be written only in this method
    if (!self.didSetupConstraints) {


        [self.newCollectionView
         autoPinEdgeToSuperviewEdge:ALEdgeTop
         withInset:PTPX(60)];
        [self.newCollectionView
         autoPinEdgeToSuperviewEdge:ALEdgeLeft
         withInset:0];
        [self.newCollectionView
         autoPinEdgeToSuperviewEdge:ALEdgeRight
         withInset:0];
        [self.newCollectionView
         autoPinEdgeToSuperviewEdge:ALEdgeBottom];

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
     [self.view addSubview:self.newCollectionView];


 }


 #pragma mark – UI Creation
- (UICollectionView *)newCollectionView
{
    if (!_newCollectionView)
    {
        UICollectionViewFlowLayout *layout;
        
        layout=[[UICollectionViewFlowLayout alloc] init];        
        layout.headerReferenceSize = CGSizeZero;
        layout.footerReferenceSize = CGSizeZero;
        
        
        _newCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame                                           collectionViewLayout:layout];
        
        _newCollectionView.dataSource = self;
        _newCollectionView.delegate = self;
        
        [_newCollectionView registerClass:[NewsViewCell class]
               forCellWithReuseIdentifier:@"NewsViewCell"];
        
        _newCollectionView.alwaysBounceVertical = NO;
        _newCollectionView.clipsToBounds = YES;
        _newCollectionView.backgroundColor = [UIColor clearColor];
    }
    
    return _newCollectionView;
}


 #pragma mark – View Life Cycle


 - (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets=NO;

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

#pragma mark - UICollectionViewDelegateFlowLayout -

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    if (IS_IPHONE)
        return 1.5;
    else
        return 10;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (IS_IPHONE)
        return UIEdgeInsetsMake(0, 0, 0, 0);
    else
        return UIEdgeInsetsMake(20, 10, 20, 10);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (IS_IPHONE)
        return CGSizeMake(PTPX(320), PTPX(90));
    else
        return CGSizeMake(325, 90);
}

#pragma mark - UICollectionViewDelegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.newsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewsViewCell *cell =
    (NewsViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"NewsViewCell"
                                                               forIndexPath:indexPath];
    
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    NewsModel *newsModel = [self.newsArray
                            objectAtIndex:indexPath.row];
    
    [cell resetUIandPrepareForReuse];
    [cell setUpUIwithModel:newsModel];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NewsModel *newsModel = [self.newsArray
                            objectAtIndex:indexPath.row];

    NewsDetailViewController *newsDetailViewController = [[NewsDetailViewController alloc] init];
    newsDetailViewController.newsID = [newsModel.newsID intValue];
    
    [APP_DELEGATE.rootViewController.navController pushViewController:newsDetailViewController animated:YES];
    
}
 #pragma mark – API Call and Delegate Methods

-(void)callGetNewsListAPI{
    
    
    [CommonMethodHelper checkNetworkAndShowHudForView:self.view];
    
    [[NewsProxy new] getNewsListWithSuccess:^(NSDictionary *responseDict) {
        
        self.newsArray = responseDict[@"news"];
        self.newsDetailURL = responseDict[@"detailed_URL"];
        [self.newCollectionView reloadData];
        
        [CommonMethodHelper hideHudForView:self.view];
        
    } withFailure:^(NSDictionary *responseDict) {
        
        
    }];
}

@end
