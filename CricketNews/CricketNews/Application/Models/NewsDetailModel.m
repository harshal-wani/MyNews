//
//  NewsDetailModel.m
//  CricketNews
//
//  Created by Harshal Wani on 8/9/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NewsDetailModel.h"

@implementation NewsDetailModel

#pragma mark - Initialisation

- (instancetype)init
{
    self = [super init];
    return self;
}

#pragma mark - Parsing Method -

+ (NSDictionary *)jsonMapping
{
    return @{
             @"id": @"newsID",
             @"headline": @"headline",
             @"timestamp": @"timestamp",
             @"location": @"location",
             @"story_type": @"storyType",
             @"source": @"source",
             @"summary": @"summary"
             };
}

+ (NewsDetailModel *)createNewsDetailModelFromDictionary:(NSDictionary *)dict
{
    NewsDetailModel *newsDetailModel = [[NewsDetailModel alloc] init];
    
    NSDictionary *mapping = [NewsDetailModel jsonMapping];
    
    for (NSString *atttribute in [dict allKeys])
    {
        NSString *classProperty = [mapping objectForKey:atttribute];
        
        NSString *attributeValue = [dict objectForKey:atttribute];
        
        if (attributeValue != nil && !([attributeValue isKindOfClass:[NSNull class]]) && classProperty != nil && !([classProperty isKindOfClass:[NSNull class]]))
        {
            [newsDetailModel setValue:attributeValue
                          forKeyPath :classProperty];
        }
    }
    return newsDetailModel;
}

@end
