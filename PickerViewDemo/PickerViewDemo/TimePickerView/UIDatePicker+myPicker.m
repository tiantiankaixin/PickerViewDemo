//
//  UIDatePicker+myPicker.m
//  PickerViewDemo
//
//  Created by wangtian on 16/4/20.
//  Copyright © 2016年 wangtian. All rights reserved.
//

#import "UIDatePicker+myPicker.h"

@implementation UIDatePicker (myPicker)

- (void)clearSpearatorLine
{
    for (UIView *subView1 in self.subviews)
    {
        if ([subView1 isKindOfClass:[UIPickerView class]])
        {
            for(UIView *subView2 in subView1.subviews)
            {
                if (subView2.frame.size.height < 1)
                {
                    subView2.hidden = YES;
                }
            }
        }
    }
}

@end
