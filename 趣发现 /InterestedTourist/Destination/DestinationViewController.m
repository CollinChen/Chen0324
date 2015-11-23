//
//  DestinationViewController.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DestinationViewController.h"

#import "DestinationCell.h"

#import "MBProgressHUD.h"

#import "CountryViewController.h"
@interface DestinationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    //数据元数组
    NSArray * _dataSource;
    
    AFHTTPRequestOperationManager * _manager;
    
    NSInteger _i;
    
    CountryViewController * _conVC;
    
}
@property (weak, nonatomic) IBOutlet UILabel *Tit;
@end

@implementation DestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view bringSubviewToFront:self.Tit];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self registerItems];
    
    [self setCollectionViewDelegate];
    
    [self loadCell];
    
    [self prepareToCountryControllerNotification];
}

#pragma mark ---------大洲button点击事件 ---------

/** 北美洲6 */
- (IBAction)NorthAmerica:(UIButton *)sender {
    
    _i = 2;
    [self loadCell];
}

/** 南美洲5 */
- (IBAction)SouthAmericaClick:(UIButton *)sender {
    
    _i = 3;
    [self loadCell];
}

/** 非洲4 */
- (IBAction)AfricaClick:(UIButton *)sender {
    
    _i = 5;
    [self loadCell];
}

/** 欧洲3 */
- (IBAction)EuropeClick:(UIButton *)sender {
    
    _i = 1;
    [self loadCell];
}

/** 亚洲1 */
- (IBAction)AsiaClick:(UIButton *)sender {
    
    _i = 0;
    [self loadCell];
}

/** 大洋洲2 */
- (IBAction)OceaniaClick:(UIButton *)sender {
    
    _i = 4;
    [self loadCell];
    
}


//通过通知中心，监听是否要跳转到国家页面
- (void)prepareToCountryControllerNotification{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toCountryController:) name:@"TCVC" object:nil];
    
}

- (void)toCountryController:(NSNotification *)n{
    
    NSLog(@"跳转到国家界面");
    
    _conVC = [[CountryViewController alloc]init];
    
    //获得通知中心传递的数据
    _conVC.dict = n.object;
    
    [self.navigationController pushViewController:_conVC animated:YES];
}





//加载网络数据

- (void)loadCell{
    
    //占位图加载
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.color = [UIColor grayColor];
    
    _manager = [AFHTTPRequestOperationManager manager];
    
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    
//    NSString * urlString = URL_DES;
    
//    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [_manager GET:URL_DES parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * dataArr = dict[@"data"];
        
        NSDictionary * dic = [dataArr objectAtIndex:_i];
        
        _dataSource = dic[@"hot_country"];
        
//        NSMutableArray * mutarr = [[NSMutableArray alloc]init];
//        
//        for (NSDictionary * dic in dataArr) {
//            NSArray * hot_country = dic[@"hot_country"];
//            
//            [mutarr addObject:hot_country];
//        }
//        
//        _dataSource = mutarr;
        
        
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
}




//注册cell
- (void)registerItems{
    
    UINib * nib = [UINib nibWithNibName:@"DestinationCell" bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"itemId"];
    
}

//设置网格的代理回调
- (void)setCollectionViewDelegate{
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}

#pragma mark --------------- collectionView协议方法 ------------

//返回格子的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataSource.count;
    
}

//返回每个格子的对象
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DestinationCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemId" forIndexPath:indexPath];
    
    NSDictionary * dict = _dataSource[indexPath.row];
    
    cell.LabelName.text = dict[@"cnname"];
    
    cell.LabelEngName.text = dict[@"enname"];
    
    cell.LabelNum.text = [dict[@"count"] stringValue]
    
    ;
    
    [cell.ImgCountry sd_setImageWithURL:[NSURL URLWithString:dict[@"photo"]]];
    
    //给数据字典赋值
    cell.Dict = dict;
    
    return cell;
}




#pragma mark ---- collectionViewdelegateFlowLaout -----

//设置格子的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(145, 220);
    
}
//设置格子距离collectionView上下左右的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}

//设置格子之间最小距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
