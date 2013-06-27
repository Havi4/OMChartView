//
//  OMStatisticView.m
//  StatisticViewTest
//
//  Created by Oliver Mahn on 08.05.13.
//  Copyright (c) 2013 Oliver Mahn. All rights reserved.
//

#import "OMChartView.h"

@interface OMChartView ()

@end

@implementation OMChartView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();

    // draw x- & y-axis
    CGFloat xAxisOffset = 20.0;
    CGFloat yAxisOffset = 20.0;
    
    CGFloat xAxis = self.frame.size.height - xAxisOffset;
    CGFloat yAxis = yAxisOffset;

    NSUInteger numberOfGraphs = 1;
    if ([self.delegate respondsToSelector:@selector(numberOfGraphsInChartView:)]) {
        numberOfGraphs = [self.dataSource numberOfGraphsInChartView:self];
    }
    
    NSUInteger maxCount = 0;
    for (int i = 0; i < numberOfGraphs; i++) {
        maxCount = MAX(maxCount, [self.dataSource chartView:self numberOfValuesInGraph:i]);
    }

    NSUInteger maxValue = 0;
    for (int i = 0; i < numberOfGraphs; i++) {
        for (int j = 0; j < [self.dataSource chartView:self numberOfValuesInGraph:i]; j++) {
            maxValue = MAX(maxValue, [[self.dataSource chartView:self valueForIndex:j inGraph:i] floatValue]);
        }
    }
    maxValue += 1;

    if ([self.delegate respondsToSelector:@selector(axisColorInChartView:)]) {
        CGContextSetStrokeColorWithColor(context, [[self.delegate axisColorInChartView:self] CGColor]);
    } else {
        CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
    }
    
    // max Value ermitteln
    
    CGFloat xStepWidth = ((self.frame.size.width - yAxisOffset) / ([self.dataSource chartView:self numberOfValuesInGraph:0] * 1.0f));
    CGFloat xAxisStepWidth = xStepWidth;
    while (xAxisStepWidth < 10.0) {
        xAxisStepWidth = xAxisStepWidth * 2.0;
    }

    CGFloat yStepWidth = ((self.frame.size.height - xAxisOffset) / maxValue);
    CGFloat yAxisStepWidth = yStepWidth;
    while (yAxisStepWidth < 10.0) {
        yAxisStepWidth = xAxisStepWidth * 2.0;
    }
    
    CGContextSetLineWidth(context, 0.5);
    CGContextMoveToPoint(context, 0, xAxis);
    CGContextAddLineToPoint(context, self.frame.size.width, xAxis);
    for (int i = 0; i < [self.dataSource chartView:self numberOfValuesInGraph:0]; i++) {
        CGContextMoveToPoint(context, yAxis + (i * xAxisStepWidth), xAxis);
        CGContextAddLineToPoint(context, yAxis + (i * xAxisStepWidth), xAxis + 5.0);
    }
    CGContextMoveToPoint(context, yAxis, 0);
    CGContextAddLineToPoint(context, yAxis, self.frame.size.height);
    for (int i = 0; i < maxValue; i++) {
        CGContextMoveToPoint(context, yAxis, xAxis - (i * yAxisStepWidth));
        CGContextAddLineToPoint(context, yAxis - 5.0, xAxis - (i * yAxisStepWidth));
    }
    CGContextStrokePath(context);
    
    // draw chartline
    for (int i = 0; i < numberOfGraphs; i++) {
        if ([self.delegate respondsToSelector:@selector(chartView:lineWidthForGraph:)]) {
            CGContextSetLineWidth(context, [self.delegate chartView:self lineWidthForGraph:i]);
        } else {
            CGContextSetLineWidth(context, 1.0);
        }
        if ([self.delegate respondsToSelector:@selector(chartView:lineColorForGraph:)]) {
            CGContextSetStrokeColorWithColor(context, [[self.delegate chartView:self lineColorForGraph:i] CGColor]);
        } else {
            CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
        }

        CGContextMoveToPoint(context, yAxisOffset, xAxis - [[self.dataSource chartView:self valueForIndex:0 inGraph:i] floatValue] * yStepWidth);
        for (int j = 1; j < [self.dataSource chartView:self numberOfValuesInGraph:i]; j++) {
            CGContextAddLineToPoint(context, j * xStepWidth + yAxisOffset, xAxis - [[self.dataSource chartView:self valueForIndex:j inGraph:i] floatValue] * yStepWidth);
        }
        CGContextStrokePath(context);
    }
}

@end
