//
//  CityViewController2.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CityViewController2.h"

#import "CityCell2.h"

#import "LastViewController.h"

@interface CityViewController2 ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _dataSource;
    
    AFHTTPRequestOperationManager * _manager;
    
    LastViewController * _LastVC;
    
    
}



@end

@implementation CityViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.LbTitle.text = self.str;
    
    [self registerCell];
    
    [self LoadCell];

}



- (void)registerCell{
    
    UINib * nib = [UINib nibWithNibName:@"CityCell2" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CT2"];
    
}

- (void)LoadCell{
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [_manager GET:self.URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       
        
        NSDictionary * dic = dict[@"data"];
     
       _dataSource = dic[@"entry"];
        
        //重新刷新表格！！！！
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------- tableView代理协议 -----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CityCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"CT2"];
    if (cell==nil) {
        cell= (CityCell2 *)[[[NSBundle  mainBundle]  loadNibNamed:@"CityCell2" owner:self options:nil]  lastObject];
    }
    NSDictionary * dict = _dataSource[indexPath.row];
    
    
    [cell.Img sd_setImageWithURL:[NSURL URLWithString:dict[@"photo"]]];
    cell.LbTitle.text = dict[@"firstname"];
    cell.LbpeopleNum.text = dict[@"beenstr"];
    

    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    _LastVC = [[LastViewController alloc]init];
    
    NSDictionary * dic = _dataSource[indexPath.row];
    
    NSString * str = [NSString stringWithFormat:@"%@",dic[@"id"]];
    
    
    _LastVC.StrOfUrl = [NSString stringWithString:str];
    
    [self.navigationController pushViewController:_LastVC animated:YES];
    
}

- (IBAction)BackBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
