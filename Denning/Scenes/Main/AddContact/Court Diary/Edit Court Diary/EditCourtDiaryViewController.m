//
//  EditCourtDiaryViewController.m
//  Denning
//
//  Created by DenningIT on 08/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "EditCourtDiaryViewController.h"
#import "FloatingTextCell.h"
#import "StaffViewController.h"
#import "BirthdayCalendarViewController.h"
#import "ListWithCodeTableViewController.h"

@interface EditCourtDiaryViewController ()
<UIDocumentInteractionControllerDelegate, UITableViewDelegate, UITableViewDataSource, ContactListWithDescSelectionDelegate, ContactListWithCodeSelectionDelegate, UITextFieldDelegate>
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
@property (strong, nonatomic) NSMutableArray* addOn;
@property (nonatomic, strong) NSArray *headers;

@property (strong, nonatomic)
NSMutableDictionary* keyValue;
@end

@implementation EditCourtDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self registerNib];
}
- (void) prepareUI {
    self.keyValue = [@{
                       @(0): @(1), @(1):@(0)
                       } mutableCopy];
    _addOn = [@[@[@"Next date", @""], @[@"Next Time", @""], @[@"Enclosure No", @""], @[@"Next Nature of Hearing", @""], @[@"Next Details.", @""], @[@"Next Remarks.", @""]
              ] mutableCopy];
    
    NSArray* temp = @[
                      @[@[@"File No", @""], @[@"Previous Date", @""], @[@"Present Hearing Date", @""], @[@"Enclosure No", @""], @[@"Hearing Type", @""], @[@"Details", @""], @[@"Counsel Assigned", @""], @[@"Attendant Type", @""], @[@"Counsel Attended", @""], @[@"Coram", @""], @[@"Opponent's Counsel", @""], @[@"Court Decision", @""], @[@"Select Next Date Type", @""]],
                      
                      ];
//    _contents = [temp ara];
    
    _headers = @[@"Bill Details", @"Bill Analysis"
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

- (IBAction)saveBill:(id)sender {
    NSDictionary* data = @{
                           @"fileNo": _contents[0][2][1],
                           @"isRental": isRental,
                           @"issueDate": [DIHelpers todayWithTime],
                           @"issueTo1stCode": @{
                                   @"code": issueToFirstCode
                                   },
                           @"issueToName": _contents[0][4][1],
                           @"matter": @{
                                   @"code": _contents[0][3][1]
                                   },
                           @"presetCode": @{
                                   @"code": _contents[0][5][1]
                                   },
                           @"relatedDocumentNo": _contents[0][0][1],
                           @"spaPrice": [self getValidValue:_contents[0][6][1]],
                           @"spaLoan": [self getValidValue:_contents[0][7][1]],
                           @"rentalMonth": [self getValidValue:_contents[0][8][1]],
                           @"rentalPrice": [self getValidValue:_contents[0][9][1]]
                           };
    if (isLoading) return;
    isLoading = YES;
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:NSLocalizedString(@"QM_STR_LOADING", nil) duration:0];
    __weak UINavigationController *navigationController = self.navigationController;
    @weakify(self);
    [[QMNetworkManager sharedManager] saveBillorQuotationWithParams:data inURL:TAXINVOICE_SAVE_URL WithCompletion:^(NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        [navigationController dismissNotificationPanel];
        @strongify(self)
        self->isLoading = NO;
        if (error == nil) {
            [navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:@"Successfully saved" duration:1.0];
            self->isSaved = YES;
            [self updateWholeData:result];
            
        } else {
            [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:error.localizedDescription duration:1.0];
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
    NSString* relatedDocumentNo = [result objectForKeyNotNull:@"relatedDocumentNo"];
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
    
    [self replaceContentForSection:0 InRow:0 withValue:relatedDocumentNo];
    [self replaceContentForSection:0 InRow:1 withValue:documentNo];
    [self replaceContentForSection:0 InRow:2 withValue:fileNo];
    [self replaceContentForSection:0 InRow:3 withValue:matterCode];
    [self replaceContentForSection:0 InRow:4 withValue:issueToName];
    [self replaceContentForSection:0 InRow:5 withValue:presetCode];
    [self replaceContentForSection:0 InRow:6 withValue:spaPrice];
    [self replaceContentForSection:0 InRow:7 withValue:spaLoan];
    [self replaceContentForSection:0 InRow:8 withValue:rentalMonth];
    [self replaceContentForSection:0 InRow:9 withValue:rentalPrice];
    
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

- (NSString*) getValidValue: (NSString*) value
{
    if (value.length == 0) {
        return @"0";
    }
    else {
        return value;
    }
    
    return value;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    cell.floatingTextField.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][rows][1]];
    cell.floatingTextField.floatLabelActiveColor = cell.floatingTextField.floatLabelPassiveColor = [UIColor redColor];
    cell.floatingTextField.delegate = self;
    cell.floatingTextField.inputAccessoryView = accessoryView;
    cell.floatingTextField.tag = indexPath.row;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.floatingTextField.userInteractionEnabled = YES;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3  || indexPath.row == 5) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.floatingTextField.userInteractionEnabled = NO;
        } else if (indexPath.row == 1 || indexPath.row == 4) {
            cell.floatingTextField.userInteractionEnabled = NO;
        }
    }
    cell.floatingTextField.floatLabelActiveColor = cell.floatingTextField.floatLabelPassiveColor = [UIColor redColor];
    
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
        if (indexPath.row == 0) {
            [self performSegueWithIdentifier:kQuotationSegue sender:QUOTATION_GET_LIST_URL];
        } else if (indexPath.row == 2) {
            [self performSegueWithIdentifier:kSimpleMatterSegue sender:MATTERSIMPLE_GET_URL];
        } else if (indexPath.row == 3) {
            [self performSegueWithIdentifier:kMatterCodeSegue sender:MATTER_LIST_GET_URL];
        } else if (indexPath.row == 5) {
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
        for (int j = 0; j < [_contents[i] count]; j++) {
            if ([name isEqualToString:_contents[i][j][0]]) {
                [self replaceContentForSection:i InRow:j withValue:description];
            }
        }
    }
}

- (void) replaceContentForSection:(NSInteger) section InRow:(NSInteger) row withValue:(NSString*) value{
    if (value == nil) {
        value = @"";
    }
    
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


#pragma mark - ContactListWithCodeSelectionDelegate
- (void) didSelectList:(UIViewController *)listVC name:(NSString*) name withModel:(CodeDescription *)model
{
    if ([name isEqualToString:@"natureOfHearing"]) {
        
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kListWithCodeSegue]) {
        UINavigationController *navVC =segue.destinationViewController;
        
        ListWithCodeTableViewController *listCodeVC = navVC.viewControllers.firstObject;
        listCodeVC.delegate = self;
        listCodeVC.titleOfList = titleOfList;
        listCodeVC.name = nameOfField;
        listCodeVC.url = sender;
    }
    
    if ([segue.identifier isEqualToString:kStaffSegue]) {
        UINavigationController *navVC =segue.destinationViewController;
        StaffViewController* staffVC = navVC.viewControllers.firstObject;
        staffVC.typeOfStaff = sender;
        staffVC.updateHandler = ^(NSString*  typeOfStaff, StaffModel* model) {
//            self.councilAssigned.text = value;
        };
    }
    
}


@end
