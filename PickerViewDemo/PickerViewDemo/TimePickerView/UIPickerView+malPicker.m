//
//  UIPickerView+malPicker.m
//  PickerViewDemo
//
//  Created by wangtian on 16/4/20.
//  Copyright © 2016年 wangtian. All rights reserved.
//

#import "UIPickerView+malPicker.h"

@implementation UIPickerView (malPicker)

- (void)clearSpearatorLine
{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.frame.size.height < 1)
        {
            [obj setBackgroundColor:[UIColor clearColor]];
        }
    }];
}

@end
