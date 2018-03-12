//
//  UnderlinedTextField.m
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/7.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import "UnderlinedTextField.h"

@implementation UnderlinedTextField
- (void)drawRect:(CGRect)rect {
  // Drawing code
  CALayer *bottomBorder = [CALayer layer];
  bottomBorder.frame =
      CGRectMake(0.0f, self.frame.size.height - 1, self.frame.size.width, 1.0f);
  bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
  [self.layer addSublayer:bottomBorder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
