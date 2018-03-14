//
//  HomeViewController.m
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/4.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import "HomeViewController.h"
#import <Foundation/Foundation.h>
#import "CollectionViewCell.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                target:self
                                              selector:@selector(loadMessage:)
                                              userInfo:nil
                                               repeats:YES];
    [self setUI];

}

-(void) setUI{
    
    self.myHorizontalView.frame = CGRectMake(self.view.bounds.size.width * 0.03, 101, self.view.bounds.size.width *0.95, self.view.bounds.size.height *0.22);
    self.myCollection.frame = CGRectMake(self.view.bounds.size.width * 0.03, self.myHorizontalView.frame.origin.y + self.myHorizontalView.frame.size.height + 20, self.view.bounds.size.width *0.95, self.view.bounds.size.height *0.53);
}
#pragma mark ---UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (NSArray*)imgName
{
    return @[@"commodity_Inquiry",@"stock_take",@"inventory_allocation",@"inbound",@"store_map",@"outbound",@"add"];
}

- (NSArray*)lblText
{
    return @[@"Commodity Inquiry",@"Stock Take",@"Inventory Transfer",@"Inbound",@"Store Map",@"Outbound",@"More"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"myCell";
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.cellImg.image = [UIImage imageNamed: self.imgName[indexPath.row]];
    cell.cellLbl.text = self.lblText[indexPath.row];
    cell.cellLbl.textAlignment = NSTextAlignmentCenter;
    return cell;
    
}

//-(CGSize)collectionview:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewlayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  //  float width = (self.view.bounds.size.width *0.95 -4) /5;
  //  float height = self.view.bounds.size.height *0.515;
   // return CGSizeMake(width, width);
//}

- (void)loadMessage:(NSTimer *)timer {
  [[self.tabBarController.viewControllers objectAtIndex:0] tabBarItem]
      .badgeValue = @"3";
  NSArray *messages = [self fetchMessage];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *cachedMessages = [defaults objectForKey:@"messages"];
    if(cachedMessages == nil) {
        cachedMessages = messages;
    }
    
    //NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //[userDefault setObject:_userName.text forKey:@"userName"];
//    for (int i = 0 ; i < [; i++) {
//        [self speakVoice:message];
//    }
}

- (NSArray*)fetchMessage;
{
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://forms.na3.netsuite.com/app/site/hosting/scriptlet.nl?script=363&deploy=1&compid=4761902&h=e87a8e9c51fe60c7b845&userId=?"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"userName"];
    NSString *userId;
    if([userName isEqualToString:@"user1"]){
        userId = @"1";
    }else if([userName isEqualToString:@"user2"]){
        userId = @"2";
    }

    urlString = [urlString stringByAppendingString:userId];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSString *authorization = [NSString stringWithFormat:@"NLAuth nlauth_account=4944175, nlauth_email=bryan.chen@oracle.com, nlauth_signature=Tgbyujhmn1"];
    [request addValue:authorization forHTTPHeaderField:@"Authorization"];

    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];

    //NSString *custrecordMessage = dic[@"custrecord_message"];

    return jsonArray;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)speakVoice:(NSString *)message {
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
//  NSString *managerMessage =
//      [userName stringByAppendingString:@"您有新的库存调拨申请待审批"];
//    NSString *clerkMessage =
//    [userName stringByAppendingString:@"您的库存调拨申请已审批通过"];
    NSLog(@"message：%@",message);

  [_iFlySpeechSynthesizer startSpeaking:message];
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

- (void)recognizeMethod {
  self.iflyRecognizerView =
      [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
  self.iflyRecognizerView.delegate = self;
  [self.iflyRecognizerView setParameter:@"iat"
                                 forKey:[IFlySpeechConstant IFLY_DOMAIN]];
  [self.iflyRecognizerView setParameter:@"asrview.pcm"
                                 forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
  [self.iflyRecognizerView start];
}

- (IBAction)recognizerAction:(id)sender {
  if (self.iflyRecognizerView) {
  } else {
    [self recognizeMethod];
  }
}

- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast {
  NSDictionary *dic = resultArray[0];
  NSString *keyString = dic.allKeys[0];
  NSString *resultString = [self jsonToStringWithSourceString:keyString];

  if ([resultString isEqualToString:@"扫码"]) {
    [self performSegueWithIdentifier:@"scanCodeIdentifier" sender:nil];
  } else if ([resultString isEqualToString:@"商品查询"]) {
    [self performSegueWithIdentifier:@"itemSearchIdentifier" sender:nil];
  }
  [self.iflyRecognizerView cancel];
  self.iflyRecognizerView = nil;
}

- (NSString *)jsonToStringWithSourceString:(NSString *)sourceString {
  if (sourceString == NULL) {
    return @"";
  }

  NSData *sourceData = [sourceString dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *dic =
      [NSJSONSerialization JSONObjectWithData:sourceData
                                      options:NSJSONReadingAllowFragments
                                        error:nil];
  NSMutableString *resultMString = [[NSMutableString alloc] initWithString:@""];

  if (dic) {
    NSArray *wsArray = dic[@"ws"];
    for (NSDictionary *wsDic in wsArray) {
      NSArray *cwArray = wsDic[@"cw"];
      for (NSDictionary *cwDic in cwArray) {
        NSString *wString = cwDic[@"w"];
        [resultMString appendString:wString];
      }
    }
  }
  return resultMString;
}

//识别会话结束返回代理
- (void)onError:(IFlySpeechError *)error {
}
//停止录音回调
- (void)onEndOfSpeech {
}
//开始录音回调
- (void)onBeginOfSpeech {
}
//音量回调函数
- (void)onVolumeChanged:(int)volume {
}
//会话取消回调
- (void)onCancel {
}

- (IBAction)unwindToContainerVC:(UIStoryboardSegue *)segue {
  if ([segue.identifier isEqualToString:@"unwindToContainerVC"]) {
    // CodeScanViewController *codeScanViewController =
    // segue.sourceViewController;
    dispatch_async(dispatch_get_main_queue(), ^{
      [self performSegueWithIdentifier:@"itemSearchIdentifier" sender:nil];
    });
  }
}

@end

