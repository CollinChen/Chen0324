//
//  CountryCell.h
//  InterestedTourist
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryCell : UITableViewCell
/** 国家图片左 */
@property (weak, nonatomic) IBOutlet UIImageView *ImgConLeft;

/** 国家名左 */
@property (weak, nonatomic) IBOutlet UILabel *LbNameLeft;
/** 国家英文名左 */
@property (weak, nonatomic) IBOutlet UILabel *LbEngNameLeft;

//数据字典
@property (nonatomic , strong)NSDictionary * Dict;

@end
