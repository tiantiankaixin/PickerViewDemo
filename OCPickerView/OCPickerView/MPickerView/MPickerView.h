//
//  MPickerView.h
//  OCPickerView
//
//  Created by mal on 2017/12/14.
//  Copyright © 2017年 mal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MPickerViewDelegate<NSObject>

/**
 返回pickerView的列数

 @return 列数
 */
- (NSInteger)m_noOfSections;

/**
 返回pickerView对应列的数据行数

 @param section 列
 @return 行
 */
- (NSInteger)m_noOfRowsInSection:(NSInteger)section;

- (CGFloat)m_rowHeight;
- (UIView *)m_viewForRow:(NSInteger)row inSection:(NSInteger)section;
- (UIColor *)m_centerLineColor;
- (void)m_didselectRow:(NSInteger)row section:(NSInteger)section itemArray:(NSArray<UIView*> *)itemArray;

@end

@interface MPickerView : UIView

@property (nonatomic, weak) id<MPickerViewDelegate> m_delegate;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, strong) NSMutableArray<UIScrollView*> *scrollViewArray;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<UIView*>*> *itemViewsArray;

+ (MPickerView *)mPickerViewWithFrame:(CGRect)frame delegate:(id<MPickerViewDelegate>)delegate;
- (void)selectRow:(NSInteger)row isSection:(NSInteger)inSection;

@end
