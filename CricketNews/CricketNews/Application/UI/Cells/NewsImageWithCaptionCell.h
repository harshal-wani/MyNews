//
//  NewsImageWithCaptionCell.h
//  CricketNews
//
//  Created by Harshal Wani on 8/9/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsImageModel;

@interface NewsImageWithCaptionCell : UITableViewCell

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) UILabel *lblCaption;

@property (nonatomic, strong) UIImageView *newsImageView;

- (void)setUpUIwithModel:(NewsImageModel *) newsImageModel withBaseURL:(NSString *)url;

- (void)resetUIandPrepareForReuse;

@end
