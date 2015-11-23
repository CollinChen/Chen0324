//
//  SpecialPriceViewController.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SpecialPriceViewController.h"

#import "SpecialPriceCell.h"

#import "MBProgressHUD.h"

#import "SP2ViewController.h"
@interface SpecialPriceViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray * _dataSource;
    
    AFHTTPRequestOperationManager * _manager;
    
    SP2ViewController * _SP2VC;
}
@end

@implementation SpecialPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    
    [self loadCell];
    
}

- (void)loadCell{
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.color = [UIColor groupTableViewBackgroundColor];
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [_manager GET:URL_Spp parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [hud hide:YES];
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        _dataSource  = dict[@"product_list"];
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)registerNib{
    
    UINib * nib = [UINib nibWithNibName:@"SpecialPriceCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ItemId"];
    
}

#pragma mark ------------- tableView代理协议 -------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SpecialPriceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ItemId"];
    
    if (cell==nil) {
        cell= (SpecialPriceCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"SpecialPriceCell" owner:self options:nil]  lastObject];
    }
    
    
    NSDictionary * dict = _dataSource[indexPath.row];
    
    cell.LbTitle.text = dict[@"title"];
    
    cell.LbDate.text = dict[@"date_str"];
    
    cell.LbLike_count.text = [NSString stringWithFormat:@"❣%@人喜欢",dict[@"like_count"]];
    cell.LbPrice.text = [NSString stringWithFormat:@"￥%@",dict[@"price"]];
    
    [cell.imgActivity sd_setImageWithURL:[NSURL URLWithString:dict[@"title_page"]]];
    
    [cell.imgUser sd_setImageWithURL:[NSURL URLWithString:dict[@"user"][@"avatar_l"]]] ;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 220;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _SP2VC = [[SP2ViewController alloc]init];
    
    NSDictionary * dic = _dataSource[indexPath.row];
    
    _SP2VC.Num = [dic[@"product_id"] integerValue];
    
    [self.navigationController pushViewController:_SP2VC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
