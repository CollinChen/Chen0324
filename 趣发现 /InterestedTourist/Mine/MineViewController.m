//
//  MineViewController.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
}

#pragma mark ------------tableView协议方法---------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }
    else
        return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * reuseID = @"reuse id";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:{
                    cell.imageView.image = [UIImage imageNamed:@"穿越"];
                    cell.textLabel.text = @"我的收藏";
                    break;
                }
                case 1:{
                    cell.imageView.image = [UIImage imageNamed:@"当地人"];
                    cell.textLabel.text = @"夜间模式";
                    break;
                }
                case 2:{
                    cell.imageView.image = [UIImage imageNamed:@"预订服务"];
                    cell.textLabel.text = @"清除缓存";
                    break;
                }
                case 3:{
                    cell.imageView.image = [UIImage imageNamed:@"好友动态"];
                    cell.textLabel.text = @"关于我们";
                    break;
                }
                    
                default:
                    break;
            }
        }
        
    }
    return cell;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100;
    }
    
    
    return 60;
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
