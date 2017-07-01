//
//  DashboardFileListing.m
//  Denning
//
//  Created by Ho Thong Mee on 28/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "DashboardFileListing.h"
#import "FileListingHeaderCell.h"
#import "FileListingCell.h"

@interface DashboardFileListing ()
<UISearchBarDelegate, UISearchControllerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    __block BOOL isFirstLoading;
    __block BOOL isLoading;
    BOOL initCall;
    BOOL isAppending;
    
    NSInteger _idx;
}

@property (weak, nonatomic) IBOutlet UIView *searchContainer;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* listOfFiles;
@property (strong, nonatomic) NSArray<ItemModel*> *items;
@property (strong, nonatomic) UISearchController *searchController;
@property (copy, nonatomic) NSString *filter;
@property (strong, nonatomic) NSNumber* page;
@property (weak, nonatomic) IBOutlet UIView *allView;
@property (weak, nonatomic) IBOutlet UILabel *allLabel;
@property (weak, nonatomic) IBOutlet BadgeLabel *allBadge;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
@property (weak, nonatomic) IBOutlet BadgeLabel *todayBadge;
@property (weak, nonatomic) IBOutlet UIView *todayView;
@property (weak, nonatomic) IBOutlet UIView *weekView;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet BadgeLabel *weekBadge;
@property (strong, nonatomic) NSArray<UILabel*>* topLabels;
@end

@implementation DashboardFileListing

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self registerNibs];
    [self configureSearch];
    _idx = 1;
    [self getHeaderWithCompletion:^{
        [self getList];
    }];
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
    [self.searchContainer addSubview:self.searchController.searchBar];
}

- (void)registerNibs {
    [FileListingHeaderCell registerForReuseInTableView:self.tableView];
    [FileListingCell registerForReuseInTableView:self.tableView];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
}

- (void) prepareUI
{
    _topLabels = @[_allLabel, _todayLabel, _weekLabel];
    self.page = @(1);
    isFirstLoading = YES;
    self.filter = @"";
    initCall = YES;
    isAppending = NO;

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    
    UITapGestureRecognizer* allTap = [UITapGestureRecognizer new];
    allTap.numberOfTapsRequired = 1;
    [allTap addTarget:self action:@selector(allTapped)];
    [_allView addGestureRecognizer:allTap];
    
    UITapGestureRecognizer* todayTap = [UITapGestureRecognizer new];
    todayTap.numberOfTapsRequired = 1;
    [todayTap addTarget:self action:@selector(todayTapped)];
    [_todayView addGestureRecognizer:todayTap];
    
    UITapGestureRecognizer* weekTap = [UITapGestureRecognizer new];
    weekTap.numberOfTapsRequired = 1;
    [weekTap addTarget:self action:@selector(weekTapped)];
    [_weekView addGestureRecognizer:weekTap];
}

- (void) resetLabel {
    for (UILabel *label in _topLabels) {
        label.textColor = [UIColor grayColor];
    }
}

- (void) didTapLabel:(NSInteger) index {
    [self resetLabel];
    _topLabels[index].textColor = [UIColor redColor];
    _idx = index;
    [self getList];
}

- (void) allTapped {
    [self didTapLabel:0];
}

- (void) todayTapped {
    [self didTapLabel:1];
}

- (void) weekTapped {
    [self didTapLabel:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) appendList {
    isAppending = YES;
    [self getList];
}

- (void) updateHeader {
    _allLabel.text = _items[0].label;
    _allBadge.text = _items[0].value;
    _todayLabel.text = _items[1].label;
    _todayBadge.text = _items[1].value;
    _weekLabel.text = _items[2].label;
    _weekBadge.text = _items[2].value;
}

- (void) getHeaderWithCompletion:(void(^)(void))completion;
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [[QMNetworkManager sharedManager] getDashboardThreeItmesInURL:DASHBOARD_S1_MATTERLISTING_GET_URL withCompletion:^(ThreeItemModel * _Nonnull result, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        if (error == nil) {
            _items = result.items;
            [self updateHeader];
            if (completion != nil) {
                completion();
            }
        }
    }];
}

- (void) getList{

    if (isLoading) return;
    isLoading = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak UINavigationController *navigationController = self.navigationController;
    @weakify(self)
    [[QMNetworkManager sharedManager] getNewMatterInURL:_items[_idx].api withPage:self.page withFilter:self.filter withCompletion:^(NSArray * _Nonnull result, NSError * _Nonnull error) {
        @strongify(self)
        if (error == nil) {
            if (result.count != 0) {
                self.page = [NSNumber numberWithInteger:[self.page integerValue] + 1];
            }
            if (isAppending) {
                self.listOfFiles = [[self.listOfFiles arrayByAddingObjectsFromArray:result] mutableCopy];
                
            } else {
                self.listOfFiles = [result mutableCopy];
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
    
    return self.listOfFiles.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FileListingHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[FileListingHeaderCell cellIdentifier]];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultModel *model = self.listOfFiles[indexPath.row];
    
    FileListingCell *cell = [tableView dequeueReusableCellWithIdentifier:[FileListingCell cellIdentifier] forIndexPath:indexPath];
    cell.fileNo.text = model.key;
    cell.fileNo.text = [DIHelpers separateNameIntoTwo:[model.title substringFromIndex:10]][1];
    cell.openDate.text = [DIHelpers getDateInShortForm:model.sortDate];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    if (offsetY > contentHeight - scrollView.frame.size.height && !isFirstLoading) {
        
        [self appendList];
    }
}

#pragma mark - Search Delegate


- (void)willDismissSearchController:(UISearchController *) __unused searchController {
    self.filter = @"";
    self.page = @(1);
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
    if (indexPath.row == self.listOfFiles.count-1 && initCall) {
        isFirstLoading = NO;
        initCall = NO;
    }
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
