//
//  NewsModel.h
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, strong) NSString *headline;
@property (nonatomic, strong) NSString *newsID;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *image;

+ (NewsModel *)createNewsModelFromDictionary:(NSDictionary *)dict;

@end
