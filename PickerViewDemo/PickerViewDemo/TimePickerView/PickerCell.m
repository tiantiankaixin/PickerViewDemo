//
//  PickerCell.m
//  DatePopView
//
//  Created by wangtian on 16/4/20.
//  Copyright © 2016年 maliang. All rights reserved.
//

#import "PickerCell.h"

@implementation PickerCell

+ (PickerCell *)cellWithRow:(NSInteger)row
{
    PickerCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PickerCell" owner:nil options:nil] firstObject];
    
    cell.cellLabel.text = [NSString stringWithFormat:@"%ld",row];
    
    return cell;
}

@end
