//
//  CodeScanViewController.h
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/4.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CodeScanViewController : UIViewController
@property(strong, nonatomic) AVCaptureDevice *device;
@property(strong, nonatomic) AVCaptureDeviceInput *input;
@property(strong, nonatomic) AVCaptureMetadataOutput *output;
@property(strong, nonatomic) AVCaptureSession *session;
@property(strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@property(nonatomic, strong) CALayer *containerLayer;

@property(strong, nonatomic) NSString *code;
@end
