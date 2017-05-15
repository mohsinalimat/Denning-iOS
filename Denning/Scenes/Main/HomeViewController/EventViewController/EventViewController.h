//
//  EventViewController.h
//  Denning
//
//  Created by DenningIT on 15/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLCalendarDateRange.h>

@interface EventViewController : UIViewController

@property (strong, nonatomic) NSArray* originalArray;
@property (strong, nonatomic) GLCalendarDateRange *currentRange;
@end
