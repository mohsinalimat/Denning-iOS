//
//  HomeViewController.m
//  Denning
//
//  Created by DenningIT on 01/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsCell.h"
#import "EventCell.h"
#import "CalculatorSelectionViewController.h"
#import "EventViewController.h"
#import "NewsViewController.h"
#import "UpdateViewController.h"
#import "BranchViewController.h"
#import "DenningLabelCell.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    BOOL hideCells;
    NSArray* homeIconArray;
    NSArray* homeLabelArray;
    __block BOOL isLoading;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerWrapper;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) UISearchController *searchController;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerNibs];
    [self configureSearch];
    [self prepareUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changeTitle];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [_headerWrapper setNeedsLayout];
    [_headerWrapper layoutIfNeeded];
//    CGFloat height = [_headerWrapper systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGFloat parentHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat tabbarHeight = self.tabBarController.tabBar.frame.size.height;
    CGFloat navbarHeight = 64;
    
    CGRect headerFrame = _headerWrapper.frame;
    headerFrame.size.height =  parentHeight - 300 - tabbarHeight - navbarHeight;
    _headerWrapper.frame = headerFrame;
    _tableView.tableHeaderView = _headerWrapper;
}

- (void) changeTitle {
    UIImage *img = [UIImage imageNamed:@"logo_label"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    [imgView setImage:img];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.tabBarController.navigationItem.titleView = imgView;
    
    self.navigationController.tabBarItem.image = [UIImage imageNamed:@"icon_home"];
    self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_home"];
}

- (void) configureSearch
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.placeholder = NSLocalizedString(@"Denning Search", nil);
    self.searchController.searchBar.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit]; // iOS8 searchbar sizing
    [self.searchController.searchBar setBarTintColor:[UIColor colorWithHexString:@"0f1828"]];
    [self.tableView.tableHeaderView addSubview: self.searchController.searchBar];
}

- (void) prepareUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_background.png"]];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    homeIconArray = @[@"icon_news", @"icon_updates",  @"icon_calculator", @"icon_share", @"icon_calendar"];
    homeLabelArray = @[@"News", @"Updates", @"Calculators", @"Shared", @"Calendar"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    NSDate* date = [[NSDate alloc] init];
    self.dateLabel.text = [dateFormatter stringFromDate:date];
    self.dayLabel.text = @"";
}

- (void)registerNibs {
    [DenningLabelCell registerForReuseInTableView:self.tableView];
}

#pragma mark - search

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self performSegueWithIdentifier:kMainSearchSegue sender:nil];
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (hideCells) {
        return 1;
    }
    return homeLabelArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < homeIconArray.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
        UIImageView* homeImageView = [cell viewWithTag:1];
        UILabel *homeLabel = [cell viewWithTag:0];

        homeImageView.image = [UIImage imageNamed:homeIconArray[indexPath.row]];
        homeLabel.text = homeLabelArray[indexPath.row];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    } else {
        DenningLabelCell* denningCell = [tableView dequeueReusableCellWithIdentifier:[DenningLabelCell cellIdentifier] forIndexPath:indexPath];
        [denningCell configureCellWithText:[DataManager sharedManager].user.firmName];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        denningCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return denningCell;
    }
    return nil;
}

- (void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (hideCells) {
        [self performSegueWithIdentifier:kCalculateSegue sender:nil];
    } else {
        if (indexPath.row == 0) {
            [self getLatestNewsWithCompletion:^(NSArray *array) {
                [self performSegueWithIdentifier:kNewsSegue sender:array];
            }];
        } else if (indexPath.row == 1) {
            [self getLatestUpdatesWithCompletion:^(NSArray *array) {
                [self performSegueWithIdentifier:kUpdateSegue sender:array];
            }];
        } else if (indexPath.row == 2) {
            [self performSegueWithIdentifier:kCalculateSegue sender:nil];
        } else if (indexPath.row == 3) {
            [self getSharedFoldersWithCompletion:nil];
        } else if (indexPath.row == 4) {
            [self geteventsArrayWithCompletion:^(NSArray * array) {
                [self performSegueWithIdentifier:kEventSegue sender:array];
            }];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) getSharedFoldersWithCompletion: (void (^)(NSArray* array))completion
{
    if (isLoading) return;
    isLoading = YES;
    if ([DataManager sharedManager].user.password.length == 0) {
        // go to login
        [self performSegueWithIdentifier:kAuthSegue sender:nil];
    } else if (![[DataManager sharedManager].user.userType isEqualToString:@""]) {
        // denning or personal user can access the shared folder
        [DataManager sharedManager].documentView = @"shared";
        [SVProgressHUD showWithStatus:NSLocalizedString(@"QM_STR_LOADING", nil)];
        @weakify(self);
        [[QMNetworkManager sharedManager] userSignInWithEmail:[DataManager sharedManager].user.email password:[DataManager sharedManager].user.password withCompletion:^(BOOL success, NSString * _Nonnull error, NSInteger statusCode, NSDictionary* responseObject) {
            
            @strongify(self)
            self->isLoading = NO;
            [SVProgressHUD dismiss];
            if (success){
                [self manageSuccessResult:statusCode response:responseObject];
            } else {
                [self manageErrorResult:statusCode error:error];
            }
        }];
    } else {
        // Public user cannot access the shared folder
        [QMAlert showAlertWithMessage:@"You cannot access this folder. please subscribe dening user" actionSuccess:NO inViewController:self];
        self->isLoading = NO;
        return;
    }
}

- (void) registerURLAndGotoMain: (FirmURLModel*) firmURLModel {
    [[DataManager sharedManager] setServerAPI:firmURLModel.firmServerURL withFirmName:firmURLModel.name];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:kQMSceneSegueMain sender:nil];
    });
}

- (void) manageUserType {
    if ([DataManager sharedManager].personalArray.count > 0) {
        [DataManager sharedManager].seletedUserType = @"Personal";
        [self performSegueWithIdentifier:kBranchSegue sender:[DataManager sharedManager].personalArray];
    } else {
        [DataManager sharedManager].seletedUserType = @"Public";
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self performSegueWithIdentifier:kQMSceneSegueMain sender:nil];
//        });
        [QMAlert showAlertWithMessage:@"Sorry, There is no shared document for you" actionSuccess:NO inViewController:self];
    }
}

- (void) manageSuccessResult: (NSInteger) statusCode response:(NSDictionary*) response {
    [[DataManager sharedManager] setUserInfoFromLogin:response];
    if (statusCode == 250) {
        [DataManager sharedManager].statusCode = [NSNumber numberWithInteger:statusCode];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:kNewDeviceSegue sender:nil];
        });
    } else if (statusCode == 280) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:kChangePasswordSegue sender:nil];
        });
    } else {
        [self manageUserType];
    }
}

- (void) manageErrorResult: (NSInteger) statusCode error: (NSString*) error {
    if (statusCode == 401) {
        int value = [[QMNetworkManager sharedManager].invalidTry intValue];
        [QMNetworkManager sharedManager].invalidTry = [NSNumber numberWithInt:value+1];
        
        if (value >= 10){
            error = @"Locked for 1 minutes. invalid username and password more than 10 times...";
            [QMNetworkManager sharedManager].startTrackTimeForLogin = [[NSDate alloc] init];
        }
    }
    [QMAlert showAlertWithMessage:error actionSuccess:NO inViewController:self];
}

- (void) getLatestUpdatesWithCompletion: (void (^)(NSArray* array))completion
{
    if (isLoading) return;
    isLoading = YES;
    @weakify(self);
    [[QMNetworkManager sharedManager] getLatestUpdatesWithCompletion:^(NSArray * _Nonnull updatesArray, NSError * _Nonnull error) {
        
        @strongify(self);
        self->isLoading = NO;
        if (error == nil) {
            if (completion != nil) {
                completion(updatesArray);
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

- (void) getLatestNewsWithCompletion: (void (^)(NSArray* array))completion
{
    if (isLoading) return;
    isLoading = YES;
    @weakify(self)
    [[QMNetworkManager sharedManager] getLatestNewsWithCompletion:^(NSArray * _Nonnull newsArray, NSError * _Nonnull error) {
        
        @strongify(self)
        self->isLoading = NO;
        if (error == nil) {
            if (completion != nil) {
                completion(newsArray);
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

- (void) geteventsArrayWithCompletion: (void (^)(NSArray* array))completion
{
    if (isLoading) return;
    isLoading = YES;
    @weakify(self)
    [[QMNetworkManager sharedManager] getLatestEventWithCompletion:^(NSArray * _Nonnull eventsArray, NSError * _Nonnull error) {
        
        @strongify(self)
        self->isLoading = NO;
        if (error == nil) {
            if (completion != nil) {
                completion(eventsArray);
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([segue.identifier isEqualToString:kEventSegue]) {
        UINavigationController* navVC = segue.destinationViewController;
        EventViewController* eventVC = navVC.viewControllers.firstObject;
        eventVC.originalArray = sender;
    }
    
    if ([segue.identifier isEqualToString:kNewsSegue]) {
        UINavigationController* navVC = segue.destinationViewController;
        NewsViewController* newsVC = navVC.viewControllers.firstObject;
        newsVC.newsArray = sender;
    }
    
    if ([segue.identifier isEqualToString:kUpdateSegue]) {
        UINavigationController* navVC = segue.destinationViewController;
        UpdateViewController* updatesVC = navVC.viewControllers.firstObject;
        updatesVC.updatesArray = sender;
    }
    
    if ([segue.identifier isEqualToString:kBranchSegue]){
        BranchViewController *branchVC = segue.destinationViewController;
        branchVC.firmArray = sender;
    }
}


@end
