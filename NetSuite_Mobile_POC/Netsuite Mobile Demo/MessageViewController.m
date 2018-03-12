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

  // Do any additional setup after loading the view.
}
- (IBAction)speakVoice:(id)sender {
  //获取语音合成单例
  _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
  //设置协议委托对象
  _iFlySpeechSynthesizer.delegate = self;
  //设置合成参数
  //设置在线工作方式
  [_iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                forKey:[IFlySpeechConstant ENGINE_TYPE]];
  //设置音量，取值范围 0~100
  [_iFlySpeechSynthesizer setParameter:@"50"
                                forKey:[IFlySpeechConstant VOLUME]];
  //发音人，默认为”xiaoyan”，可以设置的参数列表可参考“合成发音人列表”
  [_iFlySpeechSynthesizer setParameter:@" xiaoyan "
                                forKey:[IFlySpeechConstant VOICE_NAME]];
  //保存合成文件名，如不再需要，设置为nil或者为空表示取消，默认目录位于library/cache下
  [_iFlySpeechSynthesizer setParameter:@" tts.pcm"
                                forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
  //启动合成会话
  [_iFlySpeechSynthesizer startSpeaking:@"你"
                                        @"好，您有一条新的消息"];
}

// IFlySpeechSynthesizerDelegate协议实现
//合成结束
- (void)onCompleted:(IFlySpeechError *)error {
}
//合成开始
- (void)onSpeakBegin {
}
//合成缓冲进度
- (void)onBufferProgress:(int)progress message:(NSString *)msg {
}
//合成播放进度
- (void)onSpeakProgress:(int)progress
               beginPos:(int)beginPos
                 endPos:(int)endPos {
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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

