//
//  TimePickerView.m
//  DatePopView
//
//  Created by wangtian on 16/4/20.
//  Copyright © 2016年 maliang. All rights reserved.
//

#import "TimePickerView.h"
#import "PickerCell.h"
#import "UIPickerView+malPicker.m"

@interface TimePickerView()

@property (nonatomic, assign) BOOL lineIsHidden;

@end

@implementation TimePickerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    self.delegate = self;
    self.dataSource = self;
    self.lineIsHidden = NO;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger rows = 24;
    if (component == 1)
    {
        rows = 60;
    }
    return rows;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    PickerCell *cell = [PickerCell cellWithRow:row];
    [pickerView clearSpearatorLine];
    return cell;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 77;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

@end
