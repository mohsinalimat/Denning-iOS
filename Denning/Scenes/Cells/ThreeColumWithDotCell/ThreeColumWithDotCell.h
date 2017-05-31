//
//  ThreeColumWithDotCell.h
//  Denning
//
//  Created by Ho Thong Mee on 25/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

typedef void (^AllViewHandler)(void);
typedef void (^TodayViewHandler)(void);
typedef void (^ThisWeekViewHandler)(void);

@interface ThreeColumWithDotCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UILabel *firstCaption;
@property (weak, nonatomic) IBOutlet UILabel *secondCaption;
@property (weak, nonatomic) IBOutlet UILabel *thirdCaption;
@property (weak, nonatomic) IBOutlet BadgeLabel *firstValue;
@property (weak, nonatomic) IBOutlet BadgeLabel *secondValue;
@property (weak, nonatomic) IBOutlet BadgeLabel *thirdValue;
@property (weak, nonatomic) IBOutlet UIView *allView;
@property (weak, nonatomic) IBOutlet UIView *todayView;
@property (weak, nonatomic) IBOutlet UIView *thisWeekView;

@property (strong, nonatomic) AllViewHandler allViewHandler;
@property (strong, nonatomic) TodayViewHandler todayViewHandler;
@property (strong, nonatomic) ThisWeekViewHandler thisWeekViewHandler;

- (void) configureCellWithFirstItem:(ItemModel*) firstItem secondItem:(ItemModel*)secondItem thirdItem:(ItemModel*)thirdItem;
@end
