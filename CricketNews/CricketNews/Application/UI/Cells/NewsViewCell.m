//
//  NewsViewCell.m
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NewsViewCell.h"
#import "NewsModel.h"
#import "CommonImports.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation NewsViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self.contentView
         addSubview:self.newsThumbnailImage];
        [self.contentView
         addSubview:self.lblNewsTitle];
        [self.contentView
         addSubview:self.lblPostDate];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}


- (void)updateConstraints
{
    [super updateConstraints];
    
    if (!self.didSetupConstraints)
    {
        [self.newsThumbnailImage
         autoPinEdgeToSuperviewEdge:ALEdgeTop
         withInset:PTPX(15)];
        [self.newsThumbnailImage
         autoPinEdgeToSuperviewEdge:ALEdgeLeft
         withInset:PTPX(10)];
        [self.newsThumbnailImage
         autoSetDimension:ALDimensionWidth
         toSize:PTPX(60)];
        [self.newsThumbnailImage
         autoSetDimension:ALDimensionHeight
         toSize:PTPX(60)];

        
        [self.lblNewsTitle
         autoPinEdgeToSuperviewEdge:ALEdgeTop
         withInset:PTPX(15)];
        [self.lblNewsTitle
         autoPinEdge:ALEdgeLeft
         toEdge:ALEdgeRight
         ofView:self.newsThumbnailImage
         withOffset:PTPX(10)];
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
         autoPinEdge:ALEdgeLeft
         toEdge:ALEdgeRight
         ofView:self.newsThumbnailImage
         withOffset:PTPX(10)];
        [self.lblPostDate
         autoPinEdgeToSuperviewEdge:ALEdgeRight
         withInset:PTPX(10)];

        self.didSetupConstraints = YES;
    }
}

#pragma mark – UI Creation

- (UIImageView *)newsThumbnailImage
{
    if (!_newsThumbnailImage)
    {
        _newsThumbnailImage = [UIUtils createImageView:@""];
        [_newsThumbnailImage.layer setCornerRadius:PTPX(3)];
        [_newsThumbnailImage setClipsToBounds:YES];
    }
    return _newsThumbnailImage;
}
- (UILabel *)lblNewsTitle
{
    if (!_lblNewsTitle)
    {
        _lblNewsTitle = [UIUtils createLabelWithText:@""
                                    withTextColorHex:GRAY_HEX_656565
                                   withTextAlignment:NSTextAlignmentLeft
                                            withFont:HELVETICA_NEUE_BOLD
                                         andFontSize:PTPX(13)];
//        [_lblNewsTitle setLineBreakMode:NSLineBreakByWordWrapping];
        _lblNewsTitle.numberOfLines = 2;
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


#pragma mark – Private Methods

- (void)setUpUIwithModel:(NewsModel *)model
{
    self.lblNewsTitle.text = model.headline;
    self.lblPostDate.text = [NSDate formatDate:model.timestamp withFormat:@"MMM dd, yyyy"];
    
    if ([StringUtils isStringPresent:model.image]) {
        
        [self.newsThumbnailImage sd_setImageWithURL:[NSURL URLWithString:model.image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image && cacheType == SDImageCacheTypeNone) {
                
                self.newsThumbnailImage.alpha = 0.0;
                [UIView animateWithDuration:0.7
                                 animations:^{
                                     self.newsThumbnailImage.alpha = 1.0;
                                 }];
            }
        }];
        
    }
}
- (void)resetUIandPrepareForReuse
{
    self.lblNewsTitle.text = @"";
    self.lblPostDate.text = @"";
    [self.newsThumbnailImage setImage:[UIImage imageNamed:@"news_placeholder"]];
}
@end
