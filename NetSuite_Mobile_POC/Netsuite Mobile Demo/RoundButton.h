//
//  RoundButton.h
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/7.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundButton : UIButton
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat bwidth;
@property (nonatomic, assign)IBInspectable UIColor *bcolor;
@end
