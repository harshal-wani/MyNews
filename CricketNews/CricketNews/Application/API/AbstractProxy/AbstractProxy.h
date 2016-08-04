//
//  AbstractProxy.h
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonImports.h"
#import "AFNetworking.h"

#define BASEURL [NSURL URLWithString:BASEURLString]

@interface AbstractProxy : NSObject

- (void)getRequestDataWithURL:(NSString *)url
               andRequestName:(NSString *)requestName;

//Server request callback methods
- (void)successWithRequest:(AFHTTPRequestOperation *)operation
               withRespose:(id)responseObject
           withRequestName:(NSString *)requestName;

- (void)failedWithRequest:(AFHTTPRequestOperation *)operation
                witherror:(NSError *)error
          withRequestName:(NSString *)requestName;

//JSON object Parsing
- (id)JSONValueReturnsDictionary:(NSString *)jsonString;
- (id)JSONValueReturnsArray:(NSString *)jsonString;

@end
