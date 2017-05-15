//
//  CalendarRangeView.m
//  Denning
//
//  Created by DenningIT on 26/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "CalendarRangeView.h"
#import "GLCalendarView.h"

#import "GLDateUtils.h"
#import "GLCalendarDayCell.h"
#import "EventViewController.h"

@interface CalendarRangeView ()<GLCalendarViewDelegate>
@property (weak, nonatomic) IBOutlet GLCalendarView *calendarView;
@property (nonatomic, weak) GLCalendarDateRange *rangeUnderEdit;

@end

@implementation CalendarRangeView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.calendarView.delegate = self;
    self.calendarView.showMaginfier = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   
    self.calendarView.ranges = [@[self.currentRange] mutableCopy];
    
    [self.calendarView reload];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.calendarView scrollToDate:self.calendarView.lastDate animated:NO];
    });
}

- (BOOL)calenderView:(GLCalendarView *)calendarView canAddRangeWithBeginDate:(NSDate *)beginDate
{
    return NO;
}

- (GLCalendarDateRange *)calenderView:(GLCalendarView *)calendarView rangeToAddWithBeginDate:(NSDate *)beginDate
{
    if (self.calendarView.ranges.count > 0) {
        return self.currentRange;
    }
    NSDate* endDate = [GLDateUtils dateByAddingDays:3 toDate:beginDate];
    GLCalendarDateRange *range = [GLCalendarDateRange rangeWithBeginDate:beginDate endDate:endDate];
    range.backgroundColor = [UIColor colorWithHexString:@"79a9cd"];
    range.editable = YES;
    return range;
}

- (void)calenderView:(GLCalendarView *)calendarView beginToEditRange:(GLCalendarDateRange *)range
{
    NSLog(@"begin to edit range: %@", range);
    self.rangeUnderEdit = range;
}

- (void)calenderView:(GLCalendarView *)calendarView finishEditRange:(GLCalendarDateRange *)range continueEditing:(BOOL)continueEditing
{
    NSLog(@"finish edit range: %@", range);
    self.rangeUnderEdit = nil;
}

- (BOOL)calenderView:(GLCalendarView *)calendarView canUpdateRange:(GLCalendarDateRange *)range toBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate
{
    return YES;
}

- (void)calenderView:(GLCalendarView *)calendarView didUpdateRange:(GLCalendarDateRange *)range toBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate
{
    NSLog(@"did update range: %@", range);
}

- (IBAction)popupScreen:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)selectButtonPressed:(id)sender {
    self.eventViewController.currentRange = self.calendarView.ranges[0];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
