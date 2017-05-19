//
//  AddMatterViewController.m
//  Denning
//
//  Created by DenningIT on 08/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AddMatterViewController.h"
#import "FloatingTextCell.h"
#import "PropertyContactListViewController.h"
#import "ListWithDescriptionViewController.h"
#import "ListWithCodeTableViewController.h"
#import "ListOfMatterViewController.h"
#import "StaffViewController.h"
#import "AddLastOneButtonCell.h"
#import "AddMatterCell.h"

@interface AddMatterViewController ()<UITableViewDelegate, UITableViewDataSource,
ContactListWithCodeSelectionDelegate,UITextFieldDelegate>
{
    NSString *titleOfList;
    NSString* nameOfField;
    __block BOOL isLoading;
    __block BOOL isSaved;
    
    
    NSNumber* selectedFileStatusCode;
    NSNumber* selectedPartnerCode;
    NSNumber* selectedLACode;
    NSNumber* selectedClerkCode;
    NSNumber* selectedPrimaryClientCode;
    NSNumber* selectedMatterCode;
    
    NSString* newLabel, *newValue;
    NSInteger selectedContactRow, selectedSection;
    __block BOOL isAddNew;
}
@property (weak, nonatomic) IBOutlet FZAccordionTableView *tableView;
@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) NSArray *headers;
@property (strong, nonatomic)
NSMutableDictionary* keyValue;

@end

@implementation AddMatterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self registerNib];
}

- (void) prepareUI {
    self.keyValue = [@{
                       @(0): @(1), @(1):@(0),
                       @(2):@(0),
                       @(3):@(0),
                       @(4):@(0)
                       } mutableCopy];
    NSArray* temp = @[
                      @[@[@"File No", @""], @[@"Primary Client", @""], @[@"File Status", @""], @[@"Partner-in-Charge", @""], @[@"LA-in-Charge", @""], @[@"Clert-in-Charge", @""], @[@"Matter", @""], @[@"Physical File", @""], @[@"Box", @""], @[@"Remarks", @""],
                          @[@"Save", @""]
                        ],
                      @[@[@"Add New Party", @""]],
                      @[@[@"Add New Solicitor", @""]],
                      @[@[@"Add New Property", @""]],
                      @[@[@"Add New Bank", @""]],
                      ];
    _contents = [temp mutableCopy];
    
    _headers = @[
                 @"Matter Information", @"Parties Group", @"Solicitors", @"Properties", @"Banks"
                 ];
}

- (void) replaceContentForSection:(NSInteger) section InRow:(NSInteger) row withValue:(NSString*) value{
    NSMutableArray *newArray = [NSMutableArray new];
    if (value == nil) {
        value = @"";
    }
    
    for (int i = 0; i < self.tableView.numberOfSections; i++) {
        newArray[i] = [NSMutableArray new];
        
        int jMax = (int)[_contents[i] count];
        if (isAddNew && i == selectedSection) {
            jMax = (int)MAX([_contents[i] count], row);
        }
        
        for (int j = 0; j < jMax; j++) {
            newArray[i][j] = [NSMutableArray new];
            if (isAddNew) {
                if (i == selectedSection && j == jMax - 1) {
                    [newArray[i][j] addObject:newLabel];
                    [newArray[i][j] addObject:value];
                    isAddNew = NO;
                } else {
                    [newArray[i][j] addObject:_contents[i][j][0]];
                    [newArray[i][j] addObject:_contents[i][j][1]];
                }
            } else {
                [newArray[i][j] addObject:_contents[i][j][0]];
                if (i == section && j == row) {
                    [newArray[i][j] addObject:value];
                } else {
                    
                    [newArray[i][j] addObject:_contents[i][j][1]];
                }
            }
            
            
        }
    }
    
    self.contents = [newArray copy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) registerNib {
    self.tableView.allowMultipleSectionsOpen = YES;
    self.tableView.initialOpenSections = [NSSet setWithObjects:@(0), @(1), nil];
    // Hide empty separators
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [FloatingTextCell registerForReuseInTableView:self.tableView];
    [AddLastOneButtonCell registerForReuseInTableView:self.tableView];
    [AddMatterCell registerForReuseInTableView:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.contents[section] count];
}

- (NSNumber*) getValidValue: (NSNumber*) value
{
    if (value == nil) {
        return @(0);
    }
    else {
        return value;
    }
    
    return value;
}

- (IBAction)saveMatter:(id)sender {
    NSDictionary* data = @{
                           @"primaryClient": @{
                                   @"code": [self getValidValue:selectedPrimaryClientCode]
                                   },
                           @"matter": @{
                                   @"code": [self getValidValue:selectedMatterCode]
                                   },
                           @"partner": @{
                                   @"code": [self getValidValue:selectedPartnerCode]                                   },
                           @"LA": @{
                                   @"code": [self getValidValue:selectedLACode]
                                   },
                           @"clerk": @{
                                   @"code": [self getValidValue:selectedClerkCode]
                                   },
                           @"fileStatus": @{
                                   @"code": [self getValidValue:selectedFileStatusCode]
                                   },
                           @"locationBox": _contents[0][8][1],
                           @"locationPhysical": _contents[0][7][1],
                           @"remarks": _contents[0][9][1]
                           };
    if (isLoading) return;
    isLoading = YES;
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:NSLocalizedString(@"QM_STR_LOADING", nil) duration:0];
    __weak UINavigationController *navigationController = self.navigationController;
    @weakify(self);
    [[QMNetworkManager sharedManager] saveMatterWithParams:data inURL:MATTER_SAVE_URL WithCompletion:^(RelatedMatterModel * _Nonnull result, NSError * _Nonnull error) {
        [navigationController dismissNotificationPanel];
        @strongify(self)
        self->isLoading = NO;
        if (error == nil) {
            [navigationController showNotificationWithType:QMNotificationPanelTypeSuccess message:@"Success" duration:2.0];
            
        } else {
            [navigationController showNotificationWithType:QMNotificationPanelTypeWarning message:error.localizedDescription duration:2.0];
        }
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == [_contents[indexPath.section] count] -1) {
        AddLastOneButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddLastOneButtonCell cellIdentifier] forIndexPath:indexPath];
        cell.calculateHandler = ^{
            [self saveMatter:nil];
        };
        
        [cell.calculateBtn setTitle:_contents[indexPath.section][indexPath.row][0] forState:UIControlStateNormal];
        return cell;
    }
    
    if (indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        if (indexPath.row == 0) {
            AddMatterCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddMatterCell cellIdentifier] forIndexPath:indexPath];
            cell.label.text = _contents[indexPath.section][0][0];
            
            cell.addNew = ^{
                
            };
            
            return cell;
        }
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
    
    cell.floatingTextField.inputAccessoryView = accessoryView;
    cell.floatingTextField.delegate = self;
    cell.floatingTextField.tag = indexPath.row;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.floatingTextField.userInteractionEnabled = YES;
    if (indexPath.section == 0) {
        if (indexPath.row > 0 && indexPath.row < 7) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.floatingTextField.userInteractionEnabled = NO;
        }
        if (indexPath.row == 0) {
            cell.floatingTextField.userInteractionEnabled = NO;
        }
    } else if (indexPath.section == 1) {
       
    } else if (indexPath.section == 2) {
        
    } else if (indexPath.section == 3) {
        
    } else if (indexPath.section == 4) {
        
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

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kDefaultAccordionHeaderViewHeight;
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
    selectedContactRow = -1;
    selectedSection = indexPath.section;
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            selectedContactRow = indexPath.row;
            [self performSegueWithIdentifier:kContactGetListSegue sender:CONTACT_GETLIST_URL];
        } else if (indexPath.row == 2) {
            titleOfList = @"Select File Status";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithCodeSegue sender:MATTER_FILE_STATUS_GET_LIST_URL];
        } else if (indexPath.row == 3) {
            [self performSegueWithIdentifier:kStaffSegue sender:@"partner"];
        } else if (indexPath.row == 4) {
            [self performSegueWithIdentifier:kStaffSegue sender:@"la"];
        } else if (indexPath.row == 5) {
            [self performSegueWithIdentifier:kStaffSegue sender:@"clerk"];
        }
        else if (indexPath.row == 6)  {
            [self performSegueWithIdentifier:kMatterCodeSegue sender:MATTER_LIST_GET_URL];
        }
    } else if (indexPath.section == 1) {
        isAddNew = YES;
        if (indexPath.row == 0) {
            selectedContactRow = [_contents[indexPath.section] count] + 1;
            [self performSegueWithIdentifier:kContactGetListSegue sender:CONTACT_GETLIST_URL];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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


#pragma mark - ContactListWithCodeSelectionDelegate
- (void) didSelectList:(UIViewController *)listVC name:(NSString*) name withModel:(CodeDescription *)model
{
    if ([name isEqualToString:@"File Status"]) {
        [self replaceContentForSection:0 InRow:2 withValue:model.descriptionValue];
        selectedFileStatusCode = model.codeValue;
    } 
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kContactGetListSegue]) {
        PropertyContactListViewController* contactVC = segue.destinationViewController;
        contactVC.updateHandler = ^(StaffModel *model) {
            newLabel = @"Name";
            [self replaceContentForSection:selectedSection InRow:selectedContactRow withValue:model.name];
            selectedPrimaryClientCode =[NSNumber numberWithInteger: [model.staffCode integerValue]];
        };
    }
    
    if ([segue.identifier isEqualToString:kListWithCodeSegue]) {
        UINavigationController *navVC =segue.destinationViewController;
        
        ListWithCodeTableViewController *listCodeVC = navVC.viewControllers.firstObject;
        listCodeVC.delegate = self;
        listCodeVC.titleOfList = titleOfList;
        listCodeVC.name = nameOfField;
        listCodeVC.url = sender;
    }
    
    if ([segue.identifier isEqualToString:kMatterCodeSegue]) {
        ListOfMatterViewController* matterVC = segue.destinationViewController;
        matterVC.updateHandler = ^(MatterCodeModel *model) {
            [self replaceContentForSection:0 InRow:6 withValue:model.matterCode];
            selectedMatterCode = [NSNumber numberWithInteger: [model.matterCode integerValue]];
        };
        
    }
    
    if ([segue.identifier isEqualToString:kStaffSegue]) {
        UINavigationController *navVC =segue.destinationViewController;
        StaffViewController* staffVC = navVC.viewControllers.firstObject;
        staffVC.typeOfStaff = sender;
        staffVC.updateHandler = ^(NSString* typeOfStaff, StaffModel* model) {
            if ([typeOfStaff isEqualToString:@"partner"]) {
                [self replaceContentForSection:0 InRow:3 withValue:model.name];
                selectedPartnerCode = [NSNumber numberWithInteger: [model.staffCode integerValue]];
            } else if ([typeOfStaff isEqualToString:@"la"]) {
                [self replaceContentForSection:0 InRow:4 withValue:model.name];
                selectedLACode = [NSNumber numberWithInteger: [model.staffCode integerValue]];
            } else if ([typeOfStaff isEqualToString:@"clerk"]) {
                [self replaceContentForSection:0 InRow:5 withValue:model.name];
                selectedClerkCode = [NSNumber numberWithInteger: [model.staffCode integerValue]];
            }
            
        };
    }

}
@end
