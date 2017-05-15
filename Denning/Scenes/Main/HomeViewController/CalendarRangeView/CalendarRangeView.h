//
//  CalendarRangeView.h
//  Denning
//
//  Created by DenningIT on 26/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLCalendarDateRange.h"

@class EventViewController;
@interface CalendarRangeView : UIViewController

@property (strong, nonatomic) EventViewController* eventViewController;

@property (strong, nonatomic) GLCalendarDateRange* currentRange;
@end
