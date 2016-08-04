//
//  NewsProxy.h
//  CricketNews
//
//  Created by Harshal Wani on 8/4/16.
//  Copyright © 2016 Harshal Wani. All rights reserved.
//

#import "AbstractProxy.h"

typedef void(^NewsProxySuccessBlock)(NSDictionary *responseDict);

typedef void (^NewsProxyFailureBlock)(NSDictionary *responseDict);

@interface NewsProxy : AbstractProxy


@property(nonatomic, copy) NewsProxySuccessBlock successBlock;

@property(nonatomic, copy) NewsProxyFailureBlock failureBlock;


-(void)getNewsListWithSuccess:(NewsProxySuccessBlock)success
                  withFailure:(NewsProxyFailureBlock)failure;

@end
