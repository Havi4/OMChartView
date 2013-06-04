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
//

@class OMChartView;


//_____________________________________________________________________________________________________
// this protocol represents the data model object. as such, it supplies no information about appearance

@protocol OMChartViewDatasource <NSObject>

@required

- (NSUInteger)numberOfValuesInChartView:(OMChartView *)chartView;
- (NSNumber*)chartView:(OMChartView *)chartView valueForIndex:(NSUInteger)index;

@optional

@end


//_____________________________________________________________________________________________________
// this protocol represents the delegate object. as such, it supplies only information about appearance

@protocol OMChartViewDelegate <NSObject>

@optional

- (CGFloat)lineWidthInChartView:(OMChartView *)chartView;       // default is 1.0 if not implemented
- (UIColor*)lineColorInChartView:(OMChartView *)chartView;      // default is [UIColor redColor] if not implemented
- (UIColor*)axisColorInChartView:(OMChartView *)chartView;      // default is [UIColor blueColor] if not implemented

@end

@interface OMChartView : UIView

@property(nonatomic,assign)   id <OMChartViewDatasource> dataSource;
@property(nonatomic,assign)   id <OMChartViewDelegate>   delegate;

@end
