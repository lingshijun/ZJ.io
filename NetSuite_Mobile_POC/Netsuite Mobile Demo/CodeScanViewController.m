//
//  CodeScanViewController.m
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/4.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import "CodeScanViewController.h"
@interface CodeScanViewController () <AVCaptureMetadataOutputObjectsDelegate>

@end
@implementation CodeScanViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self startScan];
}

- (AVCaptureDevice *)device {
  if (_device == nil) {
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  }
  return _device;
}

- (AVCaptureDeviceInput *)input {
  if (_input == nil) {
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
  }
  return _input;
}

- (AVCaptureSession *)session {
  if (_session == nil) {
    _session = [[AVCaptureSession alloc] init];
  }
  return _session;
}

- (AVCaptureVideoPreviewLayer *)previewLayer {
  if (_previewLayer == nil) {
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    [_previewLayer.connection
        setVideoOrientation:(self.videoOrientationFromDeviceOrientation)];
  }
  return _previewLayer;
}

- (AVCaptureVideoOrientation)videoOrientationFromDeviceOrientation {
  AVCaptureVideoOrientation result = [UIDevice currentDevice].orientation;
  if (result == UIDeviceOrientationLandscapeLeft)
    result = AVCaptureVideoOrientationLandscapeRight;
  else if (result == UIDeviceOrientationLandscapeRight)
    result = AVCaptureVideoOrientationLandscapeLeft;
  return result;
}

- (AVCaptureMetadataOutput *)output {
  if (_output == nil) {
    _output = [[AVCaptureMetadataOutput alloc] init];

    CGRect viewRect = self.view.frame;
    CGRect containerRect = self.view.frame;

    CGFloat x = containerRect.origin.y / viewRect.size.height;
    CGFloat y = containerRect.origin.x / viewRect.size.width;
    CGFloat width = containerRect.size.height / viewRect.size.height;
    CGFloat height = containerRect.size.width / viewRect.size.width;

    _output.rectOfInterest = CGRectMake(x, y, width, height);
  }
  return _output;
}

- (CALayer *)containerLayer {
  if (_containerLayer == nil) {
    _containerLayer = [[CALayer alloc] init];
  }
  return _containerLayer;
}

- (void)startScan {
  if (![self.session canAddInput:self.input])
    return;
  [self.session addInput:self.input];

  if (![self.session canAddOutput:self.output])
    return;
  [self.session addOutput:self.output];

  self.output.metadataObjectTypes = self.output.availableMetadataObjectTypes;

  [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

  [self.view.layer insertSublayer:self.previewLayer atIndex:0];
  self.previewLayer.frame = self.view.bounds;

  [self.view.layer addSublayer:self.containerLayer];
  self.containerLayer.frame = self.view.bounds;

  [self.session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput
    didOutputMetadataObjects:(NSArray *)metadataObjects
              fromConnection:(AVCaptureConnection *)connection {
  AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];

  if (object == nil)
    return;

  self.code = object.stringValue;

  [self clearLayers];

  AVMetadataMachineReadableCodeObject *obj =
      (AVMetadataMachineReadableCodeObject *)[self.previewLayer
          transformedMetadataObjectForMetadataObject:object];

  [self drawLine:obj];

  [self performSegueWithIdentifier:@"unwindToContainerVC" sender:self];
}

- (void)drawLine:(AVMetadataMachineReadableCodeObject *)objc {
  NSArray *array = objc.corners;

  CAShapeLayer *layer = [[CAShapeLayer alloc] init];

  layer.lineWidth = 2;

  layer.strokeColor = [UIColor greenColor].CGColor;
  layer.fillColor = [UIColor clearColor].CGColor;

  UIBezierPath *path = [[UIBezierPath alloc] init];
  CGPoint point = CGPointZero;
  int index = 0;

  CFDictionaryRef dict = (__bridge CFDictionaryRef)(array[index++]);
  CGPointMakeWithDictionaryRepresentation(dict, &point);
  [path moveToPoint:point];

  for (int i = 1; i < array.count; i++) {
    CGPointMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)array[i],
                                            &point);
    [path addLineToPoint:point];
  }
  [path closePath];

  layer.path = path.CGPath;
  [self.containerLayer addSublayer:layer];
}

- (void)clearLayers {
  if (self.containerLayer.sublayers) {
    for (CALayer *subLayer in self.containerLayer.sublayers) {
      [subLayer removeFromSuperlayer];
    }
  }
}

@end

