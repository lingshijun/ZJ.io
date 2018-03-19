//
//  HorizontalView.m
//  Netsuite Mobile Demo
//
//  Created by ZhangJun on 13/03/2018.
//  Copyright © 2018 oracle. All rights reserved.
//

#import "HorizontalView.h"
#import "SpaceItem.h"

@implementation HorizontalView


-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self setUI];
}
int contentNum = 0;

-(NSArray *) itemContent {
    return @[@"Inventory Transfer",@"Stock Take",@"Save",@"Submit",@"Reject",@"Finish",@"Fulfill",@"Pick",@"Ship",@"Finish"];
}

-(NSArray *) itemTitle {
    return @[@"My Approve",@"My Request",@"My Work"];
}


#warning 这个不支持转屏，只是适配不同机型
- (void)setUI{
    NSArray * sections = @[@2,@4,@4];
    for(int i=0;i<sections.count;i++){
        UIView * sectionView = [self configurePerSectionCount:[sections[i] integerValue]];
        sectionView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.98];
        [self addSubview:sectionView];
        
        UILabel * itemTitle = [UILabel new];
        itemTitle.text = self.itemTitle[i];
        itemTitle.textAlignment = NSTextAlignmentCenter;
        itemTitle.font = [UIFont boldSystemFontOfSize:15];
        itemTitle.textColor = [UIColor colorWithRed:77/255.0 green:95/255.0 blue:121/255.0 alpha:1.0];
        [self addSubview:itemTitle];
        
        CGFloat subHorizonSpace = ([UIScreen mainScreen].bounds.size.width *0.95) /sections.count;
        [sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(subHorizonSpace * i);
            make.height.mas_equalTo(190);
            make.top.mas_equalTo(1);
        }];
        
        [itemTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(sectionView).offset(subHorizonSpace / 2);
            make.top.mas_equalTo(sectionView.mas_top).offset(20);
        }];
        
        if(i > 0)
        {
            UIView * rightLine = [UIView new];
            rightLine.backgroundColor = [UIColor colorWithRed:77/255.0 green:95/255.0 blue:121/255.0 alpha:0.8f];
            [self addSubview:rightLine];
            [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(sectionView);
                make.top.equalTo(sectionView).offset(30);
                make.height.mas_equalTo(128);
                make.width.mas_equalTo(1);
            }];
        }
       
    }
}


- (UIView *)configurePerSectionCount:(NSInteger)count{
    CGFloat subHorizonSpace = [UIScreen mainScreen].bounds.size.width *0.95 /3.0;
    CGFloat section1temSpace = subHorizonSpace/count;
    
    UIView * bgView = [UIView new];
    for(int i=0;i<count;i++){
        SpaceItem * item = [SpaceItem new];
        [bgView addSubview:item];
        item.itemContentLB.text = self.itemContent[contentNum];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView.mas_left).offset(section1temSpace/2.0+i*section1temSpace);
            make.centerY.equalTo(bgView).offset(25);
            make.height.mas_equalTo(100);//随意写的
            make.width.mas_equalTo(section1temSpace);
        }];
        contentNum++;
    }
    return bgView;
}


@end
