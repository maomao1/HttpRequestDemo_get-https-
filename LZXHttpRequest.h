//
//  LZXHttpRequest.h
//  HttpRequestDemo
//
//  Created by LZXuan on 15-1-7.
//  Copyright (c) 2015年 LZXuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZXHttpRequest;

typedef void (^SuccessBlock)(LZXHttpRequest *request);
typedef void(^FailedBlock)(LZXHttpRequest *request,NSError *error) ;

@interface LZXHttpRequest : NSObject <NSURLConnectionDataDelegate>
{
    //下载请求连接
    NSURLConnection *_httpRequest;
    //保存下载数据
    NSMutableData *_downloadData;
}

//区分请求
@property (nonatomic,assign) NSInteger requestTag;

//获取下载数据
@property (nonatomic,retain) NSMutableData *downloadData;
@property (nonatomic,strong) NSDictionary * HTTPHeaderDict;

//根据url 下载数据
//GET 请求
- (void)getDownloadDataFromUrlString:(NSString *)urlString  success:(SuccessBlock)success failure:(FailedBlock)failure;

@end
