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
        if ([subView1 isKindOfClass:[UIPickerView class]])//取出UIPickerView
        {
            for(UIView *subView2 in subView1.subviews)
            {
                if (subView2.frame.size.height < 1)//取出分割线view
                {
                    //subView2.hidden = YES;
                    //[subView2 setBackgroundColor:[UIColor redColor]];
                    UIView *redLine = [[UIView alloc] initWithFrame:subView2.bounds];
                    redLine.backgroundColor = [UIColor redColor];
                    [subView2 addSubview:redLine];
                }
            }
        }
    }
}

@end
