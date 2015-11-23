//
//  ChoiceViewController.h
//  InterestedTourist
//
//  Created by qianfeng on 15/11/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    //声明数据元数组
    NSMutableArray * _dataSource;
    
    //声明表格中的headerView;
    UIView * _tbHeaderView;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tv;


@end
