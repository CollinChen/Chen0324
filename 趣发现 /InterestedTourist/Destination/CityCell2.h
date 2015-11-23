//
//  CityCell2.h
//  InterestedTourist
//
//  Created by qianfeng on 15/11/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityCell2 : UITableViewCell
/** 标题图片 */
@property (weak, nonatomic) IBOutlet UIImageView *Img;
/** 主标题 */
@property (weak, nonatomic) IBOutlet UILabel *LbTitle;
/** 去过的人数 */
@property (weak, nonatomic) IBOutlet UILabel *LbpeopleNum;



@end
