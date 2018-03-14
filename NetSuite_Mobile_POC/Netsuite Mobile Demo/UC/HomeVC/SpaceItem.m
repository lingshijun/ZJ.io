//
//  SpaceItem.m
//  Netsuite Mobile Demo
//
//  Created by ZhangJun on 13/03/2018.
//  Copyright © 2018 oracle. All rights reserved.
//

#import "SpaceItem.h"

@implementation SpaceItem

- (instancetype)init{
    if(self=[super init]){
        [self configureTempData];
    }
    return self;
}

- (void)configureTempData{
    //init
    self.itemCountLB = [UILabel new];
    self.itemCountLB.textAlignment = NSTextAlignmentCenter;
    self.itemCountLB.font = [UIFont boldSystemFontOfSize:48];
    self.itemCountLB.text = [NSString stringWithFormat:@"%d",arc4random()%10];
    self.itemCountLB.textColor = @[
                                   [UIColor colorWithRed:90/255.0 green:104/255.0 blue:173/255.0 alpha:1.0],
                                   [UIColor colorWithRed:202/255.0 green:88/255.0 blue:157/255.0 alpha:1.0],
                                   [UIColor colorWithRed:245/255.0 green:166/255.0 blue:35/255.0 alpha:1.0],
                                   [UIColor colorWithRed:237/255.0 green:129/255.0 blue:62/255.0 alpha:1.0]][arc4random()%4];
    [self addSubview:self.itemCountLB];
    
    self.itemContentLB = [UILabel new];
    self.itemContentLB.textAlignment = NSTextAlignmentCenter;
    self.itemContentLB.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    // self.itemContentLB.text = @"po";
    self.itemContentLB.textColor =[UIColor colorWithRed:77/255.0 green:95/255.0 blue:121/255.0 alpha:1.0];
    [self addSubview:self.itemContentLB];
    
    //layout
    CGFloat verticalSpace = 1;
    
    [self.itemCountLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
    }];
    
    [self.itemContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.itemCountLB.mas_bottom).offset(verticalSpace);
        make.centerX.equalTo(self);
    }];
    
    
}
@end





