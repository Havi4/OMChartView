//
//  OMViewController.m
//  StatisticViewTest
//
//  Created by Oliver Mahn on 08.05.13.
//  Copyright (c) 2013 Oliver Mahn. All rights reserved.
//

#import "OMViewController.h"

#import "OMChartView.h"

@interface OMViewController () <OMChartViewDatasource, OMChartViewDelegate>

@property (weak, nonatomic) IBOutlet OMChartView *chartView;

@end

@implementation OMViewController

static NSMutableArray* array;
static const NSUInteger count = 30.0;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    array = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        float f = (arc4random() % 30) / 1.0;
        [array addObject:[NSNumber numberWithFloat:f]];
    }
    
    NSLog(@"array: %@", array);

    [_chartView setDataSource:self];
    [_chartView setDelegate:self];
}

#pragma mark - OMChartViewDatasource

- (NSUInteger)numberOfValues {
    return [array count];
}

- (NSNumber*)valueForIndex:(NSUInteger)index {
    return [NSNumber numberWithFloat:[[array objectAtIndex:index] floatValue]];
}

#pragma mark - OMChartViewDelegate

- (CGFloat)lineWidth {
    return 0.5;
}

- (UIColor *)lineColor {
    return [UIColor blueColor];
}

- (UIColor *)axisColor {
    return [UIColor blackColor];
}

@end
