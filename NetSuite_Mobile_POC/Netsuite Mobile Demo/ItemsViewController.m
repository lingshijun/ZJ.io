//
//  ItemsViewController.m
//  Netsuite Mobile Demo
//
//  Created by Bryan Chen on 2018/3/12.
//  Copyright © 2018年 oracle. All rights reserved.
//

#import "ItemsViewController.h"

@interface ItemsViewController ()

@end

@implementation ItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *storedURL = @"system.na3.netsuite.com/core/media/media.nl?id=31355&c=4761902&h=9b875a41e2881aac449d&_xt=.html";
    NSString *urlstring = [NSString stringWithFormat:@"https://%@",storedURL];
    NSURL *url = [NSURL URLWithString:urlstring];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];

    self.title = @"Search Results";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    UIButton *btnitem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    UIImage *img = [UIImage imageNamed:@"delete"];
    [btnitem setImage:img forState:UIControlStateNormal];
    // [v_delete addSubview:btnitem];
    UIBarButtonItem *btnDelete = [[UIBarButtonItem alloc]initWithCustomView:btnitem];
    
    self.navigationItem.rightBarButtonItem = btnDelete;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_webView reload];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
