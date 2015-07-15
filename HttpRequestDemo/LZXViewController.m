//
//  LZXViewController.m
//  HttpRequestDemo
//
//  Created by LZXuan on 15-1-7.
//  Copyright (c) 2015年 LZXuan. All rights reserved.
//

#import "LZXViewController.h"
#import "LZXHttpRequest.h"

@interface LZXViewController ()

@end

@implementation LZXViewController

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




//get 请求头
- (void)creatHttpRequest {
    LZXHttpRequest* http = [[LZXHttpRequest alloc] init];
    
    //这个get请求需要 发送 必要的请求头 app:236492
    
    http.HTTPHeaderDict = @{@"app": @"236492"};
    [http getDownloadDataFromUrlString:@"http://zhiyue.cutt.com/api/user/feeds?full=1&offset=&" success:^(LZXHttpRequest *request) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:request.downloadData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dict:%@",dict);
        
    } failure:^(LZXHttpRequest *request, NSError *error) {
        NSLog(@"error:%@",error);
    }];
    NSLog(@"*******************");
}

//https认证

//GET https://chanyouji.com/api/destinations.json HTTP/1.1
//Host: chanyouji.com
//Connection: Keep-Alive
//User-Agent: 2.3;Meizu M351;Android 4.4.4;4.0 Paros/3.2.13
//Authorization: Basic VnF3RlU0c2Q5U05MVHZra3BtMVA=
- (void)creatHttpRequest2 {
    
    LZXHttpRequest* http = [[LZXHttpRequest alloc] init];
    [http getDownloadDataFromUrlString:@"https://chanyouji.com/api/destinations.json" success:^(LZXHttpRequest *request) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:request.downloadData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dict:%@",arr);
        
    } failure:^(LZXHttpRequest *request, NSError *error) {
        NSLog(@"error:%@",error);
    }];
}


//GET http://guang.taobao.com/street/ajax/getStreetSource.json?cpage=1&_input_charset=utf-8&cat_id=6&tag_id=11168&type=1&minPrice=-1&maxPrice=0&t=1420778173&callback=jsonp250 HTTP/1.1
//Host: guang.taobao.com
//Referer: http://guang.taobao.com/square/index.htm
//Proxy-Connection: keep-alive
//Accept: */*
//          Cookie: cookie2=13384a0da05a4a34788fdb4c0e8b218f; t=17609e03bcfbeb7a4dfdd4194fbb7d98; v=0
//          Accept-Language: zh-cn
//          Connection: keep-alive
//          User-Agent: jiaju/5.7.1 CFNetwork/711.1.16 Darwin/14.0.0 Paros/3.2.13

- (void)getCookie {
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//    [cookieProperties setObject:@"13384a0da05a4a34788fdb4c0e8b218f" forKey:@"cookie2"];
//    [cookieProperties setObject:@"17609e03bcfbeb7a4dfdd4194fbb7d98" forKey:@"t"];
//    [cookieProperties setObject:@"0" forKey:@"v"];
//    
//    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    //[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    LZXHttpRequest* http = [[LZXHttpRequest alloc] init];
    //http.HTTPHeaderDict = @{@"Cookie":@"cookie2=13384a0da05a4a34788fdb4c0e8b218f t=17609e03bcfbeb7a4dfdd4194fbb7d98 v=0"};
    [http getDownloadDataFromUrlString:@"http://guang.taobao.com/street/ajax/getStreetSource.json?cpage=1&_input_charset=utf-8&cat_id=6&tag_id=11168&type=1&minPrice=-1&maxPrice=0&t=1420778173&callback=jsonp250" success:^(LZXHttpRequest *request) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:request.downloadData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dict:%@",dict);
        
    } failure:^(LZXHttpRequest *request, NSError *error) {
        NSLog(@"error:%@",error);
    }];

    
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    //get 添加请求头
    //[self creatHttpRequest];
    
    //https认证
    //[self creatHttpRequest2];
    
    [self getCookie];
    NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie*cookie in [cookieJar cookies]) {
        NSLog(@"%@", cookie);
    }

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
