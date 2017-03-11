 //
//  ViewController.m
//  Denning
//
//  Created by DenningIT on 19/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "SearchViewController.h"
#import <HTHorizontalSelectionList/HTHorizontalSelectionList.h>
#import "SearchResultCell.h"
#import "ContactViewController.h"
#import "RelatedMatterViewController.h"
#import "PropertyViewController.h"

@interface SearchViewController ()<UITextFieldDelegate, AutoCompletionTextFieldDelegate, UITableViewDelegate, UITableViewDataSource, HTHorizontalSelectionListDataSource, HTHorizontalSelectionListDelegate, UIScrollViewDelegate>
{
    NSInteger category;
    NSString* keyword;
    NSString* searchURL;
    NSArray* generalKeyArray;
    NSMutableArray* generalValueArray;
}

@property (weak, nonatomic) IBOutlet AutoCompletionTextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) NSDictionary *generalSearchFilters;
@property (nonatomic, strong) NSDictionary *publicSearchFilters;
@property (weak, nonatomic) IBOutlet UIButton *searchTypeBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) NSMutableArray* searchResultArray;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self registerNibs];
    [self prepareUI];
    [self addTapGesture];
    [self prepareSearchTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareSearchTextField
{
    [QMNetworkManager sharedManager].searchDataSource.requestURL = GENERAL_KEYWORD_SEARCH_URL;
    [QMNetworkManager sharedManager].searchDataSource.manager = [QMNetworkManager sharedManager].manager;
    
    self.searchTextField.suggestionsResultDataSource = [QMNetworkManager sharedManager].searchDataSource;
    self.searchTextField.suggestionsResultDelegate = self;
    self.searchTextField.delegate = self;
    self.searchTextField.backgroundColor = [UIColor whiteColor];
    self.searchTextField.clearButtonMode = UITextFieldViewModeNever;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =  YES;
    
    if (self.tableView.refreshControl.isRefreshing) {
        // fix for freezing refresh control after tab bar switch
        // if it is still active
        CGPoint offset = self.tableView.contentOffset;
        [self.tableView.refreshControl endRefreshing];
        [self.tableView.refreshControl beginRefreshing];
        self.tableView.contentOffset = offset;
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void) prepareUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"EBEBF1"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.tableView.refreshControl = [[UIRefreshControl alloc] init];
    self.tableView.refreshControl.backgroundColor = [UIColor clearColor];
    self.tableView.refreshControl.tintColor = [UIColor blackColor];
    [self.tableView.refreshControl addTarget:self
                            action:@selector(displaySearchResult)
                  forControlEvents:UIControlEventValueChanged];
    
    self.selectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 69, self.view.frame.size.width, 44)];
    self.selectionList.delegate = self;
    self.selectionList.dataSource = self;
    
    self.generalSearchFilters = @{@"All": [NSNumber numberWithInteger: All],
                                  @"Contacts":[NSNumber numberWithInteger: Contact],
                                  @"Related Matter": [NSNumber numberWithInteger: RelatedMatter],
                                  @"Property": [NSNumber numberWithInteger: Property],
                                  @"Bank": [NSNumber numberWithInteger: Bank],
                                  @"Government Offices": [NSNumber numberWithInteger: GovernmentOffices],
                                  @"Legal Firm": [NSNumber numberWithInteger: LegalFirm],
                                  @"Documents": [NSNumber numberWithInteger: Documents]
                                  };
    
    generalKeyArray = [self.generalSearchFilters keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    generalValueArray = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger: All], [NSNumber numberWithInteger: Contact], [NSNumber numberWithInteger: RelatedMatter], [NSNumber numberWithInteger: Property], [NSNumber numberWithInteger: Bank], [NSNumber numberWithInteger: GovernmentOffices], [NSNumber numberWithInteger: LegalFirm], [NSNumber numberWithInteger: Documents], nil];
    
    self.publicSearchFilters = @{@"All Public": [NSNumber numberWithInteger:AllPublic],
                                 @"Public LawFirm": [NSNumber numberWithInteger: PublicLawFirm],
                                 @"Public Document": [NSNumber numberWithInteger: PublicDocment],
                                 @"Public Government Offices": [NSNumber numberWithInteger: PublicGovernmentOffices],
                                 };
    
    self.selectionList.selectionIndicatorAnimationMode = HTHorizontalSelectionIndicatorAnimationModeLightBounce;
    self.selectionList.showsEdgeFadeEffect = YES;
   // self.selectionList.snapToCenter = YES;
    
    self.selectionList.selectionIndicatorColor = [UIColor colorWithHexString:@"2196F3"];
    [self.selectionList setTitleColor:[UIColor colorWithHexString:@"2196F3"] forState:UIControlStateHighlighted];
    [self.selectionList setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.selectionList setTitleFont:[UIFont systemFontOfSize:17] forState:UIControlStateNormal];
    [self.selectionList setTitleFont:[UIFont boldSystemFontOfSize:17] forState:UIControlStateSelected];
    [self.selectionList setTitleFont:[UIFont boldSystemFontOfSize:17] forState:UIControlStateHighlighted];
    
    [self.view addSubview:self.selectionList];
    
    self.selectionList.hidden = YES;
    self.selectionList.backgroundColor = [UIColor clearColor];
    
    category = 1;
}

- (void)registerNibs {
    
    [SearchResultCell registerForReuseInTableView:self.tableView];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT/2;
}

- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}
- (IBAction)dismissView:(id)sender {
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)handleTap {
    [self.view endEditing:YES];
}

- (void) updateSelectionList
{
    [self.selectionList reloadData];
    self.selectionList.selectedButtonIndex = 0;
}

- (void) updateUI
{
    [self updateSelectionList];
    [self.searchResultArray removeAllObjects];
    [self.tableView reloadData];
    self.searchTextField.text = @"";
    self.searchTextField.hidden = NO;
}

- (IBAction)eraseSearchBox:(id)sender {
}


- (IBAction)toggleSearchType:(UIButton*)sender {
    if ([[DataManager sharedManager].searchType isEqualToString:@"General"]){
        [DataManager sharedManager].searchType = @"Public";
        category = -1;
    } else {
        [DataManager sharedManager].searchType = @"General";
        category = 0;
    }

//    [self.searchTypeBtn setTitle:[DataManager sharedManager].searchType forState:UIControlStateNormal];
    [self updateUI];
}

- (IBAction)tapLogoBtn:(id)sender {
    [self dismissView:sender];
}

- (void) displaySearchResult
{
    @weakify(self)
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [[QMNetworkManager sharedManager] getGlobalSearchFromKeyword:keyword searchURL:searchURL forCategory:category withCompletion:^(NSArray * _Nonnull resultArray, NSError* _Nonnull error) {
        
        [SVProgressHUD dismiss];
        
        if (self.tableView.refreshControl.isRefreshing) {
            CGPoint offset = self.tableView.contentOffset;
            self.tableView.refreshControl.attributedTitle = [DIHelpers getLastRefreshingTime];
            [self.tableView.refreshControl endRefreshing];
            self.tableView.contentOffset = offset;
        }
        
        @strongify(self);
        if (error == nil)
        {
            self.searchResultArray = [resultArray mutableCopy];
            [self.tableView reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    if ([[DataManager sharedManager].searchType isEqualToString:@"General"]){
        return self.generalSearchFilters.count;
    }
    return self.publicSearchFilters.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    if ([[DataManager sharedManager].searchType isEqualToString:@"General"]){
        return generalKeyArray[index];
    }
    return self.publicSearchFilters.allKeys[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    // update the view for the corresponding index
    
    if ([[DataManager sharedManager].searchType isEqualToString:@"General"]){
        category = [generalValueArray[index] integerValue];
        searchURL = GENERAL_SEARCH_URL;
    } else {
        category = [self.publicSearchFilters.allValues[index] integerValue];
        searchURL = PUBLIC_SEARCH_URL;
    }
    
    if (self.searchResultArray.count != 0) {
        [self.searchResultArray removeAllObjects];
    }
    
    [self.tableView reloadData];
    [self.searchTextField resignFirstResponder];
    
    [self displaySearchResult];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)__unused tableView {

    return [self.searchResultArray count];
}

- (NSInteger)tableView:(UITableView *)__unused tableView numberOfRowsInSection:(NSInteger)__unused section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:[SearchResultCell cellIdentifier] forIndexPath:indexPath];
    
    cell.tag = indexPath.section;
    [cell configureCellWithSearchModel:self.searchResultArray[indexPath.section]];
    
    return cell;
}

- (void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SearchResultCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.tag == 1){ // Contact
        [self performSegueWithIdentifier:kContactSearchSegue sender:self.searchResultArray[indexPath.section]];
    } else if (cell.tag == 2){ // Related Matter
        [self performSegueWithIdentifier:kRelatedMatterSegue sender:self.searchResultArray[indexPath.section]];
    } else if (cell.tag == 4){ // Property
        id sender = self.searchResultArray[indexPath.section];
        [self performSegueWithIdentifier:kPropertySearchSegue sender:sender];
//    } else if (cell.tag == 8){ // Bank
//        [self performSegueWithIdentifier:kPropertySearchSegue sender:self.searchResultArray[indexPath.section]];
//    } else if (cell.tag == 16){ // Government offices
//        [self performSegueWithIdentifier:kPropertySearchSegue sender:self.searchResultArray[indexPath.section]];
//    } else if (cell.tag == 16){ // Government offices
//        [self performSegueWithIdentifier:kPropertySearchSegue sender:self.searchResultArray[indexPath.section]];
    }
    
}

#pragma mark - Delegate

- (void)textField:(AutoCompletionTextField*)textField didSelectItem:(id)selectedItem
{
    JSONItem *item = selectedItem;
    textField.text = item.title;
    keyword = item.title;

    if ([[DataManager sharedManager].searchType isEqualToString:@"General"]) {
        searchURL = GENERAL_SEARCH_URL;
    } else {
        searchURL = PUBLIC_SEARCH_URL;
    }
    
    [self displaySearchResult];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:.5f animations:^{
        self.selectionList.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        self.selectionList.hidden = YES;
    }];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:.5f animations:^{
        self.selectionList.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.selectionList.hidden = NO;
    }];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if([scrollView.panGestureRecognizer translationInView:scrollView.superview].y < 0) {
        // up
        
    } else {
        // down
        
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kContactSearchSegue]){
        ContactViewController* contactVC = segue.destinationViewController;
        contactVC.responseCell = sender;
    }
    
    if ([segue.identifier isEqualToString:kRelatedMatterSegue]){
        RelatedMatterViewController* relatedMatterVC = segue.destinationViewController;
        relatedMatterVC.responseCell = sender;
    }
    
    if ([segue.identifier isEqualToString:kPropertySearchSegue]){
        UINavigationController* navC = segue.destinationViewController;
        PropertyViewController* propertyVC = [navC viewControllers].firstObject;
        propertyVC.responseCell = sender;
    }
}

@end
