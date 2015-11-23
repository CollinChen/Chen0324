//
//  TravelCell.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TravelCell.h"

@implementation TravelCell

- (void)awakeFromNib {
    
    UITapGestureRecognizer * Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick:)];
    self.TapView.userInteractionEnabled = YES;
    
    [self.TapView addGestureRecognizer:Tap];
    
}

- (void)TapClick:(UITapGestureRecognizer *)tap{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TVC" object:self.Dict];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
