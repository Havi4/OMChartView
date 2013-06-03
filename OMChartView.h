//
//  OMChartView.h
//  OMChartKit
//
//  Copyright (c) 2013 Oliver Mahn. All rights reserved.
//

//
// v0.1
// - chartView draws a chart with one line for positiv values/indexes only
//
//

@class OMChartView;


//_____________________________________________________________________________________________________
// this protocol represents the data model object. as such, it supplies no information about appearance

@protocol OMChartViewDatasource <NSObject>

@required

- (NSUInteger)numberOfValues;
- (NSNumber*)valueForIndex: (NSUInteger)index;

@end


//_____________________________________________________________________________________________________
// this protocol represents the delegate object. as such, it supplies only information about appearance

@protocol OMChartViewDelegate <NSObject>

@optional

- (CGFloat)lineWidth;       // default is 1.0 if not implemented
- (UIColor*)lineColor;      // default is [UIColor redColor] if not implemented
- (UIColor*)axisColor;      // default is [UIColor blueColor] if not implemented

@end

@interface OMChartView : UIView

@property(nonatomic,assign)   id <OMChartViewDatasource> dataSource;
@property(nonatomic,assign)   id <OMChartViewDelegate>   delegate;

@end
