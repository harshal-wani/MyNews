//
//  NewsDetailModel.h
//  CricketNews
//
//  Created by Harshal Wani on 8/9/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailModel : NSObject

@property (nonatomic, strong) NSString *headline;
@property (nonatomic, strong) NSString *newsID;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *storyType;
@property (nonatomic, strong) NSString *summary;


+ (NewsDetailModel *)createNewsDetailModelFromDictionary:(NSDictionary *)dict;

@end
