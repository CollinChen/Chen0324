//
//  CountryViewController.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CountryViewController.h"

#import "CountryCell.h"

#import "CountryCell2.h"

#import "CityViewController.h"

@interface CountryViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    //城市数据元数组
    NSArray * _dataSource;
    
    //headerView
    UIView * _tbHeaderView;
    
    //特色数据元数组
    NSArray * _dataSource2;
    
    UIScrollView * _adSCV;
    
    AFHTTPRequestOperationManager * _manager;
    
    UIPageControl * _pageControl;
    
    CityViewController * _cityVC;
}
@end

@implementation CountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableViewBackGroundImage];
    
    [self createView];
    
    [self loadAdsRequest];
    
   [self registerCell];
    
    [self loadCell];
    
    [self prepareToCityControllerNotification];
    
    _pageControl.currentPage = 0;
    
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


//通过通知中心，监听是否要跳转到城市页面
- (void)prepareToCityControllerNotification{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toCityController:) name:@"TCityVC" object:nil];
    
}

- (void)toCityController:(NSNotification *)n{
    
    NSLog(@"跳转到城市界面");
    
    _cityVC = [[CityViewController alloc]init];
    
    //获得通知中心传递的数据
    _cityVC.dict = n.object;
    
    [self.navigationController pushViewController:_cityVC animated:YES];
}



//注册自定制cell
- (void)registerCell{
    
    UINib * nib = [UINib nibWithNibName:@"CountryCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CONId"];
    
    UINib * nib2 = [UINib nibWithNibName:@"CountryCell2" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"CONId2"];
}

- (void)loadCell{
    
    
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    ID = [_dict[@"id"] integerValue];
    
    NSString * Cstr = [NSString stringWithFormat:URL_DES_CON,ID];
    
    [_manager GET:Cstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary * dic = dict[@"data"];
        
        _dataSource = dic[@"hot_city"];
        
        _dataSource2 = dic[@"hot_mguide"];
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}



//广告图片数据请求加载
- (void)loadAdsRequest{
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    ID = [_dict[@"id"] integerValue];
    
    NSString * Cstr = [NSString stringWithFormat:URL_DES_CON,ID];
    
 
    

    
    
    [_manager GET:Cstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary * dic1 = dict[@"data"];
        
        NSArray * adsarray  = dic1[@"photos"];
        
        _adSCV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 210)];
        //头视图中添加滚动视图
        [_tbHeaderView addSubview:_adSCV];
        
        _adSCV.contentSize = CGSizeMake(SWIDTH * adsarray.count, 200);
        
        _adSCV.pagingEnabled = YES;
        
        _adSCV.showsHorizontalScrollIndicator = NO;
        
        //设置scrollView的代理回调
        _adSCV.delegate = self;
        //循环加载滚动视图
        for (int i = 0; i < adsarray.count; i ++) {
            
            NSURL * url = [NSURL URLWithString:[adsarray objectAtIndex:i]];
            
            UIImageView * adsImageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * SWIDTH, 0, SWIDTH, 210)];
            [adsImageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"960-640"]];
            
            [_adSCV addSubview:adsImageV];
            
        }
        
        //创建书签页控件
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(SWIDTH/2 + 70, 170, 100, 30)];
        //让书签页等于数组中的图片数
        _pageControl.numberOfPages = adsarray.count;
        //将书签控件添加到头视图中
        [_tbHeaderView addSubview:_pageControl];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark  --------- UIScrollView协议方法 -------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage=scrollView.contentOffset.x/SWIDTH;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = _adSCV.contentOffset.x;
    offsetX = offsetX +_adSCV.frame.size.width*0.5;
    int page = offsetX/_adSCV.frame.size.width;
    _pageControl.currentPage = page;
}

//创建滚动广告视图
- (void)createView{

    
    _tbHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 210)];
    _tbHeaderView.backgroundColor = [UIColor grayColor];
    
    self.tableView.tableHeaderView = _tbHeaderView;
    
    UILabel * LbConName = [[UILabel alloc]initWithFrame:CGRectMake(10, 140, 100, 30)];
    
    LbConName.text = _dict[@"cnname"];
    LbConName.textColor = [UIColor whiteColor];
    LbConName.textAlignment = NSTextAlignmentCenter;
    LbConName.highlighted = YES;
    LbConName.font = [UIFont boldSystemFontOfSize:22];
    
    [_tableView addSubview:LbConName];
    UILabel * LbEngConName = [[UILabel alloc]initWithFrame:CGRectMake(26, 170, 200, 60)];
    
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
}

//设置表格视图的背景图
-(void)setTableViewBackGroundImage
{
    UIImageView *backImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, self.tableView.bounds.size.height)];
    backImageView.image=[UIImage imageNamed:@"1136-640"];
    self.tableView.backgroundView=backImageView;
}






#pragma mark ------------ tableView协议方法 -----------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _dataSource.count;
    }
    else
        return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        CountryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CONId"];
        if (cell==nil) {
            cell= (CountryCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"CountryCell" owner:self options:nil]  lastObject];
        }
        
        
        cell.ImgConLeft.userInteractionEnabled=YES;

        NSDictionary * dict = _dataSource[indexPath.row];
        
        cell.LbNameLeft.text = dict[@"cnname"];
        cell.LbEngNameLeft.text = dict[@"enname"];
        
        [cell.ImgConLeft sd_setImageWithURL:[NSURL URLWithString:dict[@"photo"]]placeholderImage:[UIImage imageNamed:@"085239TPy"]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //数据赋值
        cell.Dict = dict;


       return cell;

       
        
       
    }
    else{
        
        CountryCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"CONId2"];
        if (cell == nil) {
            cell = (CountryCell2 *)[[[NSBundle mainBundle] loadNibNamed:@"CountryCell2" owner:self options:nil] lastObject];
        }
        
        NSDictionary * dict1 = [_dataSource2 objectAtIndex:0];
        [cell.Img1 sd_setImageWithURL:[NSURL URLWithString:dict1[@"photo"]]];
        [cell.Imguser1 sd_setImageWithURL:[NSURL URLWithString:dict1[@"avatar"]]];
        cell.Lbtitle1.text = dict1[@"title"];
        cell.Lbuser1.text = dict1[@"username"];
        
        
        NSDictionary * dict2 = [_dataSource2 objectAtIndex:1];
        
        [cell.Img2 sd_setImageWithURL:[NSURL URLWithString:dict2[@"photo"]]];
        [cell.Imguser2 sd_setImageWithURL:[NSURL URLWithString:dict2[@"avatar"]]];
        cell.Lbtitle2.text = dict2[@"title"];
        cell.Lbuser2.text = dict2[@"username"];
        
        NSDictionary * dict3 = [_dataSource2 objectAtIndex:2];
        [cell.Img3 sd_setImageWithURL:[NSURL URLWithString:dict3[@"photo"]]];
        [cell.Imguser3 sd_setImageWithURL:[NSURL URLWithString:dict3[@"avatar"]]];
        cell.Lbtitle3.text = dict3[@"title"];
        cell.Lbuser3.text = dict3[@"username"];
        NSDictionary * dict4 = [_dataSource2 objectAtIndex:3];
        [cell.Img4 sd_setImageWithURL:[NSURL URLWithString:dict4[@"photo"]]];
        [cell.Imguser4 sd_setImageWithURL:[NSURL URLWithString:dict4[@"avatar"]]];
        cell.Lbtitle4.text = dict4[@"title"];
        cell.Lbuser4.text = dict4[@"username"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    }
        
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        return 500;
    }
    else
    
    return 110;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        NSString * str = [NSString stringWithFormat:@"%@城市",_dict[@"cnname"]];
        
        return str;
    }
    else
        return @"玩当地特色┏ (゜ω゜)=☞";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BackClick:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
