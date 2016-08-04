//
//  NewsProxy.m
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NewsProxy.h"
#import "NewsModel.h"

@implementation NewsProxy

static NSString *const kCOUNTRY_DETAILS_API_URL = @"interview/newslist";

static NSString *const kCOUNTRY_DETAILS_API_NAME = @"countryDetails";
//http://m.cricbuzz.com/interview/newslist
- (void)getNewsListWithSuccess:(NewsProxySuccessBlock)success withFailure:(NewsProxyFailureBlock)failure{
    
    self.successBlock = success;
    self.failureBlock = failure;
    //h ttps://dl.dropboxusercontent.com/u/746330/facts.json
    [super getRequestDataWithURL:kCOUNTRY_DETAILS_API_URL
                  andRequestName:kCOUNTRY_DETAILS_API_NAME];
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
        [self handleSuccessCountryDetailsAPIWithResponse:operation.responseString];
        
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
    [self handleFailureCountryDetailsAPIWithResponse:returnDictionary];
}

#pragma mark - Handler -

- (void)handleSuccessCountryDetailsAPIWithResponse:(NSString *)responseString
{
    NSDictionary *responseDict = [self JSONValueReturnsDictionary:responseString];
    
    if ([responseDict isKindOfClass:[NSDictionary class]])
    {
        NSMutableArray *newsModelArray = [[NSMutableArray alloc] init];
        
        for (NSInteger iterator = 0; iterator < [responseDict[@"news"] count]; iterator++)
        {
            NSDictionary *objectDictionary = responseDict[@"news"][iterator];
            
            if ([objectDictionary isKindOfClass:[NSDictionary class]])
            {
                
                NewsModel *newsModel = [NewsModel createNewsModelFromDictionary:objectDictionary];
                
                [newsModelArray addObject:newsModel];
            }
        }
        
        NSDictionary *modelDict = @{
                                    @"news": newsModelArray,
                                    @"detailed_URL":responseDict[@"detailed_URL"]
                                    };
        
        self.successBlock(modelDict);
    }
    else
    {
        NSDictionary *returnDictionary = @{
                                           @"message":COMMUNICATION_WITH_SERVER_FAILED
                                           };
        self.failureBlock(returnDictionary);
    }
    
}

- (void)handleFailureCountryDetailsAPIWithResponse:(NSDictionary *)returnDictionary
{
    self.failureBlock(returnDictionary);
}

@end
