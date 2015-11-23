//
//  DestinationCell.h
//  InterestedTourist
//
//  Created by qianfeng on 15/11/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestinationCell : UICollectionViewCell

/** 包含国家数 */
@property (weak, nonatomic) IBOutlet UILabel *LabelNum;
/** 国家名 */
@property (weak, nonatomic) IBOutlet UILabel *LabelName;
/** 国家英文名 */
@property (weak, nonatomic) IBOutlet UILabel *LabelEngName;
/** 国家图片 */
@property (weak, nonatomic) IBOutlet UIImageView *ImgCountry;
//数据字典
@property (nonatomic , strong)NSDictionary * Dict;
@end
