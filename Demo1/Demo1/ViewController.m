//
//  ViewController.m
//  Demo1
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIView * _oneView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _oneView = [[UIView alloc]init];
    
    _oneView.frame = CGRectMake(100, 100, 100, 100);
    
    _oneView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_oneView];
    
    [self change];
    
}

- (void)change{
    
    [UIView animateWithDuration:3 delay:3 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _oneView.frame = CGRectMake(200, 150, 50, 50);
        _oneView.backgroundColor = [UIColor blueColor];
        _oneView.transform = CGAffineTransformMakeRotation(90);
    } completion:^(BOOL finished) {
        //
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
