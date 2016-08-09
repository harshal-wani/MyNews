//
//  NSDate+newsDates.h
//  CricketNews
//
//  Created by Harshal Wani on 8/9/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (newsDates)

+(NSString *) formatDate:(NSString *)dateString withFormat:(NSString *)format;

@end
