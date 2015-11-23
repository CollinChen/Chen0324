//
//  CountryCell.m
//  InterestedTourist
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CountryCell.h"

@implementation CountryCell

- (void)awakeFromNib {
   
    
    UITapGestureRecognizer * Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick1:)];
    self.ImgConLeft.userInteractionEnabled = YES;
    
    [self.ImgConLeft addGestureRecognizer:Tap];
    
    
}

- (void)TapClick1:(UITapGestureRecognizer *)tap{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TCityVC" object:self.Dict];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
