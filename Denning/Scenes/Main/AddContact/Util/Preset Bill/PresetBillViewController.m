//
//  PresetBillViewController.m
//  Denning
//
//  Created by DenningIT on 12/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "PresetBillViewController.h"

@interface PresetBillViewController ()
<UISearchBarDelegate, UISearchControllerDelegate, UIScrollViewDelegate>
{
    __block BOOL isFirstLoading;
    __block BOOL isLoading;
    __block BOOL isAppending;
    BOOL initCall;
}

@property (strong, nonatomic) NSArray* listOfPresetBills;
@property (strong, nonatomic) NSArray* copyedList;

@property (strong, nonatomic) UISearchController *searchController;
@property (copy, nonatomic) NSString *filter;
@property (strong, nonatomic) NSNumber* page;

@end

@implementation PresetBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self configureSearch];
    [self getList];
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) registerNib {
    
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
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void) prepareUI
{
    self.copyedList = [NSMutableArray new];
    self.page = @(0);
    isFirstLoading = YES;
    self.filter = @"";
    initCall = YES;
    
    self.tableView.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(appendList)
                  forControlEvents:UIControlEventValueChanged];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) appendList {
    isAppending = YES;
    [self getList];
}

- (void) getList {
    if (isLoading) return;
    isLoading = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak UINavigationController *navigationController = self.navigationController;
    @weakify(self)
    [[QMNetworkManager sharedManager] getPresetBillCode:self.page  withSearch:(NSString*)self.filter WithCompletion:^(NSArray * _Nonnull result, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (self.refreshControl.isRefreshing) {
            self.refreshControl.attributedTitle = [DIHelpers getLastRefreshingTime];
            [self.refreshControl endRefreshing];
        }
        
        @strongify(self)
        if (error == nil) {
            if (isAppending) {
                self.listOfPresetBills = [[self.listOfPresetBills arrayByAddingObjectsFromArray:result] mutableCopy];
                if (result.count != 0) {
                    self.page = [NSNumber numberWithInteger:[self.page integerValue] + 1];
                }
            } else {
                self.listOfPresetBills = [result mutableCopy];
            }
            
            [self.tableView reloadData];
            
        }
        else {
            [navigationController showNotificationWithType:QMNotificationPanelTypeWarning message:error.localizedDescription duration:1.0];
        }
        
        [self performSelector:@selector(clean) withObject:nil afterDelay:1.0];
        
    }];
}

- (void) clean {
    isLoading = NO;
    isFirstLoading = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listOfPresetBills.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PresetBillCell" forIndexPath:indexPath];
    
    PresetBillModel *model = self.listOfPresetBills[indexPath.row];
    UILabel* fileNo = [cell viewWithTag:1];
    UILabel* caseName = [cell viewWithTag:2];
    fileNo.text = model.billCode;
    caseName.text = model.billDescription;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PresetBillModel *model = self.listOfPresetBills[indexPath.row];
    self.updateHandler(model);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    //    CGFloat contentHeight = scrollView.contentSize.height;
    if (offsetY > 10) {
        
        [self.searchController.searchBar endEditing:YES];
    }
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    
    if (offsetY > contentHeight - scrollView.frame.size.height && !isFirstLoading && !isLoading) {
        
        [self appendList];
    }
}

#pragma mark - Search Delegate

- (void)willDismissSearchController:(UISearchController *) __unused searchController {
    self.filter = @"";
    isAppending = NO;
    searchController.searchBar.text = @"";
    [self getList];
}

- (void)searchBar:(UISearchBar *) __unused searchBar textDidChange:(NSString *)searchText
{
    self.filter = searchText;
    isAppending = NO;
    [self getList];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.row == self.listOfPresetBills.count-1 && initCall) {
        isFirstLoading = NO;
        initCall = NO;
    }
}

@end
