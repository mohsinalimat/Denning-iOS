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
#import "UITextField+LeftView.h"
#import "MenuCell.h"
#import "ChangeBranchViewController.h"

@interface HomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate,
    UITextFieldDelegate>
{
    BOOL hideCells;
    NSArray* homeIconArray;
    NSArray* homeLabelArray;
    __block BOOL isLoading;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *headerWrapper;
@property (weak, nonatomic) IBOutlet UILabel *firmName;
@property (weak, nonatomic) IBOutlet UILabel *firmCity;

@property (weak, nonatomic) IBOutlet UITextField_LeftView *searchTextField;
@property (strong, nonatomic) UISearchController *searchController;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [self displayBranchInfo];
}

- (void) changeTitle {
    UIImage *img = [UIImage imageNamed:@"denning_logo"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    [imgView setImage:img];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.tabBarController.navigationItem.titleView = imgView;
    
    self.navigationController.tabBarItem.image = [UIImage imageNamed:@"icon_home"];
    self.navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_home_selected"];
}

- (void) displayBranchInfo {
    self.firmName.text = [DataManager sharedManager].user.firmName;
    self.firmCity.text = [DataManager sharedManager].user.firmCity;
}

- (void) prepareUI
{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
   
    homeIconArray = @[@"icon_news", @"icon_updates", @"icon_market", @"icon_delivery", @"icon_calculator", @"icon_shared", @"icon_forum", @"icon_products", @"icon_attendance", @"icon_upload", @"icon_calendar", @"icon_topup"];
    homeLabelArray = @[@"News", @"Updates", @"Market", @"Delivery", @"Calculators", @"Shared", @"Forum", @"Products", @"Attendance", @"Upload", @"Calendar", @"Top-Up"];
    
    self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* searchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search_gray"]];
    self.searchTextField.leftView = searchImageView;
    
    UITapGestureRecognizer *branchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBranch:)];
    branchTap.numberOfTapsRequired = 1;
    [self.headerWrapper addGestureRecognizer:branchTap];
}

- (IBAction)changeBranch:(id)sender {
    if ([DataManager sharedManager].user.userType.length == 0) {
        [QMAlert showAlertWithMessage:@"You cannot access this folder. please subscribe dening user" actionSuccess:NO inViewController:self];
        return;
    }
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"QM_STR_LOADING", nil)];

    [[QMNetworkManager sharedManager] userSignInWithEmail:[DataManager sharedManager].user.email password:[DataManager sharedManager].user.password withCompletion:^(BOOL success, NSString * _Nonnull error, NSInteger statusCode, NSDictionary* responseObject) {
        [SVProgressHUD dismiss];
        if (success){
           [[DataManager sharedManager] setUserInfoFromLogin:responseObject];
            if ([[DataManager sharedManager].user.userType isEqualToString:@"denning"]) {
                [DataManager sharedManager].seletedUserType = @"Denning";
                 [self performSegueWithIdentifier:kChangeBranchSegue sender:[DataManager sharedManager].denningArray];
            } else if ([DataManager sharedManager].personalArray.count > 0) {
                [DataManager sharedManager].seletedUserType = @"Personal";
                [self performSegueWithIdentifier:kChangeBranchSegue sender:[DataManager sharedManager].personalArray];
            } else {
                [QMAlert showAlertWithMessage:@"No more branches" actionSuccess:NO inViewController:self];
            }
        }
    }];
}

#pragma mark - search

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self performSegueWithIdentifier:kMainSearchSegue sender:nil];
    return NO;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    [self performSegueWithIdentifier:kMainSearchSegue sender:nil];
    return NO;
}

#pragma mark -
#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return homeIconArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MenuCell" forIndexPath:indexPath];
    
    cell.centerLabel.text = homeLabelArray[[indexPath row]];
    cell.centerImageView.image = [UIImage imageNamed:homeIconArray[[indexPath row]]];;
    
    return cell;
}

#pragma mark -
#pragma mark UICollectionViewFlowLayoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = self.collectionView.frame.size.width/4-2;
    return CGSizeMake(width, width);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(1, 0, 1, 1);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

#pragma mark -
#pragma mark UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    if (indexPath.row == 0) {
        [self getLatestNewsWithCompletion:^(NSArray *array) {
            [self performSegueWithIdentifier:kNewsSegue sender:array];
        }];
    } else if (indexPath.row == 1) {
        [self getLatestUpdatesWithCompletion:^(NSArray *array) {
            [self performSegueWithIdentifier:kUpdateSegue sender:array];
        }];
    } else if (indexPath.row == 4) {
        [self performSegueWithIdentifier:kCalculateSegue sender:nil];
    } else if (indexPath.row == 5) {
        [self getSharedFoldersWithCompletion:nil];
    } else if (indexPath.row == 10) {
        if (![[DataManager sharedManager].user.userType isEqualToString:@""]) {
            [self geteventsArrayWithCompletion:^(NSArray * array) {
                [self performSegueWithIdentifier:kEventSegue sender:array];
            }];
        } else {
            [QMAlert showAlertWithMessage:@"You cannot access this folder. please subscribe dening user" actionSuccess:NO inViewController:self];
        }
        
    }
    cell.backgroundColor = [UIColor whiteColor];
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
    [[DataManager sharedManager] setServerAPI:firmURLModel.firmServerURL withFirmName:firmURLModel.name withFirmCity:firmURLModel.city];
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
    [SVProgressHUD showWithStatus:@"Loading"];
    @weakify(self);
    [[QMNetworkManager sharedManager] getLatestUpdatesWithCompletion:^(NSArray * _Nonnull updatesArray, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
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
    [SVProgressHUD showWithStatus:@"Loading"];
    @weakify(self)
    [[QMNetworkManager sharedManager] getLatestNewsWithCompletion:^(NSArray * _Nonnull newsArray, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
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
    [SVProgressHUD showWithStatus:@"Loading"];
    @weakify(self)
    [[QMNetworkManager sharedManager] getLatestEventWithStartDate:[DIHelpers today] endDate:[DIHelpers today] filter:@"0All" withCompletion:^(NSArray * _Nonnull eventsArray, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
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
        UINavigationController* navVC = segue.destinationViewController;
        BranchViewController *branchVC = navVC.viewControllers.firstObject;
        branchVC.firmArray = sender;
    }
    
    if ([segue.identifier isEqualToString:kChangeBranchSegue]){
        ChangeBranchViewController* changeBranchVC = segue.destinationViewController;
        changeBranchVC.branchArray = sender;
    }
}


@end
