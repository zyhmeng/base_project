//
//  YFPieChartViewController.m
//  base_project
//
//  Created by zyh on 16/12/23.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YFPieChartViewController.h"
#import "PCPieChart.h"

@interface YFPieChartViewController ()

@property (nonatomic, strong) NSArray *ratioArray;
@end

@implementation YFPieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"饼状图"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.ratioArray = @[@"0.3",@"0.5",@"0.2"];
    
    [self setupPieChartView];
    
}

- (void)setupPieChartView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 80, UISCREENWIDTH, 195)];
    view.backgroundColor = RGBA(248, 248, 248, 1);
    
    PCPieChart *pieChart = [[PCPieChart alloc] initWithFrame:CGRectMake((UISCREENWIDTH-300)/2, 15, 300, 160)];
    [pieChart setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [pieChart setDiameter:140];
    NSMutableArray *components = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        float value = [self.ratioArray[i] floatValue];

        if (value>0) {
            PCPieComponent *component = [PCPieComponent pieComponentWithTitle:nil value:value bedged:@""];
            if (i==0) {
                [component setColour:RGBA(68, 218, 136, 1)];
            } else if (i==1) {
                [component setColour:RGBA(253, 210, 72, 1)];
            } else {
                [component setColour:RGBA(93, 60, 153, 1)];
            }
            [components addObject:component];
            [pieChart setComponents:components];
        }
    }
    
    [view addSubview:pieChart];
    
    [self.view addSubview:view];
}


@end
