//
//  LZXHttpRequest.m
//  HttpRequestDemo
//
//  Created by LZXuan on 15-1-7.
//  Copyright (c) 2015年 LZXuan. All rights reserved.
//

#import "LZXHttpRequest.h"
@interface LZXHttpRequest ()
@property (nonatomic,copy) SuccessBlock mySuccessBlock;
@property (nonatomic,copy) FailedBlock myFailedBlock;
@end
//arc环境
@implementation LZXHttpRequest

- (id)init {
    if (self = [super init]) {
        _downloadData = [[NSMutableData alloc] init];
    }
    return self;
}

// GET http://zhiyue.cutt.com/api/user/feeds?full=1&offset=& HTTP/1.1
// Host: zhiyue.cutt.com
// User-Agent: ZhiyueSD236492/15024 CFNetwork/711.1.12 Darwin/14.0.0 Paros/3.2.13
// app: 236492
// Accept: */*
//Accept-Language: zh-cn
//UA: ZhiyueSD236492 iPhone 1.21000 (15024) (iPhone7,1; iPhone OS 8.1) Dn/Xuan_iPhone
//Connection: keep-alive
//Proxy-Connection: keep-alive
//device: 8295d2474b7690ca53e3be4c7bbd6eca6d828a78
//

#pragma mark - GET 请求
//下载数据 创建 下载请求连接
- (void)getDownloadDataFromUrlString:(NSString *)urlString success:(SuccessBlock)success failure:(FailedBlock)failure{
    if (_httpRequest) {
        [_httpRequest cancel];
        _httpRequest = nil;
    }
    //拷贝block
    self.myFailedBlock = failure;
    self.mySuccessBlock = success;
    
    //如果 url 字符串中有中文或者非法的字符 需要进行转码
    NSString *newUrl = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    //上面的get请求 还需要设置 请求头 否则请求不下来数据
    //一般get请求都是不需要设置请求头的
    //如果是上面的情况那么我们设置请求头就可以了
    
    
    //可变的下载请求
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:newUrl]];
    
    mutableRequest.HTTPShouldHandleCookies = YES;
    //请求方式
    mutableRequest.HTTPMethod = @"GET";
    //需要设置请求头
    //根据字典设置 请求头
    //把app:236492 添加到请求头
    
    if (self.HTTPHeaderDict) {
        [mutableRequest setAllHTTPHeaderFields:self.HTTPHeaderDict];
    }
    
    
    //或
    //[mutableRequest setValue:@"236492" forHTTPHeaderField:@"app"];
    
    //创建下载请求连接
    _httpRequest = [[NSURLConnection alloc] initWithRequest:mutableRequest delegate:self];
    
    
}


#pragma mark -  NSURLConnectionDataDelegate
//客户端接收 服务端的响应 调用
//发数据之前的响应
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //清空 downloadData
    [self.downloadData setLength:0];
}

//接收下载数据调用
//一段一段 发数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //拼接
    [self.downloadData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    //下载完成 通知代理
    if (self.mySuccessBlock) {
        self.mySuccessBlock(self);
        
    }else {
        NSLog(@"下载成功block回调没有实现");
    }
}
//请求失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //下载失败之后 通知代理
    if (self.myFailedBlock) {
        self.myFailedBlock(self,error);
    }else {
        NSLog(@"失败block回调没有实现");
    }
}

//GET https://chanyouji.com/api/destinations.json HTTP/1.1
//Host: chanyouji.com
//Connection: Keep-Alive
//User-Agent: 2.3;Meizu M351;Android 4.4.4;4.0 Paros/3.2.13
//Authorization: Basic VnF3RlU0c2Q5U05MVHZra3BtMVA=

//下面两段是重点，要服务器端单项HTTPS 验证，iOS 客户端忽略证书验证。

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
   // NSLog(@"didReceiveAuthenticationChallenge %@ %zd", [[challenge protectionSpace] authenticationMethod], (ssize_t) [challenge previousFailureCount]);
    
    
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
        
    }
    
}



@end
