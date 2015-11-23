//
//  NotesCell.h
//  InterestedTourist
//
//  Created by qianfeng on 15/11/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesCell : UITableViewCell

/** 游记图片 */
@property (weak, nonatomic) IBOutlet UIImageView *ImgPic;
/** 游记描述 */
@property (weak, nonatomic) IBOutlet UILabel *LbDesc;

@end
