//
//  EventViewController.m
//  Denning
//
//  Created by DenningIT on 15/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "EventViewController.h"
#import "EventCell.h"

@interface EventViewController () <UISearchBarDelegate, UISearchControllerDelegate>
@property (strong, nonatomic) NSArray* eventsArray;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventSummaryLabel;

@property (strong, nonatomic) EventModel* latestEvent;

@property (strong, nonatomic) UISearchController *searchController;
@property (copy, nonatomic) NSString *filter;

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.eventsArray = self.originalArray;
    [self prepareUI];
    [self displayLatestNewsOnTop];
    [self registerNibs];
    [self configureSearch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSDate* date = [[NSDate alloc] init];
    self.dateLabel.text = [dateFormatter stringFromDate:date];
    
    self.eventSummaryLabel.text = [NSString stringWithFormat:@"%ld upcoming events today", self.eventsArray.count];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

- (void) prepareUI
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 13, 23)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBackAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [self.navigationItem setLeftBarButtonItems:@[backButtonItem] animated:YES];
}

- (void) onBackAction: (id) sender
{
    [self.view endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerNibs {
    
    [EventCell registerForReuseInTableView:self.tableView];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT/2;
}

- (void) filterEventArray
{
    NSMutableArray* newArray = [NSMutableArray new];
    for(EventModel* event in self.originalArray) {
        if ([event.description localizedCaseInsensitiveContainsString:self.filter] || [event.location localizedCaseInsensitiveContainsString:self.filter]) {
            [newArray addObject:event];
        }
    }
    self.eventsArray = newArray;
    [self.tableView reloadData];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)__unused scrollView {
    
    [self.searchController.searchBar endEditing:YES];
}

#pragma mark - UISearchControllerDelegate

- (void)willDismissSearchController:(UISearchController *) __unused searchController {
    self.filter = @"";
    searchController.searchBar.text = @"";
    self.eventsArray = self.originalArray;
    [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)__unused tableView {
    
    return [self.eventsArray count];
}

- (NSInteger)tableView:(UITableView *)__unused tableView numberOfRowsInSection:(NSInteger)__unused section {
    
    return 1;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
