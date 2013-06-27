//
//  OMViewController.m
//  StatisticViewTest
//
//  Created by Oliver Mahn on 08.05.13.
//  Copyright (c) 2013 Oliver Mahn. All rights reserved.
//

#import "OMSimpleChartViewController.h"

#import "OMChartView.h"

@interface OMSimpleChartViewController () <OMChartViewDatasource, OMChartViewDelegate>

@property (weak, nonatomic) IBOutlet OMChartView *chartView;

@end

@implementation OMSimpleChartViewController

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

    [_chartView setDataSource:self];
    [_chartView setDelegate:self];
}

#pragma mark - OMChartViewDatasource

- (NSUInteger)chartView:(OMChartView *)chartView numberOfValuesInGraph:(NSUInteger)graph {
    return [array count];
}

- (NSNumber *)chartView:(OMChartView *)chartView valueForIndex:(NSUInteger)index inGraph:(NSUInteger)graph {
    return [NSNumber numberWithFloat:[[array objectAtIndex:index] floatValue]];
}

@end
