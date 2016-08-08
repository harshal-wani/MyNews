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
        [self.contentView
         addSubview:self.lblNewsDescription];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        //        self.layer.cornerRadius = PTPX(3);
        //        self.layer.borderColor = [UIUtils colorFromHexColor:BLACK_LIGHT_HEX_C0C0C0].CGColor;
        //        self.layer.borderWidth = 1;
        
        self.clipsToBounds = YES;
        
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


        
        [self.lblNewsDescription
         autoPinEdge:ALEdgeTop
         toEdge:ALEdgeBottom
         ofView:self.newsThumbnailImage
         withOffset:PTPX(5)];
        [self.lblNewsDescription
         autoPinEdgeToSuperviewEdge:ALEdgeLeft
         withInset:PTPX(10)];
        [self.lblNewsDescription
         autoPinEdgeToSuperviewEdge:ALEdgeRight
         withInset:PTPX(10)];
        [self.lblNewsDescription
         setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
         forAxis:UILayoutConstraintAxisVertical];
        [self.lblNewsDescription
         setContentHuggingPriority:UILayoutPriorityDefaultHigh
         forAxis:UILayoutConstraintAxisVertical];


        [self.lblNewsDescription
         autoPinEdgeToSuperviewEdge:ALEdgeBottom
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
                                            withFont:HELVETICA_NEUE
                                         andFontSize:PTPX(12)];
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
- (UILabel *)lblNewsDescription
{
    if (!_lblNewsDescription)
    {
        _lblNewsDescription = [UIUtils createLabelWithText:@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"
                                   withTextColorHex:GRAY_HEX_656565
                                  withTextAlignment:NSTextAlignmentLeft
                                           withFont:HELVETICA_NEUE
                                        andFontSize:PTPX(12)];
        [_lblNewsDescription setLineBreakMode:NSLineBreakByWordWrapping];
        _lblNewsDescription.numberOfLines = 0;
    }
    return _lblNewsDescription;
}

#pragma mark – Private Methods

- (void)setUpUIwithModel:(NewsModel *)model
{
    self.lblNewsTitle.text = model.headline;
    self.lblPostDate.text = [NewsViewCell formatDate:model.timestamp];
    
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

+(NSString *) formatDate:(NSString *)fromDate {
    
    NSTimeInterval seconds = [fromDate doubleValue];
    
    NSDate *expDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm a"];
    
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:expDate]];
    
}

@end
