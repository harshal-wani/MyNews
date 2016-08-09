//
//  NewsImageWithCaptionCell.m
//  CricketNews
//
//  Created by Harshal Wani on 8/9/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NewsImageWithCaptionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CommonImports.h"
#import "NewsImageModel.h"

@implementation NewsImageWithCaptionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
               reuseIdentifier :reuseIdentifier];
    
    if (self)
    {
        [self configureUI];
        [self setNeedsUpdateConstraints];
    }
    
    return self;
}

#pragma mark - UI Configuration -

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (!self.didSetupConstraints)
    {
        
        [self.newsImageView
         autoPinEdgeToSuperviewEdge:ALEdgeTop
         withInset:PTPX(10)];
        [self.newsImageView
         autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.newsImageView
         autoSetDimension:ALDimensionWidth
         toSize:PTPX(300)];
        [self.newsImageView
         autoSetDimension:ALDimensionHeight
         toSize:PTPX(300)];
        [self.newsImageView
         autoPinEdgeToSuperviewEdge:ALEdgeBottom
         withInset:5
         relation:NSLayoutRelationGreaterThanOrEqual];
        
        
        [self.lblCaption
         autoPinEdge:ALEdgeTop
         toEdge:ALEdgeBottom
         ofView:self.newsImageView
         withOffset:PTPX(5)];
        [self.lblCaption
         autoPinEdgeToSuperviewEdge:ALEdgeLeft
         withInset:PTPX(10)];
        [self.lblCaption
         autoPinEdgeToSuperviewEdge:ALEdgeRight
         withInset:PTPX(10)];
        
        [self.lblCaption
         setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
         forAxis:UILayoutConstraintAxisVertical];
        [self.lblCaption
         setContentHuggingPriority:UILayoutPriorityDefaultHigh
         forAxis:UILayoutConstraintAxisVertical];
        
        [self.lblCaption
         autoPinEdgeToSuperviewEdge:ALEdgeBottom
         withInset:PTPX(10)];
        
        
    }
}
- (void)configureUI
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self
     setBackgroundColor:[UIColor clearColor]];
    [self.contentView
     addSubview:self.newsImageView];
    [self.contentView
     addSubview:self.lblCaption];

}

#pragma mark - UI Creation -

- (UIImageView *)newsImageView
{
    if (!_newsImageView)
    {
        _newsImageView = [UIUtils createImageView:@"country_placeholder"];
    }
    return _newsImageView;
}

- (UILabel *)lblCaption
{
    if (!_lblCaption)
    {
        _lblCaption = [UIUtils createLabelWithText:@""
                                withTextColorHex:BLACK_HEX_000000
                               withTextAlignment:NSTextAlignmentLeft
                                        withFont:HELVETICA_NEUE
                                     andFontSize:PTPX(12)];
        _lblCaption.numberOfLines = 0;
    }
    return _lblCaption;
}


#pragma mark - Public Method -

- (void)setUpUIwithModel:(NewsImageModel *) newsImageModel withBaseURL:(NSString *)url
{
    self.lblCaption.text = newsImageModel.cap;
    
    if ([StringUtils isStringPresent:newsImageModel.url]) {
        
        [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",url,newsImageModel.url]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if (image && cacheType == SDImageCacheTypeNone) {
                
                self.newsImageView.alpha = 0.0;
                [UIView animateWithDuration:0.7
                                 animations:^{
                                     self.newsImageView.alpha = 1.0;
                }];
            }
        }];
        
    }
}
- (void)resetUIandPrepareForReuse
{
    self.lblCaption.text = @"";
    [self.newsImageView
     setImage:[UIImage imageNamed:@"country_placeholder"]];
}

@end
