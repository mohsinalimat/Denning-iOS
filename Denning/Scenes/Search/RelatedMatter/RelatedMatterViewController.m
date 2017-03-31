//
//  RelatedMatterViewController.m
//  Denning
//
//  Created by DenningIT on 08/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "RelatedMatterViewController.h"
#import "ContactCell.h"
#import "ContactHeaderCell.h"
#import "ThreeFieldsCell.h"
#import "PropertyViewController.h"
#import "LedgerViewController.h"
#import "BankViewController.h"
#import "ContactViewController.h"
#import "LegalFirmViewController.h"
#import "DocumentViewController.h"

@interface RelatedMatterViewController ()
{
    __block BOOL isLoading;
}

@end

@implementation RelatedMatterViewController
@synthesize relatedMatterModel;

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
    [ThreeFieldsCell registerForReuseInTableView:self.tableView];
    [ContactHeaderCell registerForReuseInTableView:self.tableView];
    [ContactCell registerForReuseInTableView:self.tableView];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT/2;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 11;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            if (relatedMatterModel.court == nil) {
                return 0;
            }
            return 5;
            break;
        case 3:
            return relatedMatterModel.partyGroupArray.count;
            break;
        case 4:
            return relatedMatterModel.solicitorGroupArray.count;
            break;
        case 5:
            return relatedMatterModel.propertyGroupArray.count;
            break;
        case 6:
            return relatedMatterModel.bankGroupArray.count;
            break;
        case 7:
            return relatedMatterModel.RMGroupArray.count;
            break;
        case 8:
            return relatedMatterModel.dateGroupArray.count;
            break;
        case 9:
            return relatedMatterModel.textGroupArray.count;
            break;
        case 10: // File Folder & Ledger
            return 2;
            break;
            
        default:
            return 0;
            break;
    }
    return 0;
}

- (void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) { // Contact client
        if (isLoading) return;
        isLoading = YES;
        [SVProgressHUD showWithStatus:@"Loading"];
        @weakify(self);
        [[QMNetworkManager sharedManager] loadContactFromSearchWithCode:relatedMatterModel.contactCode completion:^(ContactModel * _Nonnull contactModel, NSError * _Nonnull error) {
            
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
    
    if (indexPath.section == 4) { // Solicitor, Legal Firm
        if (isLoading) return;
        isLoading = YES;
        SolicitorGroup* solicitorGroup = self.relatedMatterModel.solicitorGroupArray[indexPath.row];
        [SVProgressHUD showWithStatus:@"Loading"];
        @weakify(self);
        [[QMNetworkManager sharedManager] loadLegalFirmWithCode:solicitorGroup.solicitorCode completion:^(LegalFirmModel * _Nonnull legalFirmModel, NSError * _Nonnull error) {
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
    
    if (indexPath.section == 5) { // property
        if (isLoading) return;
        isLoading = YES;
        PropertyModel* model = self.relatedMatterModel.propertyGroupArray[indexPath.row];
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
    }
    if (indexPath.section == 6) { // Bank
        if (isLoading) return;
        isLoading = YES;
        BankGroupModel *bankGroupModel = self.relatedMatterModel.bankGroupArray[indexPath.row];
        if (bankGroupModel.bankCode.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"Couldn't get the detail"];
            
        } else {
            [SVProgressHUD showWithStatus:@"Loading"];
            @weakify(self);
            [[QMNetworkManager sharedManager] loadBankFromSearchWithCode:bankGroupModel.bankCode completion:^(BankModel * _Nonnull bankModel, NSError * _Nonnull error) {
                
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
    }
    
    if (indexPath.section == 10) { // File Folder & ledger
        if  (indexPath.row == 0){
            if (isLoading) return;
            isLoading = YES;
            [SVProgressHUD showWithStatus:@"Loading"];
            @weakify(self);
            [[QMNetworkManager sharedManager]loadDocumentWithCode:relatedMatterModel.systemNo completion:^(DocumentModel * _Nonnull documentModel, NSError * _Nonnull error) {
                @strongify(self);
                self->isLoading = false;
                [SVProgressHUD dismiss];
                if (error == nil) {
                    [self performSegueWithIdentifier:kDocumentSearchSegue sender:documentModel];
                } else {
                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                }
            }];
        } else if (indexPath.row == 1) {
            if (isLoading) return;
            isLoading = YES;
            [SVProgressHUD showWithStatus:@"Loading"];
            @weakify(self);
            [[QMNetworkManager sharedManager] loadLedgerWithCode:self.relatedMatterModel.systemNo completion:^(NSArray * _Nonnull ledgerModelArray, NSError * _Nonnull error) {
                
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
            sectionName = @"Matter Information";
            break;
        case 2:
            sectionName = @"Court Case Information";
            break;
        case 3:
            sectionName = @"Party Group";
            break;
        case 4:
            sectionName = @"Solicitor";
            break;
        case 5:
            sectionName = @"Property";
            break;
        case 6:
            sectionName = @"Bank";
            break;
        case 7:
            sectionName = @"Important RM";
            break;
        case 8:
            sectionName = @"Important Date";
            break;
        case 9:
            sectionName = @"Other Information";
            break;
        case 10:
            sectionName = @"Files & Ledger";
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

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:[ContactCell cellIdentifier] forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        ContactHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:[ContactHeaderCell cellIdentifier] forIndexPath:indexPath];
        [cell configureCellWithContact:relatedMatterModel.clientName];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if (indexPath.section == 1) { // Matter Information
        if (indexPath.row == 0) {
            [cell configureCellWithContact:@"Open Date" text:relatedMatterModel.openDate];
        } else if (indexPath.row == 1) {
            [cell configureCellWithContact:@"Ref" text:relatedMatterModel.ref];
        } else if (indexPath.row == 2) {
            [cell configureCellWithContact:@"Matter" text:relatedMatterModel.matter];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.section == 2) { // Court Case information
        if (indexPath.row == 0) {
            [cell configureCellWithContact:@"Court" text:relatedMatterModel.court.court];
        } else if (indexPath.row == 1) {
            [cell configureCellWithContact:@"Place" text:relatedMatterModel.court.place];
        } else if (indexPath.row == 2) {
            [cell configureCellWithContact:@"Case No" text: relatedMatterModel.court.caseNumber];
        } else if (indexPath.row == 3) {
            [cell configureCellWithContact:@"Judge" text:relatedMatterModel.court.judge];
        } else if (indexPath.row == 4) {
            [cell configureCellWithContact:@"SAR" text:relatedMatterModel.court.SAR];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    } else if (indexPath.section == 3) { // Party Group
        PartyGroupModel* partyGroup = relatedMatterModel.partyGroupArray[indexPath.row];
        [cell configureCellWithContact:partyGroup.partyGroupName text:partyGroup.party.partyName];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 4) { // Solicitor
         ThreeFieldsCell *cell = [tableView dequeueReusableCellWithIdentifier:[ThreeFieldsCell cellIdentifier] forIndexPath:indexPath];
        SolicitorGroup* solicitorGroup = relatedMatterModel.solicitorGroupArray[indexPath.row];
        [cell configureCellWithValue1:solicitorGroup.solicitorGroupName value2:solicitorGroup.solicitorName value3:solicitorGroup.solicitorReference];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else if (indexPath.section == 5) { //Property
        PropertyModel* propertyModel = relatedMatterModel.propertyGroupArray[indexPath.row];
        [cell configureCellWithContact:propertyModel.fullTitle text:propertyModel.address];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (indexPath.section == 6) { // Bank
        BankGroupModel* bankGroupModel = relatedMatterModel.bankGroupArray[indexPath.row];
        [cell configureCellWithContact:bankGroupModel.bankGroupName text:bankGroupModel.bankName];
        if (bankGroupModel.bankName.length != 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    } else if (indexPath.section == 7) { // Important RM
        GeneralGroup* RMGroup = relatedMatterModel.RMGroupArray[indexPath.row];
        [cell configureCellWithContact:RMGroup.label text:RMGroup.value];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.section == 8) { // Important Date
        GeneralGroup* dateGroup = relatedMatterModel.dateGroupArray[indexPath.row];
        [cell configureCellWithContact:dateGroup.label text:dateGroup.value];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.section == 9) { // Other Information
        GeneralGroup* otherInfo = relatedMatterModel.textGroupArray[indexPath.row];
        [cell configureCellWithContact:otherInfo.label text:otherInfo.value];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if (indexPath.section == 10) { // Other Information
        if (indexPath.row == 0) {
            [cell configureCellWithContact:@"File Folder" text:@""];
        } else {
            [cell configureCellWithContact:@"Ledger" text:@""];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kPropertySearchSegue]){
        PropertyViewController* propertyVC = segue.destinationViewController;
        propertyVC.propertyModel = sender;
        propertyVC.previousScreen = @"Back";
    }
    
    if ([segue.identifier isEqualToString:kLedgerSearchSegue]){
        LedgerViewController* ledgerVC = segue.destinationViewController;
        ledgerVC.ledgerArray = sender;
        ledgerVC.matterCode = relatedMatterModel.systemNo;
        ledgerVC.previousScreen = @"Back";
    }
    
    if ([segue.identifier isEqualToString:kBankSearchSegue]){
        BankViewController* bankVC = segue.destinationViewController;
        bankVC.bankModel = sender;
        bankVC.previousScreen = @"Back";
    }
    
    if ([segue.identifier isEqualToString:kContactSearchSegue]){
        ContactViewController* contactVC = segue.destinationViewController;
        contactVC.contactModel = sender;
        contactVC.previousScreen = @"Back";
    }
    
    if ([segue.identifier isEqualToString:kLegalFirmSearchSegue]){
        LegalFirmViewController* legalFirmVC = segue.destinationViewController;
        legalFirmVC.legalFirmModel = sender;
        legalFirmVC.previousScreen = @"Back";
    }
    
    if ([segue.identifier isEqualToString:kDocumentSearchSegue]){
        DocumentViewController* documentVC = segue.destinationViewController;
        documentVC.documentModel = sender;
        documentVC.previousScreen = @"Back";
    }
}

@end
