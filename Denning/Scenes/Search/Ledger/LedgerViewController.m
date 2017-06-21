//
//  LedgerViewController.m
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "LedgerViewController.h"
#import "NewLedgerViewController.h"
#import "LedgerCell.h"
#import "ContactHeaderCell.h"

@interface LedgerViewController ()
{
    __block BOOL isLoading;
    __block NSString* selectedAccountType;
}

@end

@implementation LedgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerNibs];
    if (self.previousScreen.length != 0) {
        [self prepareUI];
    }
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

- (void) prepareUI {
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
    
    [backButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
//    [backButton setTitle:self.previousScreen forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popupScreen:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [self.navigationItem setLeftBarButtonItems:@[backButtonItem] animated:YES];
}


- (void) popupScreen:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerNibs {
    [LedgerCell registerForReuseInTableView:self.tableView];
    [ContactHeaderCell registerForReuseInTableView:self.tableView];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return self.ledgerModel.ledgerModelArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        LedgerModel* model = self.ledgerModel.ledgerModelArray[indexPath.row];
        [self performSegueWithIdentifier:kLedgerDetailSearchSegue sender:model.accountName];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Matter";
    }
    return @"Ledgers";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ContactHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[ContactHeaderCell cellIdentifier] forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell configureCellWithContact:self.ledgerModel.fileNo];
        } else {
            [cell configureCellWithContact:self.ledgerModel.fileName];
        }
        return cell;
    }
    
    LedgerCell *cell = [tableView dequeueReusableCellWithIdentifier:[LedgerCell cellIdentifier] forIndexPath:indexPath];
    
    [cell configureCellWithLedger:self.ledgerModel.ledgerModelArray[indexPath.row]];

    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kLedgerDetailSearchSegue]){
        NewLedgerViewController* ledgerDetailVC = segue.destinationViewController;
        ledgerDetailVC.ledgerModelNew = self.ledgerModel;
        ledgerDetailVC.selectedAccountName = sender;
    }
}

@end
