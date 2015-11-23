//
//  NotesViewController.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NotesViewController.h"

#import "NotesCell.h"

@interface NotesViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
    
    //数据元数组
    NSArray * _dataSource;
    
    
}
@end

@implementation NotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    
    
    [self loadHeaderData];
    
    [self loadCell];
}





- (void)loadCell{
    
    _manager = [AFHTTPRequestOperationManager manager];
    
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString * str = [NSString stringWithFormat:URL_ITS_TN,_dict[@"id"]];
    
    [_manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray * mutarr = [[NSMutableArray alloc]init];
        
        NSArray * arr1 = dict[@"trackpoints"];
        
        for (NSArray * subArr in arr1) {
            [mutarr addObject:subArr];
        }
        
        _dataSource = mutarr;
        
        [self.tableView reloadData];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
    
}

//注册定制cell
- (void)registerCell{
    
    UINib * nib = [UINib nibWithNibName:@"NotesCell" bundle:nil];
    
    [_tableView registerNib:nib forCellReuseIdentifier:@"NotesId"];
    
}



//加载头视图数据
- (void)loadHeaderData{
    
    NSURL * url = [NSURL URLWithString:[_dict[@"user"] objectForKey:@"avatar_l"]];
    
    [self.ImgUser sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"头像_03"]];
    self.LbUserName.text = [NSString stringWithFormat:@"by %@",[_dict[@"user"] objectForKey:@"name"]];
    
    self.LbTitleNav.text = _dict[@"name"];
    
    self.LbTitle.text = _dict[@"name"];
    
    self.LbDate.text = _dict[@"first_day"];
    
        
    self.LbKm.text = [NSString stringWithFormat:@"%@",_dict[@"mileage"]];
    
    self.LbLikeNum.text = [NSString stringWithFormat:@"%@",_dict[@"recommendations"]];
    
    self.LbDays.text = [NSString stringWithFormat:@"%@天",_dict[@"day_count"]];
}

#pragma mark ----------- tableView代理协议---------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NotesCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NotesId"];
    
    if (cell==nil) {
        cell= (NotesCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"NotesCell" owner:self options:nil]  lastObject];
        
        
        
    }
    
           NSArray * arr = _dataSource[indexPath.row];
    
    NSURL * url = [NSURL URLWithString:[arr objectAtIndex:6]];
    
    [cell.ImgPic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1136-640"]];
    
    cell.LbDesc.text = [arr objectAtIndex:5];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor grayColor];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * arr = [_dataSource objectAtIndex:indexPath.row];
    
    NSString * strContent = [arr objectAtIndex:5];
    
    float height = [strContent boundingRectWithSize:CGSizeMake(281, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    
    
    return height + 340;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)BtnBackClick:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
