//
//  LoginViewController.m
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/7.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
  [self performSegueWithIdentifier:@"loginIdentifier" sender:nil];
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:_userName.text forKey:@"userName"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
