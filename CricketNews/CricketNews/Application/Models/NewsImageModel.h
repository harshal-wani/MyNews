//
//  NewsImageModel.h
//  CricketNews
//
//  Created by Harshal Wani on 8/9/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsImageModel : NSObject

@property (nonatomic, strong) NSString *imageID;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *cap;
@property (nonatomic, strong) NSString *width;
@property (nonatomic, strong) NSString *height;


+ (NewsImageModel *)createNewsImageModelFromDictionary:(NSDictionary *)dict;

@end
