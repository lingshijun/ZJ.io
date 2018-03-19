//
//  MessageViewController.h
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/5.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlyMSC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface MessageViewController
    : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
