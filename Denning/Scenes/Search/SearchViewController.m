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
#import "NewLedgerViewController.h"
#import "DocumentViewController.h"
#import "BankViewController.h"
#import "MLPAutoCompleteTextField.h"
#import "DEMOCustomAutoCompleteCell.h"
#import "DEMOCustomAutoCompleteObject.h"
#import "AFHTTPSessionOperation.h"
#import "AddPropertyViewController.h"
#import "FileNoteList.h"
#import "PaymentRecord.h"

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

@interface SearchViewController ()<UITextFieldDelegate, MLPAutoCompleteTextFieldDelegate, MLPAutoCompleteTextFieldDataSource,
UITableViewDelegate, UITableViewDataSource, HTHorizontalSelectionListDataSource, HTHorizontalSelectionListDelegate, UIScrollViewDelegate, SearchDelegate, SearchMatterDelegate, SearchDocumentDelegate>
{
    NSInteger category;
    NSInteger selectedIndexOfFilter;
    NSString* keyword;
    NSString* searchURL;
    NSString* searchKeywordURL;
    NSArray* generalKeyArray;
    NSMutableArray* generalValueArray;
    __block BOOL isLoading;
    NSString* _matterCode;
    NSString* searchType;
    NSString* gotoMatter;
    NSString* _email;
    NSString* _sessionID;
    BOOL isDenningUser;
}

@property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *searchTextField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) NSDictionary *generalSearchFilters;
@property (nonatomic, strong) NSDictionary *publicSearchFilters;
@property (weak, nonatomic) IBOutlet UIButton *searchTypeBtn;

@property (strong, nonatomic) NSMutableArray* searchResultArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchContainerConstraint;
@property (weak, nonatomic) IBOutlet UIView *searchContainerView;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self registerNibs];
    [self prepareUI];
//    [self addTapGesture];
    [self prepareSearchTextField];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareSearchTextField
{
    self.searchTextField.delegate = self;
    self.searchTextField.autoCompleteDataSource = self;
    self.searchTextField.autoCompleteDelegate = self;
    self.searchTextField.backgroundColor = [UIColor whiteColor];
    [self.searchTextField registerAutoCompleteCellClass:[DEMOCustomAutoCompleteCell class]
                                       forCellReuseIdentifier:@"CustomCellId"];
    self.searchTextField.maximumNumberOfAutoCompleteRows = 3;
    self.searchTextField.applyBoldEffectToAutoCompleteSuggestions = YES;
    self.searchTextField.showAutoCompleteTableWhenEditingBegins = YES;
    self.searchTextField.disableAutoCompleteTableUserInteractionWhileFetching = YES;
    [self.searchTextField setAutoCompleteRegularFontName:@"SFUIText-Regular"];
    
    // searchcontainer constraint
    self.searchContainerView.userInteractionEnabled = YES;
    self.searchContainerConstraint.constant = 44;
    
    // add search icon to the left view
    self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* searchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search_black"]];
    self.searchTextField.leftView = searchImageView;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [DataManager sharedManager].isFirstLoading = @"YES";
        [self.searchTextField becomeFirstResponder];
        [DataManager sharedManager].isFirstLoading = @"NO";
    });
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden =  YES;
    
    if (self.refreshControl.isRefreshing) {
        // fix for freezing refresh control after tab bar switch
        // if it is still active
        CGPoint offset = self.tableView.contentOffset;
        [self.refreshControl endRefreshing];
        [self.refreshControl beginRefreshing];
        self.tableView.contentOffset = offset;
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.view endEditing:YES];
}

- (void) prepareUI
{
    isDenningUser = [[DataManager sharedManager].user.userType isEqualToString:@"denning"];
    _email = [DataManager sharedManager].user.email;
    _sessionID = [DataManager sharedManager].user.sessionID;
    CGFloat customRefreshControlHeight = 50.0f;
    CGFloat customRefreshControlWidth = 320.0f;
    CGRect customRefreshControlFrame = CGRectMake(0.0f,
                                                  -customRefreshControlHeight,
                                                  customRefreshControlWidth,
                                                  customRefreshControlHeight);
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:customRefreshControlFrame];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor blackColor];
    
    [self.tableView addSubview:self.refreshControl];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"EBEBF1"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
//    self.tableView.refreshControl = [[UIRefreshControl alloc] init];
//    self.tableView.refreshControl.backgroundColor = [UIColor clearColor];
//    self.tableView.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                            action:@selector(displaySearchResult)
                  forControlEvents:UIControlEventValueChanged];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    
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
    
    self.selectionList.selectionIndicatorColor = [UIColor colorWithHexString:@"FF3B2F"];
    [self.selectionList setTitleColor:[UIColor colorWithHexString:@"FF3B2F"] forState:UIControlStateHighlighted];
    [self.selectionList setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.selectionList setTitleFont:[UIFont fontWithName:@"SFUIText-Regular" size:17] forState:UIControlStateNormal];
    [self.selectionList setTitleFont:[UIFont fontWithName:@"SFUIText-SemiBold" size:17]  forState:UIControlStateSelected];
    [self.selectionList setTitleFont:[UIFont fontWithName:@"SFUIText-SemiBold" size:17] forState:UIControlStateHighlighted];
    
    [self.view addSubview:self.selectionList];
    self.selectionList.backgroundColor = [UIColor clearColor];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self buildSearchKeywordURL];
        [self.selectionList reloadData];
    });
    
    // close the search after click logo on the top right
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissView:) name:@"CloseSearch" object:nil];
}

- (void) buildSearchURL
{
    if (isDenningUser){
        searchURL = [[DataManager sharedManager].user.serverAPI stringByAppendingString: GENERAL_SEARCH_URL];
    } else {
        searchURL = PUBLIC_SEARCH_URL;
    }
}

- (void) buildSearchKeywordURL
{
    if (isDenningUser){
        searchKeywordURL = [[DataManager sharedManager].user.serverAPI stringByAppendingString: GENERAL_KEYWORD_SEARCH_URL];
        category = 0;
        self.searchTextField.placeholder = @"General Search";
    } else {
        category = -1;
        searchKeywordURL = PUBLIC_KEYWORD_SEARCH_URL;
        self.searchTextField.placeholder = @"Denning Search";
    }
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
    self.selectionList.hidden = NO;
    [self.selectionList reloadData];
    self.selectionList.selectedButtonIndex = 0;
}

- (void) updateUI
{
    [self updateSelectionList];
    [self.searchResultArray removeAllObjects];
    [self.tableView reloadData];
    self.searchTextField.text = @"";
    self.selectionList.hidden = NO;
}

- (IBAction)toggleSearchType:(UIButton*)sender {
    if (!isDenningUser) {
        return;
    }
    
    if (isDenningUser){
        self.searchTextField.placeholder = @"Denning Search";
        category = -1;
       searchKeywordURL = PUBLIC_KEYWORD_SEARCH_URL;
    } else {
        self.searchTextField.placeholder = @"General Search";
        category = 0;
         searchKeywordURL = [[DataManager sharedManager].user.serverAPI stringByAppendingString: GENERAL_KEYWORD_SEARCH_URL];
    }
    
   [self updateUI];
}

- (IBAction)tapLogoBtn:(id)sender {
    [self dismissView:sender];
}

- (void) displaySearchResult
{
//    self.selectionList.hidden = NO;
    [self.selectionList reloadData];
    self.selectionList.selectedButtonIndex = selectedIndexOfFilter;
    
    @weakify(self)
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [[QMNetworkManager sharedManager] getGlobalSearchFromKeyword:keyword searchURL:searchURL forCategory:category searchType:searchType withPage:@(1) withCompletion:^(NSArray * _Nonnull resultArray, NSError* _Nonnull error) {
        
        [SVProgressHUD dismiss];
        
        if (self.refreshControl.isRefreshing) {
            CGPoint offset = self.tableView.contentOffset;
            self.refreshControl.attributedTitle = [DIHelpers getLastRefreshingTime];
            [self.refreshControl endRefreshing];
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
    gotoMatter = @"Matter";
    [self performSearchCellSelect:model];
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

- (void) didTapFileNote:(SearchMatterCell *)cell
{
    [self performSegueWithIdentifier:kFileNoteListSegue sender:self.searchResultArray[cell.tag]];
}

- (void) didTapUpload:(SearchMatterCell *)cell
{
    [self performSegueWithIdentifier:kFileUploadSegue sender:nil];
}

- (void) didTapPaymentRecord: (SearchMatterCell*) cell fileNo:(NSString *)fileNo
{
    [self performSegueWithIdentifier:kPaymentSegue sender:fileNo];
}

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    if (isDenningUser){
        return self.generalSearchFilters.count;
    }
    return self.publicSearchFilters.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    if (isDenningUser){
        return generalKeyArray[index];
    }
    return self.publicSearchFilters.allKeys[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    // update the view for the corresponding index
    selectedIndexOfFilter = index;
    if (isDenningUser){
        category = [generalValueArray[index] integerValue];
        
    } else {
        category = [self.publicSearchFilters.allValues[index] integerValue];
    }
    
    [self buildSearchURL];
    
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
    [self buildSearchURL];
    
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
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultModel* model = self.searchResultArray[indexPath.section];
    NSUInteger cellType = [self detectItemType:model.form];

    if (cellType == 0 || cellType == DIContactCell || cellType == DIBankCell || cellType == DIGovernmentPTGOfficesCell || cellType == DIGovernmentLandOfficesCell || cellType == DILegalFirmCell || cellType == DIPropertyCell) {
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
    [[QMNetworkManager sharedManager] loadLedgerWithCode:model.key completion:^(NewLedgerModel * _Nonnull newLedgerModel, NSError * _Nonnull error) {
        
        @strongify(self);
        self->isLoading = false;
        [SVProgressHUD dismiss];
        if (error == nil) {
            [self performSegueWithIdentifier:kLedgerSearchSegue sender:newLedgerModel];
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

- (void) openContact: (SearchResultModel*) model
{
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
}

- (void) openProperty: (SearchResultModel*) model
{
    [SVProgressHUD showWithStatus:@"Loading"];
    @weakify(self);
    [[QMNetworkManager sharedManager] loadPropertyfromSearchWithCode:model.key completion:^(AddPropertyModel * _Nonnull propertyModel, NSError * _Nonnull error) {
        
        @strongify(self);
        self->isLoading = false;
        [SVProgressHUD dismiss];
        if (error == nil) {
            [self performSegueWithIdentifier:kAddPropertySegue sender:propertyModel];
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

- (void) openBank: (SearchResultModel*) model
{
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
}

- (void) openGovLandOffices: (SearchResultModel*) model
{
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
}

- (void) openGovPTGOffices: (SearchResultModel*) model
{
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
}

- (void) openLegalFirm: (SearchResultModel*) model
{
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
}

- (void) performSearchCellSelect: (SearchResultModel*) model
{
    if (isLoading) return;
    isLoading = YES;
    NSUInteger cellType = [self detectItemType:model.form];
    if (cellType == DIContactCell){ // Contact
        [self openContact:model];
    } else if (cellType  == DIRelatedMatterCell){ // Related Matter
        [self openRelatedMatter:model];
    } else if (cellType  == DIPropertyCell){ // Property
        [self openProperty:model];
    } else if (cellType  == DIBankCell){ // Bank
        [self openBank:model];
    } else if (cellType  == DIGovernmentLandOfficesCell){ // Government offices
        [self openGovLandOffices:model];
    } else if (cellType  == DIGovernmentPTGOfficesCell){ // PTG offices
        [self openGovPTGOffices:model];
    } else if (cellType  == DILegalFirmCell){ // Legal firm
        [self openLegalFirm:model];
    } else if (cellType  == DIDocumentCell) // Document
    {
        [self openDocument:model];
    }
}

- (void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SearchResultModel* model = self.searchResultArray[indexPath.section];
    gotoMatter = @"";
    [self performSearchCellSelect:model];
}


#pragma mark - MLPAutoCompleteTextField DataSource

- (NSArray*) parseResponse: (id) response
{
    NSMutableArray* keywords = [NSMutableArray new];
    for (id obj in response) {
        [keywords addObject:[obj objectForKey:@"keyword"]];
    }
    
    return keywords;
}

//example of asynchronous fetch:
- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    if ([NSOperationQueue mainQueue].operationCount > 0) {
        [[NSOperationQueue mainQueue] cancelAllOperations];
    }
    
    if (isDenningUser){
        [[QMNetworkManager sharedManager].manager.requestSerializer setValue:_sessionID forHTTPHeaderField:@"webuser-sessionid"];
        [[QMNetworkManager sharedManager].manager.requestSerializer setValue:_email forHTTPHeaderField:@"webuser-id"];
        
    } else {
        [[QMNetworkManager sharedManager].manager.requestSerializer setValue:@"{334E910C-CC68-4784-9047-0F23D37C9CF9}" forHTTPHeaderField:@"webuser-sessionid"];
        [[QMNetworkManager sharedManager].manager.requestSerializer setValue:_email forHTTPHeaderField:@"webuser-id"];
        
    }
    
    NSString* url = [searchKeywordURL stringByAppendingString:[string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    NSOperation *operation = [AFHTTPSessionOperation operationWithManager:[QMNetworkManager sharedManager].manager
                                                               HTTPMethod:@"GET"
                                                                URLString:url
                                                               parameters:nil
                                                           uploadProgress:nil
                                                         downloadProgress:nil
                                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                                                      NSLog(@"%@", responseObject);
                                                                      
                                                                      handler([self parseResponse:responseObject]);                     } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                                          NSLog(@"%@", error);
                                                                      }];
    [[NSOperationQueue mainQueue] addOperation:operation];
    
}

#pragma mark - MLPAutoCompleteTextField Delegate

- (BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    cell.textLabel.text = autocompleteString;
    return YES;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectedObject){
        NSLog(@"selected object from autocomplete menu %@ with string %@", selectedObject, [selectedObject autocompleteString]);
    } else {
        [self buildSearchURL];
        
        searchType = @"Normal";
        keyword = selectedString;
        [self displaySearchResult];
    }
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField willHideAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view will be removed from the view hierarchy");
    // searchcontainer constraint
    self.searchContainerConstraint.constant = 44 ;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField willShowAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view will be added to the view hierarchy");
    self.selectionList.hidden = YES;
    // searchcontainer constraint
    self.searchContainerConstraint.constant = 165;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField didHideAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view ws removed from the view hierarchy");
   // [self.searchTextField resignFirstResponder];
    self.selectionList.hidden = NO;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField didShowAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view was added to the view hierarchy");
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kContactSearchSegue]){
        UINavigationController* navVC = segue.destinationViewController;
        ContactViewController* contactVC = navVC.viewControllers.firstObject;
        contactVC.contactModel = sender;
        contactVC.gotoRelatedMatter = gotoMatter;
    }
    
    if ([segue.identifier isEqualToString:kRelatedMatterSegue]){
        UINavigationController* navC = segue.destinationViewController;
        RelatedMatterViewController* relatedMatterVC = [navC viewControllers].firstObject;
        relatedMatterVC.relatedMatterModel = sender;
    }
    
    if ([segue.identifier isEqualToString:kAddPropertySegue]){
        UINavigationController* navC = segue.destinationViewController;
        AddPropertyViewController* propertyVC = [navC viewControllers].firstObject;
        propertyVC.propertyModel = sender;
        propertyVC.viewType = @"view";
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
        LedgerViewController* ledgerVC = [navC viewControllers].firstObject;
        ledgerVC.ledgerModel = sender;

        ledgerVC.matterCode = _matterCode;
    }
    
    if ([segue.identifier isEqualToString:kDocumentSearchSegue]){
        UINavigationController* navC = segue.destinationViewController;
        DocumentViewController* documentVC = navC.viewControllers.firstObject;
        documentVC.documentModel = sender;
    }
    
    if ([segue.identifier isEqualToString:kBankSearchSegue]){
        UINavigationController* navC = segue.destinationViewController;
        BankViewController* bankVC = navC.viewControllers.firstObject;
        bankVC.bankModel = sender;
    }
    
    if ([segue.identifier isEqualToString:kFileNoteListSegue]){
        FileNoteList* vc = segue.destinationViewController;
        vc.resultModel = sender;
    }
    
    if ([segue.identifier isEqualToString:kPaymentSegue]){
        UINavigationController* navC = segue.destinationViewController;
        PaymentRecord* vc = navC.viewControllers.firstObject;
        vc.fileNo = sender;
    }
}

@end
