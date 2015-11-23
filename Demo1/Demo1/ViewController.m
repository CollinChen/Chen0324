//
//  ViewController.m
//  Demo1
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * oneView = [[UIView alloc]init];
    oneView.frame = CGRectMake(100, 100, 100, 100);
    oneView.backgroundColor = [UIColor redColor];
    [self.view addSubview:oneView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
