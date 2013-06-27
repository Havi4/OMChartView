//
//  OMDoubleChartViewController.m
//  OMChartView
//
//  Created by Oliver Mahn on 05.06.13.
//  Copyright (c) 2013 Oliver Mahn. All rights reserved.
//

#import "OMDoubleChartViewController.h"

#import "OMChartView.h"

@interface OMDoubleChartViewController () <OMChartViewDatasource, OMChartViewDelegate>

@property (weak, nonatomic) IBOutlet OMChartView *chartView;

@end

@implementation OMDoubleChartViewController

static NSMutableArray* array;
static NSMutableArray* array2;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    array = [NSMutableArray array];
    for (int i = 0; i < 40; i++) {
        float f = (arc4random() % 30) / 1.0;
        [array addObject:[NSNumber numberWithFloat:f]];
    }
    NSLog(@"array: %@", array);

    array2 = [NSMutableArray array];
    for (int i = 0; i < 25; i++) {
        float f = (arc4random() % 40) / 1.0;
        [array2 addObject:[NSNumber numberWithFloat:f]];
    }
    NSLog(@"array2: %@", array2);

    [_chartView setDataSource:self];
    [_chartView setDelegate:self];
}

#pragma mark - OMChartViewDatasource

- (NSInteger)numberOfGraphsInChartView:(OMChartView *)chartView {
    return 2;
}

- (NSUInteger)chartView:(OMChartView *)chartView numberOfValuesInGraph:(NSUInteger)graph {
    if (graph == 0) {
        return [array count];
    }
    return [array2 count];
}

- (NSNumber *)chartView:(OMChartView *)chartView valueForIndex:(NSUInteger)index inGraph:(NSUInteger)graph {
    if (graph == 0) {
        return [NSNumber numberWithFloat:[[array objectAtIndex:index] floatValue]];
    }
    return [NSNumber numberWithFloat:[[array2 objectAtIndex:index] floatValue]];
}

#pragma mark - OMChartViewDelegate

- (CGFloat)chartView:(OMChartView *)chartView lineWidthForGraph:(NSUInteger)graph {
    if (graph == 0) {
        return 0.5;
    }
    return 1.0;
}

- (UIColor *)chartView:(OMChartView *)chartView lineColorForGraph:(NSUInteger)graph {
    if (graph == 1) {
        return [UIColor redColor];
    }
    return [UIColor blueColor];
}

- (UIColor *)axisColorInChartView:(OMChartView *)chartView {
    return [UIColor blackColor];
}

- (void)viewDidUnload {
    [self setChartView:nil];
    [super viewDidUnload];
}

@end
