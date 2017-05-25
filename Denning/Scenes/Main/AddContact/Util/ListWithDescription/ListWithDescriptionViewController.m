//
//  ListWithDescriptionViewController.m
//  Denning
//
//  Created by DenningIT on 03/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "ListWithDescriptionViewController.h"
#import "AddContactViewController.h"

@interface ListWithDescriptionViewController ()<UISearchBarDelegate, UISearchControllerDelegate, UIScrollViewDelegate>
{
    __block BOOL isFirstLoading;
    __block BOOL isLoading;
    BOOL isAppending;
    BOOL initCall;
}

@property (strong, nonatomic) NSArray* listOfDesc;

@property (strong, nonatomic) NSMutableArray* copyedList;
@property (strong, nonatomic) UISearchController *searchController;
@property (copy, nonatomic) NSString *filter;
@property (strong, nonatomic) NSNumber* page;
@end

@implementation ListWithDescriptionViewController
@synthesize name;
@synthesize url;
@synthesize titleOfList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self configureSearch];
    [self getList];
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
    self.title = self.titleOfList;
    self.copyedList = [NSMutableArray new];
    self.page = @(1);
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

- (void) filterList {
    NSMutableArray* newArray = [NSMutableArray new];
    if (self.filter.length == 0) {
        self.listOfDesc = self.copyedList;
    } else {
        for(NSString* value in self.listOfDesc) {
            if ([value localizedCaseInsensitiveContainsString:self.filter]) {
                [newArray addObject:value];
            }
        }
        self.listOfDesc = newArray;
    }
    
    [self.tableView reloadData];
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
    [[QMNetworkManager sharedManager] getDescriptionWithUrl:self.url withPage:self.page withSearch:(NSString*)self.filter withCompletion:^(NSArray * _Nonnull result, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        @strongify(self)
        if (self.refreshControl.isRefreshing) {
            self.refreshControl.attributedTitle = [DIHelpers getLastRefreshingTime];
            [self.refreshControl endRefreshing];
        }
        
        if (error == nil) {
            if (result.count != 0) {
                self.page = [NSNumber numberWithInteger:[self.page integerValue] + 1];
            }
            if (isAppending) {
                self.listOfDesc = [[self.listOfDesc arrayByAddingObjectsFromArray:result] mutableCopy];
                
            } else {
                self.listOfDesc = [result mutableCopy];
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
    
    return self.listOfDesc.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CodeDescCell" forIndexPath:indexPath];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = self.listOfDesc[indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.contactDelegate didSelectListWithDescription:self name:self.name withString:self.listOfDesc[indexPath.row]];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
    searchController.searchBar.text = @"";
    isAppending = NO;
    [self getList];
}


- (void)searchBar:(UISearchBar *) __unused searchBar textDidChange:(NSString *)searchText
{
    self.filter = searchText;
    isAppending = NO;
    [self getList];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.row == self.listOfDesc.count-1 && initCall) {
        isFirstLoading = NO;
        initCall = NO;
    }
}

@end
