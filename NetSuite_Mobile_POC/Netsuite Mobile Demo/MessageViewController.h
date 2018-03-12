//
//  MessageViewController.h
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/5.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlyMSC.h"

@interface MessageViewController
    : UIViewController <IFlySpeechSynthesizerDelegate>
@property(nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;
@end
