//
//  ChoiceViewController.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ChoiceViewController.h"

#import "TravelCell.h"

#import "NotesViewController.h"

@interface ChoiceViewController ()<UIScrollViewDelegate>

{
    //声明网络数据请求变量
    AFHTTPRequestOperationManager * _manager;
    
    //声明书页控件
    UIPageControl * _pageControl;
    
    NotesViewController * _noteVC;
    
    NSInteger _currentPage;
    
    NSArray * _arrTemp;
    
    UIScrollView * _adSCV;
}
@end

@implementation ChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentPage = 2387135357;
    
    //去掉tableView分割线
    self.tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    //隐藏tableView滑动条
    self.tv.showsVerticalScrollIndicator = NO;
    
    
    
    
    
    [self hideSystemNavigationBar];
    
    [self createAdView];
    
    [self loadAdsRequest];
    
    [self loadCellRequest];
    
    [self prepareToNotesControllerNotification];
    
    _pageControl.currentPage = 0;
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollimage) userInfo:nil repeats:YES];
}

#pragma mark --------添加刷新控件-----------

//添加上拉加载
-(void)addRefresh{
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //上拉加载
    }];
    
    footer.automaticallyChangeAlpha = YES;
    
    [footer setTitle:@"╮(╯_╰)╭没有更多数据了哦" forState:MJRefreshStateNoMoreData];
    
    //添加上拉加载
    self.tv.footer = footer;
    
}






//隐藏系统导航条
-(void)hideSystemNavigationBar
{
    self.navigationController.navigationBar.hidden=YES;
}

//加载自定制表格中的网络数据
- (void)loadCellRequest{
    
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    
    
    //GET方法 请求网络数据
    [_manager GET:URL_ITS_DATA parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSInteger next_start = dict[@"next_start"];
        
        NSMutableArray * mutarr  = [[NSMutableArray alloc]init];
        NSArray * arr1 = dict[@"elements"];
        
        for (NSDictionary * dic in arr1) {
            NSArray * arr2 = [dic[@"data"] firstObject];
            
            [mutarr addObject:arr2];
            
        }
        
        _dataSource = mutarr;
        
        [self.tv reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
}

//加载滚动视图中广告网络数据
- (void)loadAdsRequest{
    
    _manager = [AFHTTPRequestOperationManager manager];
    //关闭网络数据的格式解析gongn
    
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //通过GET方法加载网络数据
    [_manager GET:URL_ITS_AD parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * adsArray = dict[@"elements"];
        
        NSDictionary*dict2 = adsArray.firstObject;
        
        _arrTemp=[dict2[@"data"] firstObject];
        //创建滚动视图
        _adSCV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 200)];
        //添加到头视图中
        [_tbHeaderView addSubview:_adSCV];
        
        _adSCV.contentSize = CGSizeMake(SWIDTH * _arrTemp.count, 200);
        
        _adSCV.showsHorizontalScrollIndicator = NO;
        
        _adSCV.pagingEnabled = YES;
        
        _adSCV.delegate = self;
        
        
        
        
        for (int i = 0; i < _arrTemp.count; i ++) {
            NSDictionary * adsDictionary = [_arrTemp objectAtIndex:i];
            
            NSURL * url = [NSURL URLWithString:[adsDictionary objectForKey:@"image_url"]];
            
            UIImageView * adsImageV = [[UIImageView alloc]initWithFrame:CGRectMake(i * SWIDTH, 0, SWIDTH, 200)];
            
            
            
            [adsImageV sd_setImageWithURL:url];
            
            [_adSCV addSubview:adsImageV];
            
            //创建书页控件
            _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(SWIDTH/2-50, 160, 100, 30)];
            _pageControl.numberOfPages=_arrTemp.count;
            
            [_tbHeaderView addSubview:_pageControl];
            
            
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}


//创建滚动广告视图
- (void)createAdView{
    
    _tbHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 200)];
    
    _tbHeaderView.backgroundColor = [UIColor grayColor];
    
    self.tv.tableHeaderView = _tbHeaderView;
    
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

#pragma -mark UIScrollViewDelegate
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
















#pragma mark ------ tableView代理协议 ---------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TravelCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TravelNib"];
    
    if (cell==nil) {
        cell= (TravelCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"TravelCell" owner:self options:nil]  lastObject];
    }
    
    
    
    //设置cell被选中时风格为无（不为灰色）
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * dict = _dataSource[indexPath.row];
    
    cell.LabelTitle.text = dict[@"name"];
    
    cell.LabelDate.text = dict[@"first_day"];
    
    cell.LabelDays.text = [NSString stringWithFormat:@"%@天",dict[@"day_count"]];
    
    cell.LabelNumber.text = [NSString stringWithFormat:@"%@次浏览",dict[@"view_count"]];
    
    cell.LabelDes.text = dict[@"popular_place_str"];
    
    [cell.ImgPic sd_setImageWithURL:[NSURL URLWithString:dict[@"cover_image_w640"]]];
    
    cell.userName.text = [NSString stringWithFormat:@"by %@",[dict[@"user"] objectForKey:@"name"]];
    
    [cell.userImg sd_setImageWithURL:[NSURL URLWithString:[dict[@"user"] objectForKey:@"avatar_l"]]];
    
    
    //给数据字典赋值
    cell.Dict = dict;
     
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
    
}

//通过通知中心，监听是否要跳转到游记页面
- (void)prepareToNotesControllerNotification{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toNotesController:) name:@"TVC" object:nil];
    
}

- (void)toNotesController:(NSNotification *)n{
    
    NSLog(@"跳转到游记界面");
    
    _noteVC = [[NotesViewController alloc]init];
    
    //获得通知中心传递的数据
    _noteVC.dict = n.object;
    
//    _noteVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    
    [self.navigationController pushViewController:_noteVC animated:YES];
    
//    [self presentModalViewController:_noteVC animated:YES];
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
