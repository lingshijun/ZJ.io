//
//  HomeViewController.h
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/4.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "iflyMSC/IFlyMSC.h"
#import "CodeScanViewController.h"
#import "HorizontalView.h"

@interface HomeViewController : UIViewController <IFlySpeechSynthesizerDelegate,IFlyRecognizerViewDelegate>
//@property(weak, nonatomic) IBOutlet UIWebView *homeWebView;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;
@property(nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;
@property(nonatomic, strong) NSString *result;

@property(weak,nonatomic) IBOutlet UICollectionView *myCollection;

@property(weak,nonatomic) IBOutlet HorizontalView *myHorizontalView;

@end
