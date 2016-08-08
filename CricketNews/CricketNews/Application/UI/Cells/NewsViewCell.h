//
//  NewsViewCell.h
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;

@interface NewsViewCell : UICollectionViewCell

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) UIImageView *newsThumbnailImage;
@property (nonatomic, strong) UILabel *lblNewsTitle;
@property (nonatomic, strong) UILabel *lblPostDate;
@property (nonatomic, strong) UILabel *lblNewsDescription;

- (void)setUpUIwithModel:(NewsModel *)model;

- (void)resetUIandPrepareForReuse;


@end
