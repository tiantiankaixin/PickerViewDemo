//
//  ViewController.m
//  PickerViewDemo
//
//  Created by wangtian on 16/4/20.
//  Copyright © 2016年 wangtian. All rights reserved.
//

#import "ViewController.h"
#import "UIDatePicker+myPicker.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.datePicker clearSpearatorLine];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
