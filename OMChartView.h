//
//  OMChartView.h
//  OMChartKit
//
//  Copyright (c) 2013 Oliver Mahn. All rights reserved.
//

//
// v0.1
// - chartView draws a chart with one line for positiv values/indexes only
// v0.2
// - support for multiple chartviews per viewcontroller (api changed)
// v0.3
// - support for multiple graphs per Chart
//

@class OMChartView;


//_____________________________________________________________________________________________________
// this protocol represents the data model object. as such, it supplies no information about appearance

@protocol OMChartViewDatasource <NSObject>

@required

- (NSUInteger)chartView:(OMChartView *)chartView numberOfValuesInGraph:(NSUInteger)graph;
- (NSNumber*)chartView:(OMChartView *)chartView valueForIndex:(NSUInteger)index inGraph:(NSUInteger)graph;

@optional

- (NSInteger)numberOfGraphsInChartView:(OMChartView *)chartView;              // Default is 1 if not implemented

@end


//_____________________________________________________________________________________________________
// this protocol represents the delegate object. as such, it supplies only information about appearance

@protocol OMChartViewDelegate <NSObject>

@optional

- (UIColor*)axisColorInChartView:(OMChartView *)chartView;          // default is [UIColor blueColor] if not implemented

- (CGFloat)chartView:(OMChartView *)chartView lineWidthForGraph:(NSUInteger)graph;       // default is 1.0 if not implemented
- (UIColor*)chartView:(OMChartView *)chartView lineColorForGraph:(NSUInteger)graph;      // default is [UIColor redColor] if not implemented

@end

@interface OMChartView : UIView

@property(nonatomic,assign)   id <OMChartViewDatasource> dataSource;
@property(nonatomic,assign)   id <OMChartViewDelegate>   delegate;

@end
