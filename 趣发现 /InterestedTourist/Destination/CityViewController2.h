//
//  CityViewController2.h
//  InterestedTourist
//
//  Created by qianfeng on 15/11/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityViewController2 : UIViewController

@property (nonatomic , copy)NSString * URL;
@property (weak, nonatomic) IBOutlet UILabel *LbTitle;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic , copy)NSString * str;

@end
