//
//  UIView+mframe.m
//  langrensha
//
//  Created by mal on 2017/7/29.
//  Copyright © 2017年 closure. All rights reserved.
//

#import "UIView+mframe.h"

@implementation UIView (mframe)

- (CGFloat)m_top
{
    return self.frame.origin.y;
}

- (void)setM_top:(CGFloat)m_top
{
    CGRect frame = self.frame;
    frame.origin.y = m_top;
    self.frame = frame;
}

- (CGFloat)m_bottom
{
    return self.frame.origin.y + self.m_height;
}

- (void)setM_bottom:(CGFloat)m_bottom
{
    [self setM_top:m_bottom - self.m_height];
}

- (CGFloat)m_left
{
    return self.frame.origin.x;
}

- (void)setM_left:(CGFloat)m_left
{
    CGRect frame = self.frame;
    frame.origin.x = m_left;
    self.frame = frame;
}

- (CGFloat)m_right
{
    return self.m_left + self.m_width;
}

- (void)setM_right:(CGFloat)m_right
{
    [self setM_left:m_right - self.m_width];
}

- (CGFloat)m_width
{
    return self.frame.size.width;
}

- (void)setM_width:(CGFloat)m_width
{
    CGRect frame = self.frame;
    frame.size.width = m_width;
    self.frame = frame;
}

- (CGFloat)m_height
{
    return self.frame.size.height;
}

- (void)setM_height:(CGFloat)m_height
{
    CGRect frame = self.frame;
    frame.size.height = m_height;
    self.frame = frame;
}

- (CGFloat)m_centerX
{
    return self.center.x;
}

- (void)setM_centerX:(CGFloat)m_centerX
{
    CGPoint center = self.center;
    center.x = m_centerX;
    self.center = center;
}

- (CGFloat)m_centerY
{
    return self.center.y;
}

- (void)setM_centerY:(CGFloat)m_centerY
{
    CGPoint center = self.center;
    center.y = m_centerY;
    self.center = center;
}

@end


@implementation UIView(mhelp)

+ (UIView *)gradientViewWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray *)colors locations:(NSArray *)locations frame:(CGRect)frame
{
    UIView *gradientView = [[UIView alloc] initWithFrame:frame];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gradientView.bounds;
    [gradientView.layer addSublayer:gradient];
    gradient.colors = colors;
    gradient.locations = locations;
    gradient.startPoint = startPoint;
    gradient.endPoint = endPoint;
    return gradientView;
}

- (void)m_setCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}


@end
