//
//  LoginViewController.h
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/7.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnderlinedTextField.h"

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UnderlinedTextField *userName;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@end
