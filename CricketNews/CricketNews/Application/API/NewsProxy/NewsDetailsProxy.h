//
//  NewsDetailsProxy.h
//  CricketNews
//
//  Created by Harshal Wani on 8/9/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "AbstractProxy.h"

typedef void(^NewsDetailsProxySuccessBlock)(NSDictionary *responseDict);

typedef void (^NewsDetailsProxyFailureBlock)(NSDictionary *responseDict);

@interface NewsDetailsProxy : AbstractProxy


@property(nonatomic, copy) NewsDetailsProxySuccessBlock successBlock;

@property(nonatomic, copy) NewsDetailsProxyFailureBlock failureBlock;


-(void)getNewsDetails:(int)newsID
          WithSuccess:(NewsDetailsProxySuccessBlock)success
          withFailure:(NewsDetailsProxyFailureBlock)failure;

@end
