//
//  SpecialPriceCell.h
//  InterestedTourist
//
//  Created by qianfeng on 15/11/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialPriceCell : UITableViewCell

/** 活动主视图 */
@property (weak, nonatomic) IBOutlet UIImageView *imgActivity;
/** 活动主标题 */
@property (weak, nonatomic) IBOutlet UILabel *LbTitle;
/** 活动日期 */
@property (weak, nonatomic) IBOutlet UILabel *LbDate;
/** 喜欢人数 */
@property (weak, nonatomic) IBOutlet UILabel *LbLike_count;
/** 活动价格 */
@property (weak, nonatomic) IBOutlet UILabel *LbPrice;
/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;

@end
