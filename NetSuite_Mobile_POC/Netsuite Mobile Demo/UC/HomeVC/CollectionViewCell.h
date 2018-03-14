//
//  CollectionViewCell.h
//  Netsuite Mobile Demo
//
//  Created by ZhangJun on 12/03/2018.
//  Copyright © 2018 oracle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic)
    IBOutlet UIImageView *cellImg;
@property (weak, nonatomic)
    IBOutlet UIView *cellLblV;
@property (weak, nonatomic)
    IBOutlet UILabel *cellLbl;
@end
