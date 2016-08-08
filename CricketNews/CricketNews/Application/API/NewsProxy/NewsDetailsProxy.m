//
//  NewsDetailsProxy.m
//  CricketNews
//
//  Created by Harshal Wani on 8/9/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "NewsDetailsProxy.h"

@implementation NewsDetailsProxy

static NSString *const kNEWS_DETAILS_API_URL = @"interview/newsdetail";

static NSString *const kNEWS_DETAILS_API_NAME = @"NewsDetails";

//h ttp://m.cricbuzz.com/interview/newsdetail/

-(void)getNewsDetails:(int)newdID
          WithSuccess:(NewsDetailsProxySuccessBlock)success
          withFailure:(NewsDetailsProxyFailureBlock)failure{

    self.successBlock = success;
    self.failureBlock = failure;

    [super getRequestDataWithURL:[NSString stringWithFormat:@"%@/%d",kNEWS_DETAILS_API_URL,newdID]
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
    
    self.successBlock(responseDict);
    
}

- (void)handleFailureCountryDetailsAPIWithResponse:(NSDictionary *)returnDictionary
{
    self.failureBlock(returnDictionary);
}

@end
