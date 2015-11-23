//
//  LastViewController.h
//  InterestedTourist
//
//  Created by qianfeng on 15/11/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LastViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
/** nav标题 */
@property (weak, nonatomic) IBOutlet UILabel *LbNavTitle;
/** 页面配图 */
@property (weak, nonatomic) IBOutlet UIImageView *Img;
/** 大标题 */
@property (weak, nonatomic) IBOutlet UILabel *LbTitle;
/** 简介描述 */
@property (weak, nonatomic) IBOutlet UILabel *Lbdescribe;
/** 地址内容 */
@property (weak, nonatomic) IBOutlet UILabel *LbAddress;
/**用来接收接口的字符串*/
@property (nonatomic , strong)NSString * StrOfUrl;
@end
