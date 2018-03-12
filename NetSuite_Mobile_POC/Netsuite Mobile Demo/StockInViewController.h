//
//  StockInViewController.h
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/4.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFlyMSC/IFlyMSC.h"

@interface StockInViewController : UIViewController
@property(nonatomic, strong) NSString *pcmFilePath;
@property(nonatomic, strong)
    IFlyRecognizerView *iflyRecognizerView;
@property(nonatomic, strong) IFlyDataUploader *uploader;
@property(weak, nonatomic) IBOutlet UISearchBar *itemSearchBar;
@property(nonatomic, strong) NSString *result;

@end
