//
//  NewsDetailViewController.m
//  CricketNews
//
//  Created by Harshal Wani on 8/9/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "CommonImports.h"
#import "NewsImageWithCaptionCell.h"
#import "NewsDetailsProxy.h"
#import "NewsDetailModel.h"
#import "NewsImageModel.h"

@interface NewsDetailViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *lblNewsTitle;
@property (nonatomic, strong) UILabel *lblPostDate;
@property (nonatomic, strong) UITableView *tblNewsImages;

@property(nonatomic, strong) NSMutableArray *newsImagesArray;
@property(nonatomic, strong) NSString *imageBaseUrl;

@end


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

        [self.lblNewsTitle
         autoPinEdge:ALEdgeTop
         toEdge:ALEdgeBottom
         ofView:self.navigationBar
         withOffset:PTPX(10)];
        [self.lblNewsTitle
         autoPinEdgeToSuperviewEdge:ALEdgeLeft
         withInset:PTPX(10)];
        [self.lblNewsTitle
         autoPinEdgeToSuperviewEdge:ALEdgeRight
         withInset:PTPX(10)];
        
        [self.lblNewsTitle
         setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
         forAxis:UILayoutConstraintAxisVertical];
        [self.lblNewsTitle
         setContentHuggingPriority:UILayoutPriorityDefaultHigh
         forAxis:UILayoutConstraintAxisVertical];

        
        [self.lblPostDate
         autoPinEdge:ALEdgeTop
         toEdge:ALEdgeBottom
         ofView:self.lblNewsTitle
         withOffset:PTPX(5)];
        [self.lblPostDate
         autoPinEdgeToSuperviewEdge:ALEdgeLeft
         withInset:PTPX(10)];
        [self.lblPostDate
         autoPinEdgeToSuperviewEdge:ALEdgeRight
         withInset:PTPX(10)];

        
        [self.tblNewsImages
         autoPinEdge:ALEdgeTop
         toEdge:ALEdgeBottom
         ofView:self.lblPostDate
         withOffset:PTPX(5)];
        [self.tblNewsImages
         autoPinEdgeToSuperviewEdge:ALEdgeLeft
         withInset:0];
        [self.tblNewsImages
         autoPinEdgeToSuperviewEdge:ALEdgeRight
         withInset:0];
        [self.tblNewsImages
         autoPinEdgeToSuperviewEdge:ALEdgeBottom
         withInset:0];

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
    [self.view
     addSubview:self.lblNewsTitle];
     [self.view
      addSubview:self.lblPostDate];
     [self.view
      addSubview:self.tblNewsImages];


 }


 #pragma mark – UI Creation
- (UILabel *)lblNewsTitle
{
    if (!_lblNewsTitle)
    {
        _lblNewsTitle = [UIUtils createLabelWithText:@""
                                    withTextColorHex:GRAY_HEX_656565
                                   withTextAlignment:NSTextAlignmentLeft
                                            withFont:HELVETICA_NEUE_BOLD
                                         andFontSize:PTPX(16)];
        [_lblNewsTitle setLineBreakMode:NSLineBreakByWordWrapping];
        _lblNewsTitle.numberOfLines = 0;
    }
    return _lblNewsTitle;
}
- (UILabel *)lblPostDate
{
    if (!_lblPostDate)
    {
        _lblPostDate = [UIUtils createLabelWithText:@""
                                   withTextColorHex:GRAY_HEX_656565
                                  withTextAlignment:NSTextAlignmentLeft
                                           withFont:HELVETICA_NEUE
                                        andFontSize:PTPX(12)];
        [_lblPostDate setLineBreakMode:NSLineBreakByWordWrapping];
    }
    return _lblPostDate;
}
- (UITableView *)tblNewsImages
{
    if (!_tblNewsImages)
    {
        _tblNewsImages = [[UITableView alloc]initForAutoLayout];
        _tblNewsImages.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tblNewsImages registerClass:[NewsImageWithCaptionCell class]
                   forCellReuseIdentifier:@"NewsImageWithCaptionCell"];
        _tblNewsImages.backgroundColor = [UIColor clearColor];
        _tblNewsImages.dataSource = self;
        _tblNewsImages.delegate = self;
        _tblNewsImages.allowsMultipleSelectionDuringEditing = NO;
        _tblNewsImages.rowHeight = UITableViewAutomaticDimension;
        _tblNewsImages.estimatedRowHeight = PTPX(200); // set to whatever your "average" cell height is
    }
    return _tblNewsImages;
}


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

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsImagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"NewsImageWithCaptionCell";
    
    NewsImageWithCaptionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                             forIndexPath:indexPath];
    
    [cell resetUIandPrepareForReuse];
    [cell setUpUIwithModel:self.newsImagesArray[indexPath.row] withBaseURL:self.imageBaseUrl];
    
    return cell;
}

#pragma mark – API Call and Delegate Methods

-(void)callGetNewsDetailsAPI{
    
    [CommonMethodHelper checkNetworkAndShowHudForView:self.view];
    
    [[NewsDetailsProxy new] getNewsDetails:self.newsID WithSuccess:^(NSDictionary *responseDict) {
        
        [CommonMethodHelper hideHudForView:self.view];
 
        NewsDetailModel *newsDetailModel = responseDict[@"newsInfo"];
        self.lblNewsTitle.text = newsDetailModel.headline;
        self.lblPostDate.text = [NSDate formatDate:newsDetailModel.timestamp withFormat:@"MMM dd, yyyy"];
        self.newsImagesArray = responseDict[@"images"];
        self.imageBaseUrl = responseDict[@"imageURL"];
        [self.tblNewsImages reloadData];

    } withFailure:^(NSDictionary *responseDict) {
        
        [CommonMethodHelper hideHudForView:self.view];
 
    }];
}

@end
