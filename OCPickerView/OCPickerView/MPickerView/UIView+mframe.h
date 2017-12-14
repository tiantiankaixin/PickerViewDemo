//
//  UIView+mframe.h
//  langrensha
//
//  Created by mal on 2017/7/29.
//  Copyright © 2017年 closure. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (mframe)

@property (nonatomic, assign) CGFloat m_left;
@property (nonatomic, assign) CGFloat m_right;
@property (nonatomic, assign) CGFloat m_top;
@property (nonatomic, assign) CGFloat m_bottom;
@property (nonatomic, assign) CGFloat m_width;
@property (nonatomic, assign) CGFloat m_height;
@property (nonatomic, assign) CGFloat m_centerX;
@property (nonatomic, assign) CGFloat m_centerY;

@end

@interface UIView (mhelp)

+ (UIView *)gradientViewWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray *)colors locations:(NSArray *)locations frame:(CGRect)frame;
- (void)m_setCornerRadius:(CGFloat)radius;

@end
