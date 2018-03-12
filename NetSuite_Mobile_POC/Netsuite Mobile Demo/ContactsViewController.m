//
//  ContactsViewController.m
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/8.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import "ContactsViewController.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      NSString *path = [[NSBundle mainBundle] bundlePath];
      NSURL *baseURL = [NSURL fileURLWithPath:path];
      NSString *htmlPath =
          [[NSBundle mainBundle] pathForResource:@"transferDetails" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:htmlPath];
     NSString *theAbsoluteURLString = [url absoluteString];
    
    NSString *queryString = @"?c=1232123232";
    
    NSString *absoluteURLwithQueryString = [theAbsoluteURLString stringByAppendingString: queryString];
    
    NSURL *finalURL = [NSURL URLWithString: absoluteURLwithQueryString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:finalURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:(NSTimeInterval)10.0 ];
    
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
