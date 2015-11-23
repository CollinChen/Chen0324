//
//  SP2ViewController.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SP2ViewController.h"

@interface SP2ViewController ()

@end

@implementation SP2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createHeaderView];
    
    [self createWebView];
}

- (void)createHeaderView{
    
    UIImageView * imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    imgV.image = [UIImage imageNamed:@"1136-640"];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 16, 50, 43);
    [button setBackgroundImage:[UIImage imageNamed:@"dh-03"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(BackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
        [self.view addSubview:imgV];
    
        [self.view addSubview:button];
}

- (void)BackBtnClick:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)createWebView{
    
    UIWebView * web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, self.view.bounds.size.height - 64)];
    
    NSString * path = [NSString stringWithFormat:@"http://web.breadtrip.com/hunter/product/%ld/",_Num];
    
    NSURL * url = [NSURL URLWithString:path];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [web loadRequest:request];
    
    [self.view addSubview:web];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
