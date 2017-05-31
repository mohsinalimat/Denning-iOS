//
//  LineGraphCell.m
//  Denning
//
//  Created by Ho Thong Mee on 25/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "LineGraphCell.h"

@interface LineGraphCell()
{
}

@end

@implementation LineGraphCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma Mark CreateLineGraph
- (void)createLineGraph:(UIView*) view withGraphModel:(GraphModel*) graph {
    MultiLineGraphView* myGraph = [[MultiLineGraphView alloc] initWithFrame:CGRectMake(0, header_height, WIDTH(view), HEIGHT(self.graphView) - header_height)];
//    UIGraphicsBeginImageContext(myGraph.bounds.size);
//    [myGraph.layer renderInContext:UIGraphicsGetCurrentContext()];
    [myGraph setDelegate:self];
    [myGraph setDataSource:self];
    [myGraph setShowLegend:NO];
    [myGraph setLegendViewType:LegendTypeHorizontal];
    [myGraph setShowCustomMarkerView:NO];
    self.xAxisData = graph.xValue;
    self.yAxisData = graph.yValue;
    self.graphCaption.text = graph.graphName.uppercaseString;
    [myGraph drawGraph];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();

//    self.graphView.image = image;
//    [self.graphView addSubview:myGraph];
    [self.graphView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.graphView addSubview: myGraph];
}

- (void) showGraphWithGraphModel:(GraphModel*) graph {
    
     //   [graph reloadGraph];
}

#pragma mark MultiLineGraphViewDataSource
- (NSInteger)numberOfLinesToBePlotted{
    return 1;
}

- (LineDrawingType)typeOfLineToBeDrawnWithLineNumber:(NSInteger)lineNumber{
    return LineDefault;
}


- (UIColor *)colorForTheLineWithLineNumber:(NSInteger)lineNumber{
    
    return [UIColor babyBule];
}

- (CGFloat)widthForTheLineWithLineNumber:(NSInteger)lineNumber{
    return 1;
}

- (NSString *)nameForTheLineWithLineNumber:(NSInteger)lineNumber{
    return [NSString stringWithFormat:@"data %ld",(long)lineNumber];
}

- (BOOL)shouldFillGraphWithLineNumber:(NSInteger)lineNumber{
    return NO;
}


- (BOOL)shouldDrawPointsWithLineNumber:(NSInteger)lineNumber{
    return YES;
}


- (NSMutableArray *)dataForYAxisWithLineNumber:(NSInteger)lineNumber {
    
    return [self.yAxisData mutableCopy];
}


- (NSMutableArray *)dataForXAxisWithLineNumber:(NSInteger)lineNumber {
    return [self.xAxisData mutableCopy];

}

- (UIView *)customViewForLineChartTouchWithXValue:(id)xValue andYValue:(id)yValue{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view.layer setCornerRadius:4.0F];
    [view.layer setBorderWidth:1.0F];
    [view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [view.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [view.layer setShadowRadius:2.0F];
    [view.layer setShadowOpacity:0.3F];
    
    CGFloat y = 0;
    CGFloat width = 0;
    for (int i = 0; i < 3 ; i++) {
        UILabel *label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:12]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:[NSString stringWithFormat:@"Line Data:y = %@ x = %@", yValue, xValue]];
        [label setFrame:CGRectMake(0, y, 200, 30)];
        [view addSubview:label];
        
        width = WIDTH(label);
        y = BOTTOM(label);
    }
    
    [view setFrame:CGRectMake(0, 0, width, y)];
    return view;
}

#pragma mark MultiLineGraphViewDelegate
- (void)didTapWithValuesAtX:(NSString *)xValue valuesAtY:(NSString *)yValue{
    NSLog(@"Line Chart: Value-X:%@, Value-Y:%@",xValue, yValue);
}
@end
