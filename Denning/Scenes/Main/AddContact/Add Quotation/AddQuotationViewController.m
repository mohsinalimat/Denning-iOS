//
//  AddQuotationViewController.m
//  Denning
//
//  Created by DenningIT on 11/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AddQuotationViewController.h"
#import "FloatingTextCell.h"
#import "AddLastOneButtonCell.h"
#import "AddLastTwoButtonsCell.h"
#import "SimpleMatterViewController.h"
#import "ListOfMatterViewController.h"
#import "PresetBillViewController.h"

@interface AddQuotationViewController ()<UITableViewDelegate, UITableViewDataSource, ContactListWithDescSelectionDelegate, UITextFieldDelegate>
{
    NSString *titleOfList;
    NSString* nameOfField;
    __block NSString *isRental;
    __block NSString* issueToFirstCode;
    __block BOOL isLoading;
    __block BOOL isSaved;
}

@property (weak, nonatomic) IBOutlet FZAccordionTableView *tableView;
@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) NSArray *headers;

@property (strong, nonatomic)
NSMutableDictionary* keyValue;

@end

@implementation AddQuotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self registerNib];
}
- (void) prepareUI {
    self.keyValue = [@{
                       @(0): @(1), @(1):@(0)
                       } mutableCopy];
    NSArray* temp = @[
                      @[@[@"Quotation No.", @""], @[@"File No.", @""], @[@"Matter", @""], @[@"Quotation to", @""], @[@"Preset Code", @""], @[@"Price", @""], @[@"Loan", @""], @[@"Month", @""], @[@"Rental", @""]],
                      @[@[@"Professional Fees", @""], @[@"Disb. with GST", @""], @[@"Disbursements", @""], @[@"GST", @""], @[@"Total.", @""]
                        ],
                      ];
    _contents = [temp mutableCopy];
    
    _headers = @[@"Quotation Details", @"Quotation Analysis"
                 ];
    
    isRental = @"0";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveQuotaion:(id)sender {
    NSDictionary* data = @{
                           @"fileNo": _contents[0][1][1],
                           @"isRental": isRental,
                           @"issueDate": [DIHelpers todayWithTime],
                           @"issueTo1stCode": @{
                               @"code": issueToFirstCode
                           },
                           @"issueToName": _contents[0][3][1],
                           @"matter": @{
                               @"code": _contents[0][2][1]
                           },
                           @"presetCode": @{
                               @"code": _contents[0][4][1]
                           },
                           @"relatedDocumentNo": @"",
                           @"rentalMonth": _contents[0][7][1],
                           @"rentalPrice": _contents[0][8][1],
                           @"spaLoan": _contents[0][6][1],
                           @"spaPrice": _contents[0][5][1]
                           };
    if (isLoading) return;
    isLoading = YES;
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:NSLocalizedString(@"QM_STR_LOADING", nil) duration:0];
    __weak UINavigationController *navigationController = self.navigationController;
    @weakify(self);
    [[QMNetworkManager sharedManager] saveQuotationWithParams:data WithCompletion:^(NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        [navigationController dismissNotificationPanel];
        @strongify(self)
        if (error == nil) {
            self->isSaved = YES;
            [self updateWholeData:result];
            
        } else {
            [QMAlert showAlertWithMessage:error.localizedDescription actionSuccess:NO inViewController:self];
        }
    }];
}

- (void) registerNib {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;

    self.tableView.allowMultipleSectionsOpen = YES;
    self.tableView.initialOpenSections = [NSSet setWithObjects:@(0), @(1), nil];
    // Hide empty separators
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [FloatingTextCell registerForReuseInTableView:self.tableView];
    [AddLastOneButtonCell registerForReuseInTableView:self.tableView];
    [AddLastTwoButtonsCell registerForReuseInTableView:self.tableView];
   
    [self.tableView registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents[section] count] + 1;
}

- (void) updateWholeData: (NSDictionary*) result {
    isRental =  [result objectForKeyNotNull:@"isRental"];
    issueToFirstCode =  [result objectForKeyNotNull:@"issueTo1stCode"];
    NSString* issueToName =  [result objectForKeyNotNull:@"issueToName"];
    NSString* documentNo = [result objectForKeyNotNull:@"documentNo"];
    NSString* fileNo = [result objectForKeyNotNull:@"fileNo"];
    NSString* matterCode = [result objectForKeyNotNull:@"matter"];
    NSString* presetCode = [result objectForKeyNotNull:@"presetCode"];
    NSString* rentalMonth = [result objectForKeyNotNull:@"rentalMonth"];
    NSString* rentalPrice = [result objectForKeyNotNull:@"rentalPrice"];
    NSString* spaLoan = [result objectForKeyNotNull:@"spaLoan"];
    NSString* spaPrice = [result objectForKeyNotNull:@"spaPrice"];
    
    [self replaceContentForSection:0 InRow:0 withValue:documentNo];
    [self replaceContentForSection:0 InRow:1 withValue:fileNo];
    [self replaceContentForSection:0 InRow:2 withValue:matterCode];
    [self replaceContentForSection:0 InRow:3 withValue:issueToName];
    [self replaceContentForSection:0 InRow:4 withValue:presetCode];
    [self replaceContentForSection:0 InRow:5 withValue:spaPrice];
    [self replaceContentForSection:0 InRow:6 withValue:spaLoan];
    [self replaceContentForSection:0 InRow:7 withValue:rentalMonth];
    [self replaceContentForSection:0 InRow:8 withValue:rentalPrice];
    
    [self updateBelowViewWithData:[result objectForKeyNotNull:@"analysis"]];
}

- (void) updateBelowViewWithData: (NSDictionary*) result {
    NSString* iFee = [result objectForKeyNotNull:@"iFee"];
    NSString* iDisbTax = [result objectForKeyNotNull:@"iDisbTax"];
    NSString* iDisbOnly = [result objectForKeyNotNull:@"iDisbOnly"];
    NSString* iGST = [result objectForKeyNotNull:@"iGST"];
    NSString* iTotal = [result objectForKeyNotNull:@"iTotal"];
    
    [self replaceContentForSection:1 InRow:0 withValue:iFee];
    [self replaceContentForSection:1 InRow:1 withValue:iDisbTax];
    [self replaceContentForSection:1 InRow:2 withValue:iDisbOnly];
    [self replaceContentForSection:1 InRow:3 withValue:iGST];
    [self replaceContentForSection:1 InRow:4 withValue:iTotal];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 9) {
        AddLastOneButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddLastOneButtonCell cellIdentifier] forIndexPath:indexPath];
        cell.calculateHandler = ^{
            NSDictionary* data = @{
                                   @"isRental": isRental,
                                   @"spaPrice": _contents[0][5][1],
                                   @"spaLoan": _contents[0][6][1],
                                   @"rentalMonth": _contents[0][7][1],
                                   @"rentalPrice": _contents[0][8][1],
                                   @"presetCode": @{
                                       @"code": _contents[0][4][1]
                                   }
                                   };
            if (isLoading) return;
            isLoading = YES;
            [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:NSLocalizedString(@"QM_STR_LOADING", nil) duration:0];
            __weak UINavigationController *navigationController = self.navigationController;
            @weakify(self);
            [[QMNetworkManager sharedManager] calculateTaxInvoiceWithParams:data withCompletion:^(NSDictionary * _Nonnull result, NSError * _Nonnull error) {
                
                [navigationController dismissNotificationPanel];
                @strongify(self)
                self->isLoading = NO;
                if (error == nil) {
                    [self updateBelowViewWithData:result];
                    
                } else {
                    [navigationController showNotificationWithType:QMNotificationPanelTypeWarning message:error.localizedDescription duration:0];
                }
                
            }];
        };
        return cell;
    }
    
    if (indexPath.section == 1 && indexPath.row == 5) {
        AddLastTwoButtonsCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddLastTwoButtonsCell cellIdentifier] forIndexPath:indexPath];
        cell.viewHandler = ^{
            if (!isSaved) {
                [self.navigationController  showNotificationWithType:QMNotificationPanelTypeWarning message:@"Please save quotaion first to view" duration:0];
//                [QMAlert showAlertWithMessage:@"Please save quotaion first to view" actionSuccess:NO inViewController:self];
                return;
            }
        };
        cell.convertHandler = ^{
            
        };
        return cell;
    }
    
    UIToolbar *accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)];
    accessoryView.barTintColor = [UIColor groupTableViewBackgroundColor];
    accessoryView.tintColor = [UIColor babyRed];
    
    accessoryView.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [accessoryView sizeToFit];
    
    FloatingTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[FloatingTextCell cellIdentifier] forIndexPath:indexPath];
    
    int rows = (int)indexPath.row;
    cell.floatingTextField.placeholder = self.contents[indexPath.section][rows][0];
    cell.floatingTextField.text = self.contents[indexPath.section][rows][1];
    cell.floatingTextField.floatLabelActiveColor = cell.floatingTextField.floatLabelPassiveColor = [UIColor redColor];
    cell.floatingTextField.delegate = self;
    cell.floatingTextField.inputAccessoryView = accessoryView;
    cell.floatingTextField.tag = indexPath.row;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.floatingTextField.userInteractionEnabled = YES;
    if (indexPath.section == 0) {
        if (indexPath.row == 1 || indexPath.row == 2  || indexPath.row == 4) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.floatingTextField.userInteractionEnabled = NO;
        } else if (indexPath.row == 0 || indexPath.row == 3) {
            cell.floatingTextField.userInteractionEnabled = NO;
        }
        
        cell.hidden = NO;
        if ([isRental integerValue] == 0) {
            if (indexPath.row == 5 || indexPath.row == 6) {
                cell.hidden = NO;
                cell.floatingTextField.keyboardType = UIKeyboardTypeDecimalPad;
            }
        } else {
            if (indexPath.row == 7 || indexPath.row == 8) {
                cell.hidden = YES;
                cell.floatingTextField.keyboardType = UIKeyboardTypeDecimalPad;
            }
        }
    } else if (indexPath.section == 1) {
        cell.floatingTextField.userInteractionEnabled = NO;
    }
    return cell;
}

- (void)handleTap {
    [self.view endEditing:YES];
}

#pragma mark - UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self replaceContentForSection:0 InRow:textField.tag withValue:textField.text];
}

#pragma mark - UITableView Datasource

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && (indexPath.row == 5 || indexPath.row == 6)) {
        if ([isRental integerValue] == 0) {
            return 60;
        } else {
            return 0;
        }
    } else if (indexPath.section == 0 && (indexPath.row == 7 || indexPath.row == 8)) {
        if ([isRental integerValue] == 0) {
            return 0;
        } else {
            return 60;
        }
    }
    
    if (indexPath.section == 1 && indexPath.row == 5) {
        return 120;
    }
    
    return 60.0f;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kDefaultAccordionHeaderViewHeight;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)reloadHeaders {
    for (NSInteger i = 0; i < [self numberOfSectionsInTableView:self.tableView]; i++) {
        AccordionHeaderView *headerView = (AccordionHeaderView *)[self.tableView headerViewForSection:i];
        if ([self.keyValue[[NSNumber numberWithInteger:i]] integerValue] == 0) {
            [UIView animateWithDuration:0.1f animations:^{
                
                headerView.expandImage.image = [UIImage imageNamed:@"expandableImage"];
                
            } completion:nil];
        } else {
            [UIView animateWithDuration:0.1f animations:^{
                
                headerView.expandImage.image = [UIImage imageNamed:@"expandableImage_reverse"];
                
            } completion:nil];
        }
    }
}

- (AccordionHeaderView*) updateCustomSectionHeaderInSection:(NSInteger) section withTableView:(UITableView*) tableView {
    AccordionHeaderView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kAccordionHeaderViewReuseIdentifier];
    headerView.headerTitle.text = self.headers[section];
    
    if ([self.keyValue[[NSNumber numberWithInteger:section]] integerValue] == 0) {
        [UIView animateWithDuration:0.1f animations:^{
            
            headerView.expandImage.image = [UIImage imageNamed:@"expandableImage"];
            
        } completion:nil];
    } else {
        [UIView animateWithDuration:0.1f animations:^{
            
            headerView.expandImage.image = [UIImage imageNamed:@"expandableImage_reverse"];
            
        } completion:nil];
    }
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self updateCustomSectionHeaderInSection:section withTableView:tableView];
}

- (void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            [self performSegueWithIdentifier:kSimpleMatterSegue sender:MATTERSIMPLE_GET_URL];
        } else if (indexPath.row == 2) {
            [self performSegueWithIdentifier:kMatterCodeSegue sender:MATTER_LIST_GET_URL];
        } else if (indexPath.row == 4) {
            [self performSegueWithIdentifier:kPresetBillSegue sender:PRESET_BILL_GET_URL];
        }
    }
}

#pragma mark - <FZAccordionTableViewDelegate> -

- (void)tableView:(FZAccordionTableView *)tableView willOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    self.keyValue[[NSNumber numberWithInteger:section]] = @(1);
    [self reloadHeaders];
}

- (void)tableView:(FZAccordionTableView *)tableView didOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow: ([self.tableView numberOfRowsInSection:section]-1) inSection:section];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
}

- (void)tableView:(FZAccordionTableView *)tableView willCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
    self.keyValue[[NSNumber numberWithInteger:section]] = @(0);
    [self reloadHeaders];
}

- (void)tableView:(FZAccordionTableView *)tableView didCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

#pragma mark - ContactListWithDescriptionDelegate
- (void) didSelectListWithDescription:(UIViewController *)listVC name:(NSString*) name withString:(NSString *)description
{
    for (int i = 0; i < self.tableView.numberOfSections; i ++) {
        int rows = (int)[self.tableView numberOfRowsInSection:i];
        if (i == 3) {
            rows += 1;
        }
        for (int j = 0; j < rows; j++) {
            if ([name isEqualToString:_contents[i][j][0]]) {
                [self replaceContentForSection:i InRow:j withValue:description];
            }
        }
    }
}

- (void) replaceContentForSection:(NSInteger) section InRow:(NSInteger) row withValue:(NSString*) value{
    NSMutableArray *newArray = [NSMutableArray new];
    for (int i = 0; i < self.tableView.numberOfSections; i++) {
        newArray[i] = [NSMutableArray new];
        
        for (int j = 0; j < [_contents[i] count]; j++) {
            newArray[i][j] = [NSMutableArray new];
            [newArray[i][j] addObject:_contents[i][j][0]];
            if (i == section && j == row) {
                [newArray[i][j] addObject:value];
            } else {
                [newArray[i][j] addObject:_contents[i][j][1]];
            }
        }
    }
    
    self.contents = [newArray copy];
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSimpleMatterSegue]) {
        SimpleMatterViewController* matterVC = segue.destinationViewController;
        matterVC.updateHandler = ^(MatterSimple *model) {
            PartyGroupModel* partyGroup = model.partyGroupArray[0];
            issueToFirstCode = ((ClientModel*)partyGroup.partyArray[0]).IDNo;
            
            NSString *issueToName = @"";
            
            for(ClientModel* party in partyGroup.partyArray) {
                issueToName = [NSString stringWithFormat:@"%@ %@ ", issueToName, party.name];
            }
            
            [self replaceContentForSection:0 InRow:1 withValue:model.systemNo];
            
            
            [self replaceContentForSection:0 InRow:3 withValue:issueToName];
        };
    }
    
    if ([segue.identifier isEqualToString:kMatterCodeSegue]) {
        ListOfMatterViewController* matterVC = segue.destinationViewController;
        matterVC.updateHandler = ^(MatterCodeModel *model) {
            [self replaceContentForSection:0 InRow:2 withValue:model.matterCode];
            isRental = model.isRental;
        };
        
    }
    
    if ([segue.identifier isEqualToString:kPresetBillSegue]) {
        PresetBillViewController* billVC = segue.destinationViewController;
        billVC.updateHandler = ^(PresetBillModel *model) {
            [self replaceContentForSection:0 InRow:4 withValue:model.billCode];
            
        };
    }
}


@end
