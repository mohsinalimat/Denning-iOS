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
#import "SearchMatterCell.h"
#import "SearchDocumentCell.h"
#import "ContactViewController.h"
#import "RelatedMatterViewController.h"
#import "PropertyViewController.h"
#import "LegalFirmViewController.h"
#import "GovernmentOfficesViewController.h"
#import "LedgerViewController.h"
#import "DocumentViewController.h"

typedef NS_ENUM(NSInteger, DISearchCellType) {
    DIContactCell = 1,
    DIRelatedMatterCell = 2,
    DIPropertyCell = 4,
    DIBankCell = 8,
    DIGovernmentLandOfficesCell = 16,
    DIGovernmentPTGOfficesCell = 17,
    DILegalFirmCell = 32,
    DIDocumentCell = 128,
};

@interface SearchViewController ()<UITextFieldDelegate, AutoCompletionTextFieldDelegate, UITableViewDelegate, UITableViewDataSource, HTHorizontalSelectionListDataSource, HTHorizontalSelectionListDelegate, UIScrollViewDelegate, SearchDelegate, SearchMatterDelegate, SearchDocumentDelegate>
{
    NSInteger category;
    NSString* keyword;
    NSString* searchURL;
    NSArray* generalKeyArray;
    NSMutableArray* generalValueArray;
    __block BOOL isLoading;
    NSString* _matterCode;
    NSString* searchType;
}

@property (weak, nonatomic) IBOutlet AutoCompletionTextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) NSDictionary *generalSearchFilters;
@property (nonatomic, strong) NSDictionary *publicSearchFilters;
@property (weak, nonatomic) IBOutlet UIButton *searchTypeBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchContainerHeight;

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
    [QMNetworkManager sharedManager].searchDataSource.requestURL = PUBLIC_KEYWORD_SEARCH_URL;
    [QMNetworkManager sharedManager].searchDataSource.manager = [QMNetworkManager sharedManager].manager;
    
    self.searchTextField.suggestionsResultDataSource = [QMNetworkManager sharedManager].searchDataSource;
    self.searchTextField.suggestionsResultDelegate = self;
    self.searchTextField.delegate = self;
    self.searchTextField.backgroundColor = [UIColor whiteColor];
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
    
    self.selectionList.selectionIndicatorColor = [UIColor colorWithHexString:@"FF3B2F"];
    [self.selectionList setTitleColor:[UIColor colorWithHexString:@"FF3B2F"] forState:UIControlStateHighlighted];
    [self.selectionList setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.selectionList setTitleFont:[UIFont systemFontOfSize:17] forState:UIControlStateNormal];
    [self.selectionList setTitleFont:[UIFont boldSystemFontOfSize:17] forState:UIControlStateSelected];
    [self.selectionList setTitleFont:[UIFont boldSystemFontOfSize:17] forState:UIControlStateHighlighted];
    
    [self.view addSubview:self.selectionList];
    
    self.selectionList.hidden = YES;
    self.selectionList.backgroundColor = [UIColor clearColor];
    
    category = 0;
    
    // control search contrainer view
    self.searchContainerHeight.constant = 44;
}

- (void)registerNibs {
    
    [SearchResultCell registerForReuseInTableView:self.tableView];
    [SearchMatterCell registerForReuseInTableView:self.tableView];
    [SearchDocumentCell registerForReuseInTableView:self.tableView];
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

- (IBAction)toggleSearchType:(UIButton*)sender {
    if (![[DataManager sharedManager].user.userType isEqualToString:@"denning"]) {
        return;
    }
    
    if ([[DataManager sharedManager].searchType isEqualToString:@"General"]){
        [self.searchTypeBtn setTitle:@"Public" forState:UIControlStateNormal];
        [DataManager sharedManager].searchType = @"Public";
        category = -1;
    } else {
        [DataManager sharedManager].searchType = @"General";
        [self.searchTypeBtn setTitle:@"General" forState:UIControlStateNormal];
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
    [[QMNetworkManager sharedManager] getGlobalSearchFromKeyword:keyword searchURL:searchURL forCategory:category searchType:searchType withCompletion:^(NSArray * _Nonnull resultArray, NSError* _Nonnull error) {
        
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

#pragma mark - SearchDelegate : Contact, Bank, Gvernment Offices, Legal Firm

- (void) didTapMatter:(SearchResultCell *)cell
{
    SearchResultModel* model = self.searchResultArray[cell.tag];
    [self openRelatedMatter:model];
}

#pragma mark - SearchDocumentDelegate : Document

- (void) didTapOpenMatter:(SearchDocumentCell *)cell
{
    SearchResultModel* model = self.searchResultArray[cell.tag];
    [self openRelatedMatter:model];
}

- (void) didTapOpenFolder:(SearchDocumentCell *)cell
{
    SearchResultModel* model = self.searchResultArray[cell.tag];
    [self openDocument:model];
}

#pragma mark - SearchMatterDelegate : Related Matter
- (void) didTapFileFolder:(SearchMatterCell *)cell
{
    SearchResultModel* model = self.searchResultArray[cell.tag];
    [self openDocument:model];
}

- (void) didTapLedger:(SearchMatterCell *)cell
{
    SearchResultModel* model = self.searchResultArray[cell.tag];
    _matterCode = model.key;
    [self openLedger:model];
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
        searchURL = [[DataManager sharedManager].user.serverAPI stringByAppendingString: GENERAL_SEARCH_URL];
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

#pragma mark - Search delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([[DataManager sharedManager].searchType isEqualToString:@"General"]) {
        searchURL = [[DataManager sharedManager].user.serverAPI stringByAppendingString: GENERAL_SEARCH_URL];;
    } else {
        searchURL = PUBLIC_SEARCH_URL;
    }
    
    keyword = self.searchTextField.text;
    [self.searchTextField resignFirstResponder];
    searchType = @"Special";
    [self displaySearchResult];
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)__unused tableView {

    return [self.searchResultArray count];
}

- (NSInteger)tableView:(UITableView *)__unused tableView numberOfRowsInSection:(NSInteger)__unused section {
    
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    SearchResultModel* model = self.searchResultArray[section];
    if ([model.form isEqualToString:@"200customer"]) // Contact
    {
        sectionName = @"Contact";
    } else if ([model.form isEqualToString:@"500file"]){ // Related Matter
        sectionName = @"Matter";
    } else if ([model.form isEqualToString:@"800property"]){ // Property
        sectionName = @"Property";
    } else if ([model.form isEqualToString:@"400bankbranch"]){ // Bank
        sectionName = @"Bank";
    } else if ([model.form isEqualToString:@"310landoffice"]  || [model.form isEqualToString:@"310landregdist"]){ // Government Office
        sectionName = @"Government Office";
    } else if ([model.form isEqualToString:@"320PTG"]){ // Government Office
        sectionName = @"Government Office";
    } else if ([model.form isEqualToString:@"300lawyer"]){ // Legal firm
        sectionName = @"Legal Firm";
    } else if ([model.form isEqualToString:@"950docfile"]){ // Document
        sectionName = @"Document";
    }
    return sectionName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultModel* model = self.searchResultArray[indexPath.section];
    NSUInteger cellType = [self detectItemType:model.form];

    if (cellType == DIContactCell || cellType == DIBankCell || cellType == DIGovernmentPTGOfficesCell || cellType == DIGovernmentLandOfficesCell || cellType == DILegalFirmCell || cellType == DIPropertyCell) {
        SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:[SearchResultCell cellIdentifier] forIndexPath:indexPath];
        
        cell.tag = indexPath.section;
        cell.delegate = self;
        [cell configureCellWithSearchModel:self.searchResultArray[indexPath.section]];
        return cell;
    } else if (cellType == DIRelatedMatterCell) {
        SearchMatterCell *cell = [tableView dequeueReusableCellWithIdentifier:[SearchMatterCell cellIdentifier] forIndexPath:indexPath];
        
        cell.tag = indexPath.section;
        cell.delegate = self;
        [cell configureCellWithSearchModel:self.searchResultArray[indexPath.section]];
        return cell;
    } else if (cellType == DIDocumentCell) {
        SearchDocumentCell *cell = [tableView dequeueReusableCellWithIdentifier:[SearchDocumentCell cellIdentifier] forIndexPath:indexPath];
        
        cell.tag = indexPath.section;
        cell.delegate = self;
        [cell configureCellWithSearchModel:self.searchResultArray[indexPath.section]];
        return cell;
    }
    
    return nil;
}

- (NSUInteger) detectItemType: (NSString*) form
{
    if ([form isEqualToString:@"200customer"]) // Contact
    {
        return DIContactCell;
    } else if ([form isEqualToString:@"500file"]){ // Related Matter
        return DIRelatedMatterCell;
    } else if ([form isEqualToString:@"800property"]){ // Property
        return DIPropertyCell;
    } else if ([form isEqualToString:@"400bankbranch"]){ // Bank
        return DIBankCell;
    } else if ([form isEqualToString:@"310landoffice"] || [form isEqualToString:@"310landregdist"]){ // Government Office
        return DIGovernmentLandOfficesCell;
    } else if ([form isEqualToString:@"320PTG"]){ // Government Office
        return DIGovernmentPTGOfficesCell;
    } else if ([form isEqualToString:@"300lawyer"]){ // Legal firm
        return DILegalFirmCell;
    } else if ([form isEqualToString:@"950docfile"]){ // Document
        return DIDocumentCell;
    }
    
    return 0;
}

- (void) openRelatedMatter: (SearchResultModel*) model {
    [SVProgressHUD showWithStatus:@"Loading"];
    @weakify(self);
    [[QMNetworkManager sharedManager] loadRelatedMatterWithCode:model.key completion:^(RelatedMatterModel * _Nonnull relatedModel, NSError * _Nonnull error) {
        
        @strongify(self);
        self->isLoading = false;
        [SVProgressHUD dismiss];
        if (error == nil) {
            [self performSegueWithIdentifier:kRelatedMatterSegue sender:relatedModel];
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

- (void) openDocument: (SearchResultModel*) model
{
    [SVProgressHUD showWithStatus:@"Loading"];
    @weakify(self);
    [[QMNetworkManager sharedManager] loadDocumentWithCode:[model.key substringToIndex:9] completion:^(DocumentModel * _Nonnull documentModel, NSError * _Nonnull error) {
        @strongify(self);
        self->isLoading = false;
        [SVProgressHUD dismiss];
        if (error == nil) {
            [self performSegueWithIdentifier:kDocumentSearchSegue sender:documentModel];
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

- (void) openLedger: (SearchResultModel*) model
{
    [SVProgressHUD showWithStatus:@"Loading"];
    @weakify(self);
    [[QMNetworkManager sharedManager] loadLedgerWithCode:model.key completion:^(NSArray * _Nonnull ledgerModelArray, NSError * _Nonnull error) {
        
        @strongify(self);
        self->isLoading = false;
        [SVProgressHUD dismiss];
        if (error == nil) {
            [self performSegueWithIdentifier:kLedgerSearchSegue sender:ledgerModelArray];
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

- (void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (isLoading) return;
    isLoading = YES;

    SearchResultModel* model = self.searchResultArray[indexPath.section];
    NSUInteger cellType = [self detectItemType:model.form];
    if (cellType == DIContactCell){ // Contact
        [SVProgressHUD showWithStatus:@"Loading"];
        @weakify(self);
        [[QMNetworkManager sharedManager] loadContactFromSearchWithCode:model.key completion:^(ContactModel * _Nonnull contactModel, NSError * _Nonnull error) {
            
            @strongify(self);
            self->isLoading = false;
            [SVProgressHUD dismiss];
            if (error == nil) {
                [self performSegueWithIdentifier:kContactSearchSegue sender:contactModel];
            } else {
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }];
        
    } else if (cellType  == DIRelatedMatterCell){ // Related Matter
        [self openRelatedMatter:model];
    } else if (cellType  == DIPropertyCell){ // Property
        [SVProgressHUD showWithStatus:@"Loading"];
        @weakify(self);
        [[QMNetworkManager sharedManager] loadPropertyfromSearchWithCode:model.key completion:^(PropertyModel * _Nonnull propertyModel, NSError * _Nonnull error) {
            
            @strongify(self);
            self->isLoading = false;
            [SVProgressHUD dismiss];
            if (error == nil) {
                [self performSegueWithIdentifier:kPropertySearchSegue sender:propertyModel];
            } else {
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }];
    } else if (cellType  == DIBankCell){ // Bank
        [SVProgressHUD showWithStatus:@"Loading"];
        @weakify(self);
        [[QMNetworkManager sharedManager] loadBankFromSearchWithCode:model.key completion:^(BankModel * _Nonnull bankModel, NSError * _Nonnull error) {
            
            @strongify(self);
            self->isLoading = false;
            [SVProgressHUD dismiss];
            if (error == nil) {
                [self performSegueWithIdentifier:kBankSearchSegue sender:bankModel];
            } else {
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }];
    } else if (cellType  == DIGovernmentLandOfficesCell){ // Government offices
        [SVProgressHUD showWithStatus:@"Loading"];
        @weakify(self);
        [[QMNetworkManager sharedManager] loadGovOfficesFromSearchWithCode:model.key type:@"LandOffice" completion:^(GovOfficeModel * _Nonnull govOfficeModel, NSError * _Nonnull error) {
            @strongify(self);
            self->isLoading = false;
            [SVProgressHUD dismiss];
            if (error == nil) {
                [self performSegueWithIdentifier:kGovernmentOfficesSearchSegue sender:govOfficeModel];
            } else {
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }];
    } else if (cellType  == DIGovernmentPTGOfficesCell){ // PTG offices
        [SVProgressHUD showWithStatus:@"Loading"];
        @weakify(self);
        [[QMNetworkManager sharedManager] loadGovOfficesFromSearchWithCode:model.key type:@"PTG" completion:^(GovOfficeModel * _Nonnull govOfficeModel, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            @strongify(self);
            self->isLoading = false;
            if (error == nil) {
                [self performSegueWithIdentifier:kGovernmentOfficesSearchSegue sender:govOfficeModel];
            } else {
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }];
    } else if (cellType  == DILegalFirmCell){ // Legal firm
        [SVProgressHUD showWithStatus:@"Loading"];
        @weakify(self);
        [[QMNetworkManager sharedManager] loadLegalFirmWithCode:model.key completion:^(LegalFirmModel * _Nonnull legalFirmModel, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            @strongify(self);
            self->isLoading = false;
            if (error == nil) {
                [self performSegueWithIdentifier:kLegalFirmSearchSegue sender:legalFirmModel];
            } else {
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }];
    } else if (cellType  == DIDocumentCell) // Document
    {
        [self openDocument:model];
    }
}

#pragma mark - Delegate

- (void)textField:(AutoCompletionTextField*)textField didSelectItem:(id)selectedItem
{
    JSONItem *item = selectedItem;
    textField.text = item.title;
    keyword = item.title;

    if ([[DataManager sharedManager].searchType isEqualToString:@"General"]) {
        searchURL = [[DataManager sharedManager].user.serverAPI stringByAppendingString:GENERAL_SEARCH_URL];
    } else {
        searchURL = PUBLIC_SEARCH_URL;
    }
    
    searchType = @"Normal";
    [self displaySearchResult];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:.5f animations:^{
        self.selectionList.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        self.selectionList.hidden = YES;
    }];
    
    // Control the search contrainer
    self.searchContainerHeight.constant = 280;
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:.5f animations:^{
        self.selectionList.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.selectionList.hidden = NO;
    }];
    
    // Control the search contrainer
    self.searchContainerHeight.constant = 44;
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
        UINavigationController* navVC = segue.destinationViewController;
        ContactViewController* contactVC = navVC.viewControllers.firstObject;
        contactVC.contactModel = sender;
    }
    
    if ([segue.identifier isEqualToString:kRelatedMatterSegue]){
        UINavigationController* navC = segue.destinationViewController;
        RelatedMatterViewController* relatedMatterVC = [navC viewControllers].firstObject;
        relatedMatterVC.relatedMatterModel = sender;
    }
    
    if ([segue.identifier isEqualToString:kPropertySearchSegue]){
        UINavigationController* navC = segue.destinationViewController;
        PropertyViewController* propertyVC = [navC viewControllers].firstObject;
        propertyVC.propertyModel = sender;
    }
    
    if ([segue.identifier isEqualToString:kLegalFirmSearchSegue]){
        UINavigationController* navC = segue.destinationViewController;
        LegalFirmViewController* legalFirmVC = [navC viewControllers].firstObject;
        legalFirmVC.legalFirmModel = sender;
    }
    
    if ([segue.identifier isEqualToString:kGovernmentOfficesSearchSegue]){
        UINavigationController* navC = segue.destinationViewController;
        GovernmentOfficesViewController* GovOfficesVC = [navC viewControllers].firstObject;
        GovOfficesVC.govOfficeModel = sender;
    }

    if ([segue.identifier isEqualToString:kLedgerSearchSegue]){
        UINavigationController* navC = segue.destinationViewController;
        LedgerViewController* ledgerVC = navC.viewControllers.firstObject;
        ledgerVC.ledgerArray = sender;
        ledgerVC.matterCode = _matterCode;
    }
    
    if ([segue.identifier isEqualToString:kDocumentSearchSegue]){
        UINavigationController* navC = segue.destinationViewController;
        DocumentViewController* documentVC = navC.viewControllers.firstObject;
        documentVC.documentModel = sender;
    }
}

@end
