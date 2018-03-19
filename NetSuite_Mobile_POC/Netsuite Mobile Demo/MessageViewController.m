//
//  MessageViewController.m
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/5.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
  [super viewDidLoad];

    [self.navigationItem setTitle: @"Messages"];
    //NSString *cachedMessages = [defaults objectForKey:@"cachedMessages"];
  // Do any additional setup after loading the view.
    
    
//    NSString *htmlPath =
//    [[NSBundle mainBundle] pathForResource:@"pages/html/homepage" ofType:@"html"];
//    NSURL *url = [NSURL fileURLWithPath:htmlPath];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:(NSTimeInterval)10.0 ];
//
//    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSString *htmlPath =
    [[NSBundle mainBundle] pathForResource:@"pages/html/systemMessage" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:htmlPath];
    NSString *theAbsoluteURLString = [url absoluteString];
    
    NSString *queryString = @"?userid=1232123232";
    
    NSString *absoluteURLwithQueryString = [theAbsoluteURLString stringByAppendingString: queryString];
    
    NSURL *finalURL = [NSURL URLWithString: absoluteURLwithQueryString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:finalURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:(NSTimeInterval)0.0 ];
    
    [_webView loadRequest:request];
    
    
    
//    NSString *storedURL = @"system.na3.netsuite.com/core/media/media.nl?id=31179&c=4761902&h=6e96248aa8723b38122a&_xt=.html&userId=";
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *userName = [defaults objectForKey:@"userName"];
//    NSString *userId;
//    if([userName isEqualToString:@"user1"]){
//        userId = @"1";
//    }else if([userName isEqualToString:@"user2"]){
//        userId = @"2";
//    }else {
//        userId = @"1";
//    }
//
//    NSString *urlstring = [NSString stringWithFormat:@"https://%@",storedURL];
//    urlstring = [urlstring stringByAppendingString:userId];
//    NSURL *url = [NSURL URLWithString:urlstring];
//    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    //[_webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        
    context[@"queryMessageFromOC"] = ^{
        NSLog(@"queryMessageFromOC in");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *cachedMessages = [defaults objectForKey:@"cachedMessages"];
        [context[@"queryMessageFromOCCallBack"] callWithArguments:@[cachedMessages]];
    };
    
        
}
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

