//
//  NewsImageModel.m
//  CricketNews
//
//  Created by Harshal Wani on 8/9/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NewsImageModel.h"

@implementation NewsImageModel

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
             @"id": @"imageID",
             @"cap": @"cap",
             @"url": @"url",
             @"image": @"image",
             @"width": @"width",
             @"height": @"height",
             };
}

+ (NewsImageModel *)createNewsImageModelFromDictionary:(NSDictionary *)dict
{
    NewsImageModel *newsImageModel = [[NewsImageModel alloc] init];
    
    NSDictionary *mapping = [NewsImageModel jsonMapping];
    
    for (NSString *atttribute in [dict allKeys])
    {
        NSString *classProperty = [mapping objectForKey:atttribute];
        
        NSString *attributeValue = [dict objectForKey:atttribute];
        
        if (attributeValue != nil && !([attributeValue isKindOfClass:[NSNull class]]) && classProperty != nil && !([classProperty isKindOfClass:[NSNull class]]))
        {
            [newsImageModel setValue:attributeValue
                         forKeyPath :classProperty];
        }
    }
    return newsImageModel;
}

@end
