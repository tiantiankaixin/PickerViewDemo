//
//  PickerCell.h
//  DatePopView
//
//  Created by wangtian on 16/4/20.
//  Copyright © 2016年 maliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerCell : UIView

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;


+ (PickerCell *)cellWithRow:(NSInteger)row;

@end
