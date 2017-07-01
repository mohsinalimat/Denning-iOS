//
//  PropertyViewController.m
//  Denning
//
//  Created by DenningIT on 09/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "PropertyViewController.h"
#import "ContactCell.h"
#import "SearchResultCell.h"
#import "CommonTextCell.h"
#import "RelatedMatterViewController.h"
#import "SearchLastCell.h"

@interface PropertyViewController()
{
    __block BOOL isLoading;
}

@end
@implementation PropertyViewController

- (void) dealloc
{
    NSLog(@"dealloc PropertyViewController");
}

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
    UIFont *font = [UIFont fontWithName:@"SFUIText-Regular" size:17.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGFloat width = [[[NSAttributedString alloc] initWithString:self.previousScreen attributes:attributes] size].width;
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
    
    [ContactCell registerForReuseInTableView:self.tableView];
    [CommonTextCell registerForReuseInTableView:self.tableView];
    [SearchLastCell registerForReuseInTableView:self.tableView];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    
    return self.propertyModel.relatedMatter.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        if (isLoading) return;
        isLoading = YES;
        SearchResultModel* model = self.propertyModel.relatedMatter[indexPath.row];
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"";
            break;
        case 1:
            sectionName = @"Related matter";
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactCell *contactCell = [tableView dequeueReusableCellWithIdentifier:[ContactCell cellIdentifier] forIndexPath:indexPath];
    
    if (indexPath.section == 0){
        
        if (indexPath.row == 0){
            [contactCell configureCellWithContact:self.propertyModel.lotptType text:self.propertyModel.lotptValue];
        } else if (indexPath.row == 1){
            [contactCell configureCellWithContact:@"Description" text:self.propertyModel.fullTitle];
        } else if (indexPath.row == 2){
            [contactCell configureCellWithContact:@"Address" text:self.propertyModel.address];
        }
        
        return contactCell;
    }
    else {
        SearchResultModel *matterModel = self.propertyModel.relatedMatter[indexPath.row];
        NSArray* matter = [DIHelpers removeFileNoAndSeparateFromMatterTitle: matterModel.title];
        SearchLastCell *cell = [tableView dequeueReusableCellWithIdentifier:[SearchLastCell cellIdentifier] forIndexPath:indexPath];
        
        cell.topLabel.text = matter[0];
        cell.bottomLabel.text = matter[1];
        cell.rightLabel.text = [DIHelpers getDateInShortForm:matterModel.sortDate];
        
        return contactCell;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kRelatedMatterSegue]){
        RelatedMatterViewController* relatedMatterVC = segue.destinationViewController;
        relatedMatterVC.relatedMatterModel = sender;
        relatedMatterVC.previousScreen = @"Property";
    }
}


@end
