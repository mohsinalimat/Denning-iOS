//
//  LineGraphCell.h
//  Denning
//
//  Created by Ho Thong Mee on 25/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface LineGraphCell : DIGeneralCell<MultiLineGraphViewDataSource, MultiLineGraphViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *graphCaption;
@property (weak, nonatomic) IBOutlet UIImageView *graphView;
@property (strong, nonatomic) NSArray* xAxisData, *yAxisData;

- (void)createLineGraph:(UIView*) view withGraphModel:(GraphModel*) graph;
- (void) showGraphWithGraphModel:(GraphModel*) graph;

@end
