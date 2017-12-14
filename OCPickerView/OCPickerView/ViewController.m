//
//  ViewController.m
//  OCPickerView
//
//  Created by mal on 2017/12/14.
//  Copyright © 2017年 mal. All rights reserved.
//

#import "ViewController.h"
#import "MPickerView.h"

static CGFloat const KRowHeight = 30;

@interface ViewController ()<MPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *arr1;
@property (nonatomic, strong) NSMutableArray *arr2;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arr1 = [NSMutableArray array];
    self.arr2 = [NSMutableArray arrayWithObjects:@"0分",@"15分",@"30分",@"45分", nil];
    for (int i = 1; i <= 24; i++)
    {
        [self.arr1 addObject:[NSString stringWithFormat:@"%0d点",i]];
    }
    
    MPickerView *pickerView = [MPickerView mPickerViewWithFrame:CGRectMake(100, 100, 200, 5 * KRowHeight) delegate:self];
    [pickerView selectRow:0 isSection:1];
    [self.view addSubview:pickerView];
    // Do any additional setup after loading the view, typically from a nib.
}

//MARK: MPickerViewDelegate
- (NSInteger)m_noOfSections
{
    return 2;
}

- (NSInteger)m_noOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    if (section == 0)
    {
        rows = self.arr1.count;
    }
    else if (section == 1)
    {
        rows = self.arr2.count;
    }
    return rows;
}

- (CGFloat)m_rowHeight
{
    return KRowHeight;
}

- (UIView *)m_viewForRow:(NSInteger)row inSection:(NSInteger)section
{
    NSString *str = @"";
    if (section == 0)
    {
        str = self.arr1[row];
    }
    else if (section == 1)
    {
        str = self.arr2[row];
    }
    UILabel *label = [[UILabel alloc] init];
    label.text = str;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UIColor *)m_centerLineColor
{
    return [UIColor blackColor];
}

- (void)m_didselectRow:(NSInteger)row section:(NSInteger)section itemArray:(NSArray<UIView *> *)itemArray
{
    [itemArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *label = (UILabel *)obj;
        if (idx == row)
        {
            label.textColor = [UIColor redColor];
        }
        else
        {
            label.textColor = [UIColor blackColor];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
