//
//  NSDate+newsDates.m
//  CricketNews
//
//  Created by Harshal Wani on 8/9/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NSDate+newsDates.h"

@implementation NSDate (newsDates)

+(NSString *) formatDate:(NSString *)dateString withFormat:(NSString *)format  {
    
    NSTimeInterval seconds = [dateString doubleValue];
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    
}

@end
