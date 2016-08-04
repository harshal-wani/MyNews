//
//  AbstractProxy.m
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "AbstractProxy.h"

@interface AbstractProxy()

@property (nonatomic, retain) AFHTTPRequestOperationManager *aFHTTPRequestOperationManager;

@end

@implementation AbstractProxy


#pragma mark - AFHTTPREQUEST Operations Methods


- (AFHTTPRequestOperationManager *)getRequestManager
{
    if (!self.aFHTTPRequestOperationManager)
    {
        self.aFHTTPRequestOperationManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:BASEURL];
        
        [self.aFHTTPRequestOperationManager
         setResponseSerializer:[AFJSONResponseSerializer serializer]];
        
        [self.aFHTTPRequestOperationManager
         setRequestSerializer:[AFJSONRequestSerializer serializer]];
        
        //        self.aFHTTPRequestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        
    }
    return self.aFHTTPRequestOperationManager;
}
- (void)getRequestDataWithURL:(NSString *)url
               andRequestName:(NSString *)requestName
{
    if (![NetworkUtils hasNetworkAndDisplayPopupIfNot])
    {
        return;
    }
    [[self getRequestManager] GET:url
                       parameters:nil
                          success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                              [self successWithRequest:operation
                                           withRespose:responseObject
                                       withRequestName:requestName];
                          }
                          failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                              [self failedWithRequest:operation
                                            witherror:error
                                      withRequestName:requestName];
                          }];
}
#pragma mark - Server request callback methods

- (void)successWithRequest:(AFHTTPRequestOperation *)operation
               withRespose:(id)responseObject
           withRequestName:(NSString *)requestName
{
}

- (void)failedWithRequest:(AFHTTPRequestOperation *)operation
                witherror:(NSError *)error
          withRequestName:(NSString *)requestName
{
}

#pragma mark - JSON object Parsing -

- (id)JSONValueReturnsDictionary:(NSString *)jsonString
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *mainDict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableContainers
                                                               error:nil];
    
    return mainDict;
}

- (id)JSONValueReturnsArray:(NSString *)jsonString
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *returnArray = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:nil];
    
    return returnArray;
}

@end
