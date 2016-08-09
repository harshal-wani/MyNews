//
//  NewsDetailsProxy.m
//  CricketNews
//
//  Created by Harshal Wani on 8/9/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NewsDetailsProxy.h"
#import "NewsDetailModel.h"
#import "NewsImageModel.h"

@implementation NewsDetailsProxy

static NSString *const kNEWS_DETAILS_API_URL = @"interview/newsdetail";

static NSString *const kNEWS_DETAILS_API_NAME = @"NewsDetails";

-(void)getNewsDetails:(int)newsID
          WithSuccess:(NewsDetailsProxySuccessBlock)success
          withFailure:(NewsDetailsProxyFailureBlock)failure{

    self.successBlock = success;
    self.failureBlock = failure;
    
    [super getRequestDataWithURL:[NSString stringWithFormat:@"%@/%d",kNEWS_DETAILS_API_URL,newsID]
                  andRequestName:kNEWS_DETAILS_API_NAME];
}

#pragma mark - Server request callback methods -

- (void)successWithRequest:(AFHTTPRequestOperation *)operation
               withRespose:(id)responseObject
           withRequestName:(NSString *)requestName
{
    NSDictionary *returnDictionary = nil;
    
    if (operation.responseString != nil)
    {
        returnDictionary = [self JSONValueReturnsDictionary:operation.responseString];
    }
    if (![returnDictionary isKindOfClass:[NSNull class]])
    {
        [self handleSuccessNewsDetailsAPIWithResponse:operation.responseString];
        
    }
}

- (void)failedWithRequest:(AFHTTPRequestOperation *)operation
                witherror:(NSError *)error
          withRequestName:(NSString *)requestName
{
    
    NSDictionary *returnDictionary = nil;
    
    if (operation.responseString != nil)
    {
        returnDictionary = [self JSONValueReturnsDictionary:operation.responseString];
    }
    else
    {
        returnDictionary = @{
                             @"message":COMMUNICATION_WITH_SERVER_FAILED
                             };
    }
    [self handleFailureNewsDetailsAPIWithResponse:returnDictionary];
}

#pragma mark - Handler -

- (void)handleSuccessNewsDetailsAPIWithResponse:(NSString *)responseString
{
    NewsDetailModel *newsDetailModel = [[NewsDetailModel alloc] init];
    
    NSDictionary *responseDict = [self JSONValueReturnsDictionary:responseString];
    
    NSDictionary *objectDictionary = responseDict[@"news_info"];
    
    if ([objectDictionary isKindOfClass:[NSDictionary class]])
    {
        newsDetailModel = [NewsDetailModel createNewsDetailModelFromDictionary:objectDictionary];        
    }
    
    NSMutableArray *newsImagesArray = [[NSMutableArray alloc] init];
    
    for (NSInteger iterator = 0; iterator < [responseDict[@"images"] count]; iterator++)
    {
        NSDictionary *objectDictionary = responseDict[@"images"][iterator];
        
        if ([objectDictionary isKindOfClass:[NSDictionary class]])
        {
            NewsImageModel *newsImageModel = [NewsImageModel createNewsImageModelFromDictionary:objectDictionary];
            [newsImagesArray addObject:newsImageModel];
        }
    }
    
    NSDictionary *modelDict = @{
                                @"newsInfo": newsDetailModel,
                                @"images": newsImagesArray,
                                @"imageURL":responseDict[@"image_url"]
                                };
    self.successBlock(modelDict);
    
}

- (void)handleFailureNewsDetailsAPIWithResponse:(NSDictionary *)returnDictionary
{
    self.failureBlock(returnDictionary);
}

@end
