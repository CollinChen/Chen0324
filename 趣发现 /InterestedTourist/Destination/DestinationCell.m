//
//  DestinationCell.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/10.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DestinationCell.h"

@implementation DestinationCell

- (void)awakeFromNib {
    
    UITapGestureRecognizer * Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick:)];
    self.ImgCountry.userInteractionEnabled = YES;
    
    [self.ImgCountry addGestureRecognizer:Tap];
    
}

- (void)TapClick:(UITapGestureRecognizer *)tap{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TCVC" object:self.Dict];
    
}


@end
