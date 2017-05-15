//
//  EventViewController.m
//  Denning
//
//  Created by DenningIT on 15/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "EventViewController.h"
#import "EventCell.h"
#import <GLCalendarView.h>
#import <GLDateUtils.h>
#import "CalendarRangeView.h"

@interface EventViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate>
{
    NSString* currentTopFilter, *currentBottomFilter;
    __block BOOL isLoading;
    NSString* startDate, *endDate;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* eventsArray;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventSummaryLabel;

@property (weak, nonatomic) IBOutlet UIButton *todayBtn;
@property (weak, nonatomic) IBOutlet UIButton *thisWeekBtn;
@property (weak, nonatomic) IBOutlet UIButton *futureBtn;
@property (weak, nonatomic) IBOutlet UIButton *previousBtn;

@property (strong, nonatomic) IBOutlet UIButton* allBtn;
@property (strong, nonatomic) IBOutlet UIButton* courtBtn;
@property (strong, nonatomic) IBOutlet UIButton* officeBtn;
@property (strong, nonatomic) IBOutlet UIButton* personalBtn;

@property (strong, nonatomic) EventModel* latestEvent;

@property (strong, nonatomic) UISearchController *searchController;
@property (copy, nonatomic) NSString *filter;

@property (strong, nonatomic) NSArray* topFilters;
@property (strong, nonatomic) NSArray* bottomFilters;

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.eventsArray = self.originalArray;
    startDate = [DIHelpers today];
    endDate = [DIHelpers today];
    [self prepareUI];
    [self displayLatestNewsOnTop];
    [self registerNibs];
    [self configureSearch];
    [self presetDateRange];
    [self setupTopBottomFilters];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupTopBottomFilters {
    self.topFilters = @[@"Today", @"This Week", @"Future", @"Previous"];
    self.bottomFilters = @[@"0All", @"1court", @"2Ofice", @"3personal"];
    currentTopFilter = self.topFilters[0];
    currentBottomFilter = self.bottomFilters[0];
}

- (void) presetDateRange {
    NSDate *today = [NSDate date];
    
    NSDate *beginDate1 = today;
    NSDate *endDate1 = [GLDateUtils dateByAddingDays:6 toDate:today];
    self.currentRange = [GLCalendarDateRange rangeWithBeginDate:beginDate1 endDate:endDate1];
    self.currentRange.backgroundColor = [UIColor colorWithHexString:@"79a9cd"];
    self.currentRange.editable = YES;
}

- (void) configureSearch
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.placeholder = NSLocalizedString(@"Search", nil);
    self.searchController.searchBar.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit]; // iOS8 searchbar sizing
    [self.tableView.tableHeaderView addSubview: self.searchController.searchBar];
}

- (void) displayLatestNewsOnTop
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    self.dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    
    self.eventSummaryLabel.text = [NSString stringWithFormat:@"%ld upcoming events today", self.eventsArray.count];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [self.view endEditing:YES];
    [super viewWillDisappear:animated];
}

- (void) prepareUI
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 13, 23)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBackAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [self.navigationItem setLeftBarButtonItems:@[backButtonItem] animated:YES];
}

- (void) loadEventFromFilters {
    
    if (isLoading) return;
    isLoading = YES;
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:NSLocalizedString(@"QM_STR_LOADING", nil) duration:0];
    __weak UINavigationController *navigationController = self.navigationController;
    @weakify(self);
    [[QMNetworkManager sharedManager] getLatestEventWithStartDate:startDate endDate:endDate filter:currentBottomFilter withCompletion:^(NSArray * _Nonnull eventsArray, NSError * _Nonnull error) {
        
        @strongify(self);
        self->isLoading = NO;
        [navigationController dismissNotificationPanel];
        if (error == nil) {
            
            self.originalArray = eventsArray;
            [self updateEvents];
            
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

- (void) resetState: (UIButton*) button {
    [button setTitleColor:[UIColor colorWithHexString:@"555555"] forState:UIControlStateNormal];
}

- (void) resetButtonState {
    [self resetState:self.allBtn];
    [self resetState:self.courtBtn];
    [self resetState:self.officeBtn];
    [self resetState:self.personalBtn];
}

- (IBAction) allFilter: (id) sender {
    currentBottomFilter = self.bottomFilters[0];

    [self resetButtonState];
    [self.allBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self loadEventFromFilters];
}

- (IBAction) courtFilter: (id) sender  {
    currentBottomFilter = self.bottomFilters[1];
    [self resetButtonState];
    [self.courtBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self loadEventFromFilters];
}

- (IBAction) officeFilter: (id) sender  {
    currentBottomFilter = self.bottomFilters[2];
    
    [self resetButtonState];
    [self.officeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self loadEventFromFilters];
}

- (IBAction) personalFilter: (id) sender  {
    currentBottomFilter = self.bottomFilters[3];
    [self resetButtonState];
    [self.personalBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self loadEventFromFilters];
}

- (IBAction) onBackAction: (id) sender
{
    [self.view endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerNibs {
    
    [EventCell registerForReuseInTableView:self.tableView];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT/2;
}

- (void) resetTopFilterButtons {
    [self resetState:self.todayBtn];
    [self resetState:self.thisWeekBtn];
    [self resetState:self.futureBtn];
    [self resetState:self.previousBtn];
}

- (IBAction)didTapToday:(id)sender {
    [self resetTopFilterButtons];
    [self.todayBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    startDate = [DIHelpers today];
    endDate = [DIHelpers today];
    [self loadEventFromFilters];
}

- (IBAction)didTapThisWeek:(id)sender {
    [self resetTopFilterButtons];
    [self.thisWeekBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    startDate = [DIHelpers currentSunday];
    startDate = [DIHelpers sevenDaysLaterFromDate:startDate];
    [self loadEventFromFilters];
}

- (IBAction)didTapFuture:(id)sender {
    [self resetTopFilterButtons];
    [self.futureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    startDate = [DIHelpers today];
    endDate = [DIHelpers sevenDaysLater];
    [self loadEventFromFilters];
}

- (IBAction)didTapPrevious:(id)sender {
    [self resetTopFilterButtons];
    [self.previousBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    startDate = [DIHelpers sevenDaysBefore];
    endDate = [DIHelpers today];
    [self loadEventFromFilters];
}

- (IBAction)didTapCalendar:(id)sender {
    [self performSegueWithIdentifier:kCalendarRangeSegue sender:self.currentRange];
}

- (void) filterEventArray
{
    NSMutableArray* newArray = [NSMutableArray new];
    for(EventModel* event in self.originalArray) {
        if ([event.subject localizedCaseInsensitiveContainsString:self.filter] || [event.counsel localizedCaseInsensitiveContainsString:self.filter] || [event.location localizedCaseInsensitiveContainsString:self.filter]) {
            [newArray addObject:event];
        }
    }
    self.eventsArray = newArray;
    [self.tableView reloadData];
}

- (void) updateEvents {
    self.filter = @"";
    self.eventsArray = self.originalArray;
    [self.tableView reloadData];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)__unused scrollView {
    
    [self.searchController.searchBar endEditing:YES];
}

#pragma mark - UISearchControllerDelegate

- (void)willDismissSearchController:(UISearchController *) __unused searchController {
    searchController.searchBar.text = @"";
    [self updateEvents];
}

#pragma mark - searchbar delegate

- (void)searchBar:(UISearchBar *) __unused searchBar textDidChange:(NSString *)searchText
{
    self.filter = searchText;
    if (self.filter.length == 0) {
        self.eventsArray = self.originalArray;
        [self.tableView reloadData];
    } else {
       [self filterEventArray];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)__unused tableView {
    
    return [self.eventsArray count];
}

- (NSInteger)tableView:(UITableView *)__unused tableView numberOfRowsInSection:(NSInteger)__unused section {
    
    return self.eventsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     EventCell *cell = [tableView dequeueReusableCellWithIdentifier:[EventCell cellIdentifier] forIndexPath:indexPath];
    
    cell.tag = indexPath.row;
    [cell configureCellWithEvent:self.eventsArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventModel* event = self.eventsArray[indexPath.row+1];
    NSURL* url = [NSURL URLWithString:event.URL];
    
    if (![url.scheme isEqual:@"http"] && ![url.scheme isEqual:@"https"]) {
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kCalendarRangeSegue]) {
        CalendarRangeView* calendarRangeViewVC = segue.destinationViewController;
        calendarRangeViewVC.currentRange = self.currentRange;
    }
}


@end
