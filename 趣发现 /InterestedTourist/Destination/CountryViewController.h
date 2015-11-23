//
//  CountryViewController.h
//  InterestedTourist
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryViewController : UIViewController
{
    
    NSInteger * ID;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//接收上一个页面传过来的id值
@property (nonatomic , strong)NSDictionary * dict;

@end
