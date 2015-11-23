//
//  TravelCell.h
//  InterestedTourist
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelCell : UITableViewCell


/** 主标题 */
@property (weak, nonatomic) IBOutlet UILabel *LabelTitle;
/** 截止日期 */
@property (weak, nonatomic) IBOutlet UILabel *LabelDate;
/** 天数 */
@property (weak, nonatomic) IBOutlet UILabel *LabelDays;
/** 浏览次数 */
@property (weak, nonatomic) IBOutlet UILabel *LabelNumber;
/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
/** 作者昵称 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/** 主背景图 */
@property (weak, nonatomic) IBOutlet UIImageView *ImgPic;
/** 目的地 */
@property (weak, nonatomic) IBOutlet UILabel *LabelDes;

@property (weak, nonatomic) IBOutlet UIView *TapView;


//数据字典
@property (nonatomic , strong)NSDictionary * Dict;

@end
