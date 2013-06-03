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

    // draw x- & -axis
    CGFloat xAxisOffset = 20.0;
    CGFloat yAxisOffset = 20.0;
    
    CGFloat xAxis = self.frame.size.height - xAxisOffset;
    CGFloat yAxis = yAxisOffset;
    
    NSUInteger maxValue = 0;
    for (int i = 0; i < [self.dataSource numberOfValues]; i++) {
        maxValue = MAX(maxValue, [[self.dataSource valueForIndex:i] floatValue]);
    }
    maxValue += 1;

    if ([self.delegate respondsToSelector:@selector(axisColor)]) {
        CGContextSetStrokeColorWithColor(context, [[self.delegate axisColor] CGColor]);
    } else {
        CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
    }
    
    CGFloat xStepWidth = ((self.frame.size.width - yAxisOffset) / ([self.dataSource numberOfValues] * 1.0f));
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
    for (int i = 0; i < [self.dataSource numberOfValues]; i++) {
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
    if ([self.delegate respondsToSelector:@selector(lineWidth)]) {
        CGContextSetLineWidth(context, [self.delegate lineWidth]);
    } else {
        CGContextSetLineWidth(context, 1.0);
    }
    if ([self.delegate respondsToSelector:@selector(lineColor)]) {
        CGContextSetStrokeColorWithColor(context, [[self.delegate lineColor] CGColor]);
    } else {
        CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
    }

    CGContextMoveToPoint(context, yAxisOffset, xAxis - [[self.dataSource valueForIndex:0] floatValue] * yStepWidth);
    for (int i = 1; i < [self.dataSource numberOfValues]; i++) {
        CGContextAddLineToPoint(context, i * xStepWidth + yAxisOffset, xAxis - [[self.dataSource valueForIndex:i] floatValue] * yStepWidth);
        
    }
    CGContextStrokePath(context);
}

@end
