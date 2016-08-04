//
//  NewsModel.m
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

#pragma mark - Initialisation

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
    }
    
    return self;
}

#pragma mark - Parsing Method -

+ (NSDictionary *)jsonMapping
{
    return @{
             @"id": @"newsID",
             @"headline": @"headline",
             @"timestamp": @"timestamp",
             @"image": @"image",
             @"location": @"location"
             };
}

+ (NewsModel *)createNewsModelFromDictionary:(NSDictionary *)dict
{
    NewsModel *newsModel = [[NewsModel alloc] init];
    
    NSDictionary *mapping = [NewsModel jsonMapping];
    
    for (NSString *atttribute in [dict allKeys])
    {
        NSString *classProperty = [mapping objectForKey:atttribute];
        
        NSString *attributeValue = [dict objectForKey:atttribute];
        
        if (attributeValue != nil && !([attributeValue isKindOfClass:[NSNull class]]) && classProperty != nil && !([classProperty isKindOfClass:[NSNull class]]))
        {
            [newsModel setValue:attributeValue
                    forKeyPath :classProperty];
        }
    }
    return newsModel;
}

@end
