//
//  CityViewController.h
//  InterestedTourist
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//用来接收数据的字典
@property (nonatomic , strong)NSDictionary * dict;

@end
