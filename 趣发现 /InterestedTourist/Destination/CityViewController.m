//
//  CityViewController.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CityViewController.h"

#import "CityAdsCell.h"

#import "CityViewController2.h"

@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    AFHTTPRequestOperationManager * _manager;
    //头视图
    UIView * _HeaderView;
    //数据元数组
    NSArray * _dataSource;
    
    UIScrollView * _adSCV;
    
    UIPageControl * _pageControl;
    
    CityViewController2 * _CityVC;
    
    NSInteger _ID;
}
@property (weak, nonatomic) IBOutlet UIButton *BackBtnClick;
@end

@implementation CityViewController

- (void)viewDidLoad {
        //没有分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [super viewDidLoad];
    
    [self.view bringSubviewToFront:self.BackBtnClick];
    
    [self CreateHeaderView];
    
    [self loadAdsRequest];
    
//    _pageControl.currentPage = 0;
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollimage) userInfo:nil repeats:YES];
    
}

- (void)scrollimage{
    NSInteger page = _pageControl.currentPage;
    if (page == _pageControl.numberOfPages -1) {
        page = 0;
    }else{
        page++;
    }
    CGFloat offsetX = page * _adSCV.frame.size.width;
    [_adSCV setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (IBAction)BackBtnClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//注册cell
- (void)registerCell{
    
    UINib * nib = [UINib nibWithNibName:@"CityAdsCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ADSADS"];
    
}

//头视图广告滚动页
- (void)CreateHeaderView{
    
    _HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 250)];
    _HeaderView.backgroundColor = [UIColor grayColor];
    
    UILabel * LbConName = [[UILabel alloc]initWithFrame:CGRectMake(10, 170, 100, 30)];
    
    LbConName.text = _dict[@"cnname"];
    LbConName.textColor = [UIColor whiteColor];
    LbConName.textAlignment = NSTextAlignmentCenter;
    LbConName.highlighted = YES;
    LbConName.font = [UIFont boldSystemFontOfSize:22];
    
    [_tableView addSubview:LbConName];
    UILabel * LbEngConName = [[UILabel alloc]initWithFrame:CGRectMake(26, 200, 200, 60)];
    
    //    NSArray * names = [UIFont familyNames];
    //    for (NSString * str in names) {
    //        NSLog(@"%@",str);
    //    }
    
    LbEngConName.text = _dict[@"enname"];
    LbEngConName.textColor = [UIColor whiteColor];
    //    LbEngConName.textAlignment = NSTextAlignmentCenter;
    LbEngConName.highlighted = YES;
    LbEngConName.font = [UIFont fontWithName:@"Savoye LET" size:40];
    
    [_tableView addSubview:LbEngConName];
    
    
    self.tableView.tableHeaderView = _HeaderView;
    
}

//加载滚动视图中的广告网络数据
- (void)loadAdsRequest{
    
    _manager = [AFHTTPRequestOperationManager manager];
    
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    _ID = [_dict[@"id"] integerValue];
    
    NSString * ADSURL = [NSString stringWithFormat:URL_DES_CITYADS,_ID];
    
    [_manager GET:ADSURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary * dic = dict[@"data"];
        
        _dataSource = dic[@"photos"];
        
        //创建滚动视图
        _adSCV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 250)];
        //在headerView中添加滚动视图
        [_HeaderView addSubview:_adSCV];
        
        _adSCV.contentSize = CGSizeMake(_dataSource.count * SWIDTH, 200);
        
        _adSCV.pagingEnabled = YES;
        
        _adSCV.delegate = self;
        
        for (int i = 0; i < _dataSource.count; i ++) {
            
            NSURL * url = [NSURL URLWithString:_dataSource[i]];
            UIImageView * adsImageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * SWIDTH, 0, SWIDTH, 250)];
            [adsImageV sd_setImageWithURL:url];
            
            [_adSCV addSubview:adsImageV];
            
            _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(SWIDTH/2 + 60, 200, 100, 30)];
            _pageControl.numberOfPages = _dataSource.count;
            [_HeaderView addSubview:_pageControl];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark -----------uiscrollView代理协议----------------

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    _pageControl.currentPage = scrollView.contentOffset.x/SWIDTH;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = _adSCV.contentOffset.x;
    offsetX = offsetX +_adSCV.frame.size.width*0.5;
    int page = offsetX/_adSCV.frame.size.width;
    _pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CityAdsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ADSADS"];
    
    if (cell==nil) {
        cell= (CityAdsCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"CityAdsCell" owner:self options:nil]  lastObject];
    }
    
    if (indexPath.row == 0) {
        cell.Img.image = [UIImage imageNamed:@"tabbar_subject_press"];
        cell.Lb.text = @"景点";
        cell.Lb.tintColor = [UIColor redColor];
    }
    else if (indexPath.row == 1){
        
        cell.Img.image = [UIImage imageNamed:@"tabbar_rank_press"];
        cell.Lb.text = @"美食";
        cell.Lb.tintColor = [UIColor yellowColor];
    }
    else if (indexPath.row == 2){
        cell.Img.image = [UIImage imageNamed:@"tabbar_reduceprice_press"];
        cell.Lb.text = @"购物";
        cell.Lb.tintColor = [UIColor greenColor];
    }
    else{
        cell.Img.image = [UIImage imageNamed:@"tabbar_account_press"];
        cell.Lb.text = @"活动";
        cell.Lb.tintColor = [UIColor blueColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _CityVC = [[CityViewController2 alloc]init];
    
    if (indexPath.row == 0) {
        _CityVC.str = @"景点";
        
        _CityVC.URL = [NSString stringWithFormat:URL_DES_DES,_ID];
        
        [self.navigationController pushViewController:_CityVC animated:YES];
        
    }
    else if (indexPath.row == 1){
        _CityVC.str = @"美食";
        
        _CityVC.URL = [NSString stringWithFormat:URL_DES_FOOD,_ID];
        
        [self.navigationController pushViewController:_CityVC animated:YES];
    }
    else if (indexPath.row == 2){
        _CityVC.str = @"购物";
        
        _CityVC.URL = [NSString stringWithFormat:URL_DES_BUY,_ID];
        
        [self.navigationController pushViewController:_CityVC animated:YES];
    }
    else{
        _CityVC.str = @"活动";
        
        _CityVC.URL = [NSString stringWithFormat:URL_DES_ACT,_ID];
        
        [self.navigationController pushViewController:_CityVC animated:YES];
    }
}


@end
