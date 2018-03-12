//
//  StockInViewController.m
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/4.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import "StockInViewController.h"
#import "CodeScanViewController.h"

@interface StockInViewController () <IFlyRecognizerViewDelegate,
                                     AVCaptureMetadataOutputObjectsDelegate>

@end

@implementation StockInViewController

- (void)viewDidLoad {
  [super viewDidLoad];
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

- (IBAction)scanAction:(id)sender {
  [self performSegueWithIdentifier:@"scanCodeIdentifier" sender:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)onError:(IFlySpeechError *)error {
}

- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast {
  NSDictionary *dic = resultArray[0];
  NSString *keyString = dic.allKeys[0];
  NSString *resultString = [self jsonToStringWithSourceString:keyString];

  if ([resultString isEqualToString:@"扫码"]) {
    [self performSegueWithIdentifier:@"scanCodeIdentifier" sender:nil];
  } else {
    [_itemSearchBar setText:resultString];
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

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
}

- (void)traitCollectionDidChange:
    (nullable UITraitCollection *)previousTraitCollection {
}

- (void)preferredContentSizeDidChangeForChildContentContainer:
    (nonnull id<UIContentContainer>)container {
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:
    (nonnull id<UIContentContainer>)container {
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:
           (nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
}

- (void)
willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection
      withTransitionCoordinator:
          (nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context
       withAnimationCoordinator:
           (nonnull UIFocusAnimationCoordinator *)coordinator {
}

- (void)setNeedsFocusUpdate {
}

- (void)updateFocusIfNeeded {
}

- (IBAction)unwindToContainerVC:(UIStoryboardSegue *)segue {
  if ([segue.identifier isEqualToString:@"unwindToContainerVC"]) {
    CodeScanViewController *codeScanViewController = segue.sourceViewController;
    [_itemSearchBar setText:codeScanViewController.code];
  }
}

@end
