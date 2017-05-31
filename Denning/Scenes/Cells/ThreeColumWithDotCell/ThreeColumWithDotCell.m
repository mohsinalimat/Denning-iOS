//
//  ThreeColumWithDotCell.m
//  Denning
//
//  Created by Ho Thong Mee on 25/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "ThreeColumWithDotCell.h"

@implementation ThreeColumWithDotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer* allViewRecognizer = [[UITapGestureRecognizer alloc] init];
    allViewRecognizer.numberOfTapsRequired = 1;
    [allViewRecognizer addTarget:self action:@selector(allViewTapped)];
    [self.allView addGestureRecognizer:allViewRecognizer];
    
    UITapGestureRecognizer* todayViewRecognizer = [[UITapGestureRecognizer alloc] init];
    todayViewRecognizer.numberOfTapsRequired = 1;
    [todayViewRecognizer addTarget:self action:@selector(todayViewTapped)];
    [self.todayView addGestureRecognizer:todayViewRecognizer];
    
    UITapGestureRecognizer* thisWeekViewRecognizer = [[UITapGestureRecognizer alloc] init];
    thisWeekViewRecognizer.numberOfTapsRequired = 1;
    [thisWeekViewRecognizer addTarget:self action:@selector(thisWeekViewTapped)];
    [self.thisWeekView addGestureRecognizer:thisWeekViewRecognizer];
}

- (void) allViewTapped {
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.allView.backgroundColor = [UIColor grayColor];
                     }
                     completion:^(BOOL finished) {
                         self.allView.backgroundColor = [UIColor clearColor];
                         self.allViewHandler();
                     }];
    
}

- (void) todayViewTapped {
    self.todayViewHandler();
}

- (void) thisWeekViewTapped {
    self.thisWeekViewHandler();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureCellWithFirstItem:(ItemModel*) firstItem secondItem:(ItemModel*)secondItem thirdItem:(ItemModel*)thirdItem
{
    self.firstCaption.text = firstItem.label.capitalizedString;
    self.firstValue.text = firstItem.value;
    self.secondCaption.text = secondItem.label.capitalizedString;
    self.secondValue.text = secondItem.value;
    self.thirdCaption.text = thirdItem.label.capitalizedString;
    self.thirdValue.text = thirdItem.value;
}
@end
