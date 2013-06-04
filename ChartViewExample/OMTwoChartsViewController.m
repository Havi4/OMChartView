//
//  OMTwoChartsViewController.m
//  OMChartView
//
//  Created by Oliver Mahn on 04.06.13.
//  Copyright (c) 2013 Oliver Mahn. All rights reserved.
//

#import "OMTwoChartsViewController.h"

#import "OMChartView.h"

@interface OMTwoChartsViewController () <OMChartViewDatasource, OMChartViewDelegate>

@property (weak, nonatomic) IBOutlet OMChartView *chartView1;
@property (weak, nonatomic) IBOutlet OMChartView *chartView2;

@end

@implementation OMTwoChartsViewController

static NSMutableArray* array;
static const NSUInteger count = 50.0;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    array = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        float f = (arc4random() % 30) / 1.0;
        [array addObject:[NSNumber numberWithFloat:f]];
    }
    
    NSLog(@"array: %@", array);
    
    [_chartView1 setDataSource:self];
    [_chartView1 setDelegate:self];

    [_chartView2 setDataSource:self];
    [_chartView2 setDelegate:self];
}

#pragma mark - OMChartViewDatasource

- (NSUInteger)numberOfValuesInChartView:(OMChartView *)chartView {
    if (chartView == _chartView1) {
        return [array count] / 2;
    }
    return [array count];
}

- (NSNumber*)chartView:(OMChartView *)chartView valueForIndex:(NSUInteger)index {
    return [NSNumber numberWithFloat:[[array objectAtIndex:index] floatValue]];
}

#pragma mark - OMChartViewDelegate

- (CGFloat)lineWidthInChartView:(OMChartView *)chartView {
    return 0.5;
}

- (UIColor *)lineColorInChartView:(OMChartView *)chartView {
    if (chartView == _chartView1) {
        return [UIColor redColor];
    }
    return [UIColor blueColor];
}

- (UIColor *)axisColorInChartView:(OMChartView *)chartView {
    if (chartView == _chartView1) {
        return [UIColor yellowColor];
    }
    return [UIColor blackColor];
}

@end
