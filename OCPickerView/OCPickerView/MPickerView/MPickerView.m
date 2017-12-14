//
//  MPickerView.m
//  OCPickerView
//
//  Created by mal on 2017/12/14.
//  Copyright © 2017年 mal. All rights reserved.
//

#import "MPickerView.h"
#import "UIView+mframe.h"

static CGFloat const KCenterLineHeight = 0.5;
static CGFloat const KLineMargin = 1;

@interface MPickerView()<UIScrollViewDelegate>

@end

@implementation MPickerView

//MARK: - -----------------get & set
- (UIView *)lineView
{
    UIView *lineView = [[UIView alloc] initWithFrame:self.bounds];
    lineView.backgroundColor = [UIColor clearColor];
    lineView.m_height = self.rowHeight;
    lineView.m_centerY = self.m_height / 2;
    
    UIView *topline = [[UIView alloc] initWithFrame:CGRectMake(0, KLineMargin, self.m_width, KCenterLineHeight)];
    topline.userInteractionEnabled = NO;
    
    UIView *bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, lineView.m_height - KLineMargin, self.m_width, KCenterLineHeight)];
    bottomline.userInteractionEnabled = NO;
    
    if ([self.m_delegate respondsToSelector:@selector(m_centerLineColor)])
    {
        topline.backgroundColor = [self.m_delegate m_centerLineColor];
        bottomline.backgroundColor = [self.m_delegate m_centerLineColor];
    }
    [lineView addSubview:topline];
    [lineView addSubview:bottomline];
    lineView.userInteractionEnabled = NO;
    return lineView;
}

- (UIScrollView *)scrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.m_height = self.m_height;
    scrollView.delegate = self;
    if ([self.m_delegate respondsToSelector:@selector(m_noOfSections)])
    {
        scrollView.m_width = self.m_width / (CGFloat)[self.m_delegate m_noOfSections];
    }
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView:)];
    [scrollView addGestureRecognizer:tapGes];
    return scrollView;
}

- (NSMutableArray<NSMutableArray<UIView *> *> *)itemViewsArray
{
    if (_itemViewsArray == nil)
    {
        _itemViewsArray = [NSMutableArray array];
    }
    return _itemViewsArray;
}

- (NSMutableArray<UIScrollView *> *)scrollViewArray
{
    if (_scrollViewArray == nil)
    {
        _scrollViewArray = [NSMutableArray array];
    }
    return _scrollViewArray;
}

//MARK: - -----------------Event Handler
- (void)tapScrollView:(UITapGestureRecognizer *)tapGes
{
    UIView *gesView = tapGes.view;
    if ([gesView isKindOfClass:[UIScrollView class]])
    {
        UIScrollView *scrollView = (UIScrollView *)gesView;
        NSInteger section = [self.scrollViewArray indexOfObject:scrollView];
        CGPoint tapPoint = [tapGes locationInView:scrollView];
        if (section != NSNotFound)
        {
            NSMutableArray<UIView*> *itemsArray = self.itemViewsArray[section];
            [itemsArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (CGRectContainsPoint(obj.frame, tapPoint))
                {
                    [self selectRow:idx isSection:section];
                    *stop = YES;
                }
            }];
        }
    }
}

//MARK: - -----------------init
+ (MPickerView *)mPickerViewWithFrame:(CGRect)frame delegate:(id<MPickerViewDelegate>)delegate
{
    MPickerView *pickerView = [[MPickerView alloc] initWithFrame:frame];
    pickerView.m_delegate = delegate;
    [pickerView setUpView];
    return pickerView;
}

- (void)setUpView
{
    self.rowHeight = self.m_delegate.m_rowHeight;
    NSInteger sectionNo = self.m_delegate.m_noOfSections;
    CGFloat sectionWidth = self.m_width / sectionNo;
    NSInteger addRows = (NSInteger)(self.m_height / self.rowHeight) - 1;
    for (NSInteger section = 0; section < sectionNo ; section++)
    {
        UIScrollView *scrollView = [self scrollView];
        scrollView.m_left = sectionWidth * section;
        NSInteger rows = [self.m_delegate m_noOfRowsInSection:section];
        CGFloat contentH = self.rowHeight *(rows + addRows);
        scrollView.contentSize = CGSizeMake(0, contentH);
        NSMutableArray *itemArray = [NSMutableArray array];
        for (int row = 0; row < rows; row++)
        {
            UIView *itemView = [self.m_delegate m_viewForRow:row inSection:section];
            itemView.m_width = sectionWidth;
            itemView.m_height = self.rowHeight;
            itemView.m_top = (row + addRows / 2) * self.rowHeight;
            [scrollView addSubview:itemView];
            [itemArray addObject:itemView];
        }
        [self.itemViewsArray addObject:itemArray];
        [self.scrollViewArray addObject:scrollView];
        [self addSubview:scrollView];
    }
    [self addSubview:[self lineView]];
}

//MARK: - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self fitContentOffSetWithScrollView:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate == NO)
    {
        [self fitContentOffSetWithScrollView:scrollView];
    }
}

//MARK: - -----------------Private Method
- (void)fitContentOffSetWithScrollView:(UIScrollView *)scrollView
{
    CGFloat contentOffSetY = scrollView.contentOffset.y;
    NSInteger scrollToRow = (NSInteger)(contentOffSetY / self.rowHeight);
    NSInteger moreMove = (NSInteger)contentOffSetY % (NSInteger)self.rowHeight;
    if (moreMove > (NSInteger)(self.rowHeight / 2))
    {
        scrollToRow++;
    }
    NSInteger section = [self.scrollViewArray indexOfObject:scrollView];
    if (section != NSNotFound)
    {
        [self selectRow:scrollToRow isSection:section];
    }
}

//MARK: - -----------------Public Method
- (void)selectRow:(NSInteger)row isSection:(NSInteger)inSection
{
    if (self.scrollViewArray.count > inSection && self.itemViewsArray.count > inSection)
    {
        UIScrollView *scrollView = self.scrollViewArray[inSection];
        [scrollView setContentOffset:CGPointMake(0, row * self.rowHeight) animated:YES];
        if ([self.m_delegate respondsToSelector:@selector(m_didselectRow:section:itemArray:)])
        {
            [self.m_delegate m_didselectRow:row section:inSection itemArray:self.itemViewsArray[inSection]];
        }
    }
}

@end
