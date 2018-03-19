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
#import "Masonry.h"

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

-(void)viewWillDisappear:(BOOL)animated{
    [[self.navigationController.navigationBar.subviews objectAtIndex:1] removeFromSuperview];
}

- (void)loadMessage:(NSTimer *)timer {
    @try {
        NSArray *messages = [self fetchMessage];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *cachedMessages = [[defaults objectForKey:@"messages"] mutableCopy];
        if(cachedMessages == nil) {
            cachedMessages = [[NSMutableDictionary alloc] init];
        }
        
        //NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        //[userDefault setObject:_userName.text forKey:@"userName"];
        for (int i = 0 ; i < [messages count]; i++) {
            NSMutableDictionary *message = [messages[i] mutableCopy];
            NSString* messageId = message[@"messageId"];
            //&& [cachedMessages[messageId][@"type"]  isEqualToString:@"3"]
            if(cachedMessages[messageId] == nil){
                [cachedMessages setObject:message forKey:messageId];
            }
            //message
            //
        }
        for(NSString *key in cachedMessages){
            NSMutableDictionary *message = cachedMessages[key];
            long status = [message[@"status"] longValue];
            int recevierId = [message[@"recevierId"] intValue];
            if( status == 1){
                if(recevierId == 1){
                    [self speakVoice:@"您的库存调拨申请已审批通过"];
                    [message setValue:@(3) forKey:@"status"];
                } else if (recevierId == 2){
                    [self speakVoice:@"您有新的库存调拨申请待审批"];
                    [message setValue:@(3) forKey:@"status"];
                }
                
            }
            
        }
        [defaults setObject:cachedMessages forKey:@"messages"];
        
        [[self.tabBarController.viewControllers objectAtIndex:0] tabBarItem]
        .badgeValue = @"1";
    }
    @catch (NSException *exception) {
        NSLog(@"Exception");
    }
}

-(void) setUI{
    [self.navigationItem setTitle: @"WorkSpace"];

     float width = self.view.bounds.size.width -60;
     float height = self.view.bounds.size.height;
    [self.btnMic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.bottom.mas_equalTo(self.view).mas_offset(-70);
        make.height.width.mas_equalTo(100);
    }];
    [self.myHorizontalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(height * 0.22);
    }];
    [self.myCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.myHorizontalView);
        make.bottom.mas_equalTo(self.view).mas_offset(-height*0.1);
     //  make.height.mas_equalTo(425);
        make.top.equalTo(self.myHorizontalView.mas_bottom).offset(20);
    }];
  //  [self.navigationController.navigationBar addSubview:self.btnDelete];
  //  [self.btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.right.mas_equalTo(self.navigationController.navigationBar).mas_offset(-20);;
       // make.centerY.mas_equalTo(self.navigationController.navigationBar);
   //    make.width.height.mas_equalTo(32);
  //  }];

    
  //  UIView *v_delete = [[UIView alloc]initWithFrame:CGRectMake(width, 10, 32, 32)];
    UIButton *btnitem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    UIImage *img = [UIImage imageNamed:@"delete"];
    [btnitem setImage:img forState:UIControlStateNormal];
   // [v_delete addSubview:btnitem];
    UIBarButtonItem *btnDelete = [[UIBarButtonItem alloc]initWithCustomView:btnitem];
    
    self.navigationItem.rightBarButtonItem = btnDelete;
    
   // self.btnDeleteItem.image =[UIImage imageNamed: @"delete"];
   // self.navigationItem.rightBarButtonItem = self.btnDeleteItem;
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
    cell.cellLblV.frame = CGRectMake(0, cell.bounds.size.height * 0.75, cell.bounds.size.width, cell.bounds.size.height*0.25);
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.myCollection.bounds.size.height*0.43, self.myCollection.bounds.size.height*0.45);
}

//-(CGSize)collectionview:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewlayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  //  float width = (self.view.bounds.size.width *0.95 -4) /5;
  //  float height = self.view.bounds.size.height *0.515;
   // return CGSizeMake(width, width);
//}

//- (void)loadMessage:(NSTimer *)timer {
//  [[self.tabBarController.viewControllers objectAtIndex:0] tabBarItem]
//      .badgeValue = @"3";
//  NSArray *messages = [self fetchMessage];
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSArray *cachedMessages = [defaults objectForKey:@"messages"];
//    if(cachedMessages == nil) {
//        cachedMessages = messages;
//    }
//    
//    //NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    //[userDefault setObject:_userName.text forKey:@"userName"];
////    for (int i = 0 ; i < [; i++) {
////        [self speakVoice:message];
////    }
//}

- (NSArray*)fetchMessage;
{
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://forms.na3.netsuite.com/app/site/hosting/scriptlet.nl?script=363&deploy=1&compid=4761902&h=e87a8e9c51fe60c7b845&userId="];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"userName"];
    NSString *userId;
    if([userName isEqualToString:@"user1"]){
        userId = @"1";
    }else if([userName isEqualToString:@"user2"]){
        userId = @"2";
    }else {
        userId = @"1";
    }
    
    urlString = [urlString stringByAppendingString:userId];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    //    NSString *authorization = [NSString stringWithFormat:@"NLAuth nlauth_account=4944175, nlauth_email=bryan.chen@oracle.com, nlauth_signature=Tgbyujhmn1"];
    //    [request addValue:authorization forHTTPHeaderField:@"Authorization"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    
    [defaults setObject:jsonString forKey:@"cachedMessages"];
    
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

