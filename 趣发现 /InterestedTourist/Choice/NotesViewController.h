//
//  NotesViewController.h
//  InterestedTourist
//
//  Created by qianfeng on 15/11/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotesViewController : UIViewController

/** Nav主标题 */
@property (weak, nonatomic) IBOutlet UILabel *LbTitleNav;
/** 返回按钮事件 */
- (IBAction)BtnBackClick:(UIButton *)sender;
/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *ImgUser;
/** 用户昵称 */
@property (weak, nonatomic) IBOutlet UILabel *LbUserName;
/** 主标题 */
@property (weak, nonatomic) IBOutlet UILabel *LbTitle;
/** 游记日期 */
@property (weak, nonatomic) IBOutlet UILabel *LbDate;
/** 天数 */
@property (weak, nonatomic) IBOutlet UILabel *LbDays;
/** 里程数 */
@property (weak, nonatomic) IBOutlet UILabel *LbKm;
/** 喜欢人数 */
@property (weak, nonatomic) IBOutlet UILabel *LbLikeNum;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//通过正向传值获得传递的数据
@property (nonatomic , strong)NSDictionary * dict;

@end
