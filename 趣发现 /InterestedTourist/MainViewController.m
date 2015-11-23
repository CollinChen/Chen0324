//
//  MainViewController.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
{
    //记录上一个被点击的按钮
    UINavigationController *_preNav;
//    UILabel *_preLb;
    UIImageView *_preImgV;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
}

//隐藏标签栏中的所有子视图
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *tabBarSubViewArray=self.tabBar.subviews;
    for (int i=0; i<tabBarSubViewArray.count; i++) {
        //获得数组中的每个子视图
        UIView *view=[tabBarSubViewArray objectAtIndex:i];
        //隐藏每个子视图
        view.hidden=YES;
    }
    
    
}

//添加tabbar上的按钮
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIView * bkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 49)];
    bkView.backgroundColor = [UIColor colorWithRed:51/255 green:51/255 blue:51/255 alpha:1];
    [self.tabBar addSubview:bkView];
//    [self.tabBar sendSubviewToBack:bkView];
    
    NSArray *array=self.viewControllers;
    for (int i=0; i<array.count; i++) {
        //获得标签控制器中每一个子视图控制器
        UINavigationController *nav=[array objectAtIndex:i];
        
        //创建UIImageView对象
        UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake(i*SWIDTH/4 + 30, 0, SWIDTH/14, 49)];
        [self.tabBar addSubview:imgV];
        imgV.image=nav.tabBarItem.image;
        
        

        
        
        

        
        //给每个图片添加点击手势
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        imgV.userInteractionEnabled=YES;
        [imgV addGestureRecognizer:tap];
        imgV.tag=100+i;
        
        
        
        if (i==0) {
            imgV.image=nav.tabBarItem.selectedImage;

            _preNav=nav;
            _preImgV=imgV;
        }
        
    }
    
}


-(void)tapClick:(UITapGestureRecognizer *)tap
{
    UIImageView *imgV=(UIImageView *)tap.view;
    //获得点击按钮对应的视图控制器
    UINavigationController *nav=self.viewControllers[imgV.tag-100];
    
    //判断两次点击是否为相同的按钮
    if (imgV==_preImgV) {
        return;
    }
    
    
    
    //选中的图片变成黄颜色
    imgV.image=nav.tabBarItem.selectedImage;
    //获得点击图片上的子视图lb
   
    
    
    //上一个按钮变为非选中状态
    _preImgV.image=_preNav.tabBarItem.image;

    
    

    _preImgV=imgV;
    _preNav=nav;
    
    //切换标签控制器的页面
    self.selectedIndex=imgV.tag-100;
    
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
