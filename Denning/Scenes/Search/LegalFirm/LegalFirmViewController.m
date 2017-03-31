//
//  LegalFirmViewController.m
//  Denning
//
//  Created by DenningIT on 13/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "LegalFirmViewController.h"
#import "CommonTextCell.h"
#import "ContactCell.h"
#import "RelatedMatterViewController.h"

@interface LegalFirmViewController ()
{
    __block BOOL isLoading;
}
@end

@implementation LegalFirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerNibs];
    if (self.previousScreen.length != 0) {
        [self prepareUI];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) prepareUI {
    UIFont *font = [UIFont fontWithName:@"SFUIText-Regular" size:17.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGFloat width = [[[NSAttributedString alloc] initWithString:self.previousScreen attributes:attributes] size].width;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width+15, 23)];
    
    [backButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [backButton setTitle:self.previousScreen forState:UIControlStateNormal];
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
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 6;
    }
    
    return self.legalFirmModel.relatedMatter.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        if (isLoading) return;
        isLoading = YES;
        SearchResultModel* model = self.legalFirmModel.relatedMatter[indexPath.row];
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
            sectionName = @"Main Information";
            break;
        case 2:
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
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:[ContactCell cellIdentifier] forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell configureCellWithContact:self.legalFirmModel.name text:@""];
        } else {
            [cell configureCellWithContact:self.legalFirmModel.IDNo text:@""];
        }
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [cell configureCellWithContact:@"Telephone" text:self.legalFirmModel.tel];
        } else if (indexPath.row == 1) {
            [cell configureCellWithContact:@"mobile" text:self.legalFirmModel.mobile];
        } else if (indexPath.row == 2) {
            [cell configureCellWithContact:@"office" text:self.legalFirmModel.office];
        } else if (indexPath.row == 3) {
            [cell configureCellWithContact:@"email" text:self.legalFirmModel.email];
        } else if (indexPath.row == 4) {
            [cell configureCellWithContact:@"address" text:self.legalFirmModel.address];
        }
        return cell;
    } else {
        CommonTextCell *commonCell = [tableView dequeueReusableCellWithIdentifier:[CommonTextCell cellIdentifier] forIndexPath:indexPath];
        
        SearchResultModel *matterModel = self.self.legalFirmModel.relatedMatter[indexPath.row];
        [commonCell configureCellWithValue:matterModel.key];
        commonCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return commonCell;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kRelatedMatterSegue]){
        RelatedMatterViewController* relatedMatterVC = segue.destinationViewController;
        relatedMatterVC.relatedMatterModel = sender;
        relatedMatterVC.previousScreen = @"Legal Firm";
    }
}


@end
