//
//  AddPropertyViewController.m
//  Denning
//
//  Created by DenningIT on 11/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AddPropertyViewController.h"
#import "FloatingTextCell.h"
#import "FloatingTextTwoColumnCell.h"
#import "ListWithDescriptionViewController.h"
#import "ListWithCodeTableViewController.h"
#import "BirthdayCalendarViewController.h"
#import "ProjectHousingViewController.h"
#import "PropertyContactListViewController.h"
#import "PropertyListViewController.h"

@interface AddPropertyViewController ()<UITableViewDelegate, UITableViewDataSource, ContactListWithDescSelectionDelegate, ContactListWithCodeSelectionDelegate,
UITextFieldDelegate>
{
    NSString *titleOfList;
    NSString* nameOfField;
    NSString* selectedPropertyType;
    NSString* selectedTitleIssuedCode;
    NSString* selectedAreaTypeCode;
    NSString* selectedRestrictionCode;
    NSString* selectedPropertyCode;
    __block BOOL isLoading;
    NSInteger selectedContactRow;
}
@property (weak, nonatomic) IBOutlet FZAccordionTableView *tableView;
@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) NSArray *headers;

@property (strong, nonatomic)
NSMutableDictionary* keyValue;
@end

@implementation AddPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    [self registerNib];
}

- (void) prepareUI {
    selectedRestrictionCode = @"";
    selectedPropertyType = @"";
    selectedAreaTypeCode = @"";
    selectedTitleIssuedCode = @"";
    self.keyValue = [@{
                       @(0): @(1), @(1):@(1),
                       @(2):@(0),
                       @(3):@(0),
                       @(4):@(0)
                      } mutableCopy];
    NSArray* temp = @[
                  @[@[@"Property Description", @""], @[@"Individual/Strata Title", @""]],
                  @[@[@"ID", @""], @[@"Title Type", @""], @[@"Title No.", @""], @[@"Lot Type", @""], @[@"Lot/PT No.", @""], @[@"Mukim Type", @""], @[@"Mukim Value", @""], @[@"Daerah", @""], @[@"Negeri", @""], @[@"Area Type", @""], @[@"Area Value", @""], @[@"Tenure", @""], @[@"Address/Place", @""], @[@"Lease Expiry Date", @""], @[@"Restriction in Interest", @""], @[@"Restriction Against", @""], @[@"Approving Authority", @""], @[@"Category of Land Use", @""]
                    ],
                  @[@[@"Parcel No.", @""], @[@"Storey No.", @""], @[@"Building No", @""], @[@"Accessory Prcel No.", @""], @[@"Accessory Storey No.", @""], @[@"Accessory Building No.", @""], @[@"Units of Shares", @""], @[@"Total Shares", @""]],
                  @[@[@"Parcel Type", @""], @[@"Unit/Parcel No.", @""], @[@"Storey No.", @""], @[@"Building/Block No.", @""], @[@"Apt/Condo name", @""], @[@"Accessory Parcel No", @""], @[@"SPA Area Type", @""], @[@"SPA Area Value", @""]],
                  @[@[@"Project Name", @""], @[@"Developer", @""], @[@"Proprietor", @""], @[@"Block/Master Title", @""]],
                  ];
    _contents = [temp mutableCopy];
    
    _headers = @[
                @"", @"Title Details (if issued)", @"Strata Title Details (if issued)", @"Unit / Parcel Details (Per Principal SPA)", @"Project"
                ];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveProperty:(id)sender {
    NSDictionary* data = @{
                           @"accBuildingNo": _contents[2][5][1],
                           @"accParcelNo": _contents[2][3][1],
                           @"accStoreyNo": _contents[2][4][1],
                           @"address": _contents[1][10][1],
                           @"approvingAuthority": _contents[1][14][1],
                           @"area": @{
                               @"type": _contents[1][9][1],
                               @"value": _contents[1][10][1]
                           },
                           @"daerah": _contents[1][7][1],
                           @"fullTitle": @"H.S.(M) 11043, P.T. 19042, Mukim Triang, Daerah Bera",
                           @"landUse": _contents[1][17][1],
                           @"leaseExpiryDate": _contents[1][13][1],
                           @"lotPT": @{
                               @"type": _contents[1][3][1],
                               @"value": _contents[1][4][1]
                           },
                           @"mukim": @{
                               @"type": _contents[1][5][1],
                               @"value": _contents[1][6][1]
                           },
                           @"negeri": _contents[1][8][1],
                           @"propertyType": @{
                               @"code": selectedPropertyType
                           },
                           @"restrictionAgainst": _contents[1][12][1],
                           @"restrictionInInterest": @{
                               @"code": selectedRestrictionCode
                           },
                           @"spaAccParcelNo": _contents[2][0][1],
                           @"spaArea": @{
                               @"type": _contents[3][6][1],
                               @"value": _contents[3][7][1]
                           },
                           @"spaBuildingNo": _contents[3][3][1],
                           @"spaCondoName": _contents[3][4][1],
                           @"spaParcel": @{
                               @"type": _contents[3][0][1],
                               @"value": _contents[3][1][1]
                           },
                           @"spaStoreyNo": _contents[3][2][1],
                           @"storeyNo": _contents[2][1][1],
                           @"tenure": _contents[1][9][1],
                           @"title": @{
                               @"type": _contents[1][1][1],
                               @"value": _contents[1][2][1]
                           },
                           @"titleIssued": @{
                               @"code": selectedTitleIssuedCode
                           },
                           @"totalShare": _contents[2][7][1],
                           @"unitShare": _contents[2][6][1]
                           };
    if (isLoading) return;
    isLoading = YES;
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:NSLocalizedString(@"QM_STR_LOADING", nil) duration:0];
    __weak UINavigationController *navigationController = self.navigationController;
    @weakify(self);
    [[QMNetworkManager sharedManager] saveBillorQuotationWithParams:data inURL:PROPERTY_SAVE_URL WithCompletion:^(NSDictionary * _Nonnull result, NSError * _Nonnull error) {
        [navigationController dismissNotificationPanel];
        @strongify(self)
        self->isLoading = NO;
        if (error == nil) {
            [navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:@"Successfully saved" duration:2.0];
//            [self updateWholeData:result];
        } else {
            [navigationController showNotificationWithType:QMNotificationPanelTypeWarning message:error.localizedDescription duration:2.0];
        }
    }];
}

- (void) registerNib {
    self.tableView.allowMultipleSectionsOpen = YES;
    self.tableView.initialOpenSections = [NSSet setWithObjects:@(0), @(1), nil];
    // Hide empty separators
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [FloatingTextCell registerForReuseInTableView:self.tableView];
    [FloatingTextTwoColumnCell registerForReuseInTableView:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return [self.contents[section] count] - 4;
    }
    if (section == 3) {
        return [self.contents[section] count] - 2;
    }
    return [self.contents[section] count];
}

- (NSInteger) calcPrevRowCount: (NSInteger) curSection
{
    NSInteger count = 0;
    
    for (int i = 0; i < curSection; i++) {
        count += [_contents[i] count];
    }
    return count;
}

- (NSArray*) calcSectionNumber: (NSInteger) tag {
    NSInteger section = 0;
    NSInteger remain = tag;
    for (int i = 0; i < self.tableView.numberOfSections; i++) {
        section = i;
        if (remain - [self.tableView numberOfRowsInSection:i] < 0) {
            break;
        }
        remain = (remain - [self.tableView numberOfRowsInSection:i]);
    }
    
    return @[@(section), @(remain)];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIToolbar *accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)];
    accessoryView.barTintColor = [UIColor groupTableViewBackgroundColor];
    accessoryView.tintColor = [UIColor babyRed];
    
    accessoryView.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [accessoryView sizeToFit];
    
    if ((indexPath.section == 3 && (indexPath.row == 0 || indexPath.row == 5)) || (indexPath.section == 1 && (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 6))) {
        NSInteger rows = indexPath.row;
        
        
        FloatingTextTwoColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:[FloatingTextTwoColumnCell cellIdentifier] forIndexPath:indexPath];
        if (indexPath.section == 1) {
            if (indexPath.row == 2) {
                rows += 1;
            }
            if (indexPath.row == 3) {
                rows += 2;
            }
            if (indexPath.row == 6) {
                rows += 3;
            }
            cell.rightFloatingText.tag = [self calcPrevRowCount:1] + rows+1; // consider section 0
        }
        
        if (indexPath.section == 3 && indexPath.row == 5) {
            rows += 1;
            cell.rightFloatingText.tag = [self calcPrevRowCount:3] + rows+1;
        }

        cell.leftFloatingText.placeholder = self.contents[indexPath.section][rows][0];
        cell.rightFloatingText.placeholder = self.contents[indexPath.section][rows+1][0];
        cell.leftFloatingText.text = self.contents[indexPath.section][rows][1];
        cell.rightFloatingText.text = self.contents[indexPath.section][rows+1][1];
        cell.rightFloatingText.floatLabelActiveColor = cell.rightFloatingText.floatLabelPassiveColor = cell.leftFloatingText.floatLabelActiveColor = cell.leftFloatingText.floatLabelPassiveColor = [UIColor redColor];
        
        cell.leftFloatingText.inputAccessoryView = accessoryView;
        cell.rightFloatingText.inputAccessoryView = accessoryView;
        cell.leftFloatingText.keyboardType = UIKeyboardTypeDefault;
        cell.rightFloatingText.keyboardType = UIKeyboardTypeDecimalPad;
        
        
        cell.rightFloatingText.delegate = self;
        
        cell.updateHandler = ^{
            
        };
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    
    FloatingTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[FloatingTextCell cellIdentifier] forIndexPath:indexPath];
    
    int rows = (int)indexPath.row;
    if (indexPath.section == 1) {
        if (indexPath.row > 3 && indexPath.row < 6) {
            rows += 3;
        }
        else if (indexPath.row > 6) {
            rows += 4;
        }
        
    } else if (indexPath.section == 3) {
        if (indexPath.row > 0) {
            rows += 1;
        }
    }
    
    cell.floatingTextField.tag = [self calcPrevRowCount:indexPath.section] + rows;
    
    cell.floatingTextField.placeholder = self.contents[indexPath.section][rows][0];
    cell.floatingTextField.text = self.contents[indexPath.section][rows][1];
    cell.floatingTextField.floatLabelActiveColor = cell.floatingTextField.floatLabelPassiveColor = [UIColor redColor];
    
    cell.floatingTextField.inputAccessoryView = accessoryView;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.floatingTextField.userInteractionEnabled = YES;
    
    cell.floatingTextField.delegate = self;
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.floatingTextField.userInteractionEnabled = NO;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 7 || indexPath.row == 9 || indexPath.row == 10 || indexPath.row == 11 || indexPath.row == 13) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.floatingTextField.userInteractionEnabled = NO;
        }
        
        if (indexPath.row == 0) {
            cell.floatingTextField.userInteractionEnabled = NO;
        }
        
        cell.floatingTextField.keyboardType = UIKeyboardTypeDefault;
    } else if (indexPath.section == 2) {
        if (indexPath.row == 6 || indexPath.row == 6) {
            cell.floatingTextField.keyboardType = UIKeyboardTypeDefault;
        } else {
            cell.floatingTextField.keyboardType = UIKeyboardTypeDecimalPad;
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 5) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.floatingTextField.userInteractionEnabled = NO;
        }
        if (indexPath.row == 3) {
            cell.floatingTextField.keyboardType = UIKeyboardTypeDefault;
        } else {
            cell.floatingTextField.keyboardType = UIKeyboardTypeDecimalPad;
        }
    } else if (indexPath.section == 4) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    NSArray* obj = [self calcSectionNumber:textField.tag];
    [self replaceContentForSection:[obj[0] integerValue] InRow:[obj[1] integerValue] withValue:textField.text];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
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
    if (section == 0) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor lightGrayColor];
        return view;
    }
 
    return [self updateCustomSectionHeaderInSection:section withTableView:tableView];
}

- (void) showCalendar {
    [self.view endEditing:YES];
    
    BirthdayCalendarViewController *calendarViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CalendarView"];
    calendarViewController.updateHandler =  ^(NSString* date) {
        [self replaceContentForSection:1 InRow:13 withValue:date];
    };
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:calendarViewController];
    [STPopupNavigationBar appearance].barTintColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.0f];
    [STPopupNavigationBar appearance].tintColor = [UIColor whiteColor];
    [STPopupNavigationBar appearance].barStyle = UIBarStyleDefault;
    [STPopupNavigationBar appearance].titleTextAttributes = @{ NSFontAttributeName: [UIFont fontWithName:@"Cochin" size:18], NSForegroundColorAttributeName: [UIColor whiteColor] };
    popupController.transitionStyle = STPopupTransitionStyleFade;;
    popupController.containerView.layer.cornerRadius = 4;
    popupController.containerView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
    popupController.containerView.layer.shadowOffset = CGSizeMake(4, 4);
    popupController.containerView.layer.shadowOpacity = 1;
    popupController.containerView.layer.shadowRadius = 1.0;
    
    [popupController presentInViewController:self];
}

- (void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            titleOfList = @"Select Property Type";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithCodeSegue sender:PROPERTY_TYPE_GET_LIST_URL];
        } else if (indexPath.row == 1) {
            titleOfList = @"Issued Title of Property";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithCodeSegue sender:PROPERTY_TITLE_ISSUED_GET_URL];
        }
    } else if (indexPath.section == 1) {
        NSInteger rows = indexPath.row;
        if (indexPath.row == 2) {
            rows += 1;
        }
        if (indexPath.row == 3) {
            rows += 2;
        }
        if (indexPath.row > 3 && indexPath.row <= 6) {
            rows += 3;
        }
        else if (indexPath.row > 6) {
            rows += 4;
        }
        if (indexPath.row == 1) {
            titleOfList = @"Type of Property";
            nameOfField = self.contents[indexPath.section][rows][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_TITLE_TYPE_GET_URL];
        } else if (indexPath.row == 2) {
            titleOfList = @"Lot Type of Property";
            nameOfField = self.contents[indexPath.section][rows][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_LOT_TYPE_GET_URL];
        } else if (indexPath.row == 3) {
            titleOfList = @"Mukim Type of Property";
            nameOfField = self.contents[indexPath.section][rows][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_MUKIM_TYPE_GET_URL];
        } else if (indexPath.row == 6) {
            titleOfList = @"Area Type of Property";
            nameOfField = self.contents[indexPath.section][rows][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_AREA_TYPE_GET_URL];
        } else if (indexPath.row == 7) {
            titleOfList = @"Tenure Type of Property";
            nameOfField = self.contents[indexPath.section][rows][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_TENURE_TYPE_GET_URL];
        } else if (indexPath.row == 9) {
            [self showCalendar];
        } else if (indexPath.row == 10) {
            titleOfList = @"Restriction of Property";
            nameOfField = self.contents[indexPath.section][rows][0];
            [self performSegueWithIdentifier:kListWithCodeSegue sender:PROPERTY_RESTRICTION_GET_URL];
        } else if (indexPath.row == 11) {
            titleOfList = @"Restriction Against of Property";
            nameOfField = self.contents[indexPath.section][rows][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_RESTRICTION_AGAINST_GET_URL];
        } else if (indexPath.row == 13) {
            titleOfList = @"Conduse of Property";
            nameOfField = self.contents[indexPath.section][rows][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_LANDUSE_GET_URL];
        }
    } else if (indexPath.section == 3) {
        NSInteger rows = indexPath.row;
        if (rows > 0) {
            rows += 1;
        }
       
        if (indexPath.row == 0) {
            titleOfList = @"Parcel Type of Property";
            nameOfField = self.contents[indexPath.section][rows][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_AREA_TYPE_GET_URL];
        } else if (indexPath.row == 5) {
            titleOfList = @"Area Type of Property";
            nameOfField = self.contents[indexPath.section][rows][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_AREA_TYPE_GET_URL];
        }
    } else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            [self performSegueWithIdentifier:kProjectHousingSegue sender:PROPERTY_PROJECT_HOUSING_GET_URL];
        } else if (indexPath.row == 1) {
            selectedContactRow = indexPath.row;
            [self performSegueWithIdentifier:kContactGetListSegue sender:CONTACT_GETLIST_URL];
        } else if (indexPath.row == 2) {
            selectedContactRow = indexPath.row;
            [self performSegueWithIdentifier:kContactGetListSegue sender:CONTACT_GETLIST_URL];
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

#pragma mark - ContactListWithCodeSelectionDelegate
- (void) didSelectList:(UIViewController *)listVC name:(NSString*) name withModel:(CodeDescription *)model
{
    if ([name isEqualToString:@"Property Description"]) {
        [self replaceContentForSection:0 InRow:0 withValue:model.descriptionValue];
        selectedPropertyType = model.codeValue;
    }else if ([name isEqualToString:@"Individual/Strata Title"]) {
        [self replaceContentForSection:0 InRow:1 withValue:model.descriptionValue];
        selectedTitleIssuedCode = model.codeValue;
    } else if ([name isEqualToString:@"Restriction in Interest"]) {
        [self replaceContentForSection:1 InRow:11 withValue:model.descriptionValue];
        selectedRestrictionCode = model.codeValue;
    }
}

#pragma mark - ContactListWithDescriptionDelegate
- (void) didSelectListWithDescription:(UIViewController *)listVC name:(NSString*) name withString:(NSString *)description
{
    for (int i = 0; i < self.tableView.numberOfSections; i ++) {
        for (int j = 0; j < [_contents[i] count]; j++) {
            NSLog(@"(%d, %d)", i, j);
            if ([name isEqualToString:_contents[i][j][0]]) {
                [self replaceContentForSection:i InRow:j withValue:description];
            }
        }
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kListWithDescriptionSegue]) {
        UINavigationController* navVC = segue.destinationViewController;
        ListWithDescriptionViewController* vc = navVC.viewControllers.firstObject;
        vc.url = sender;
        vc.titleOfList = titleOfList;
        vc.name = nameOfField;
        vc.contactDelegate = self;
    }
    
    if ([segue.identifier isEqualToString:kListWithCodeSegue]) {
        UINavigationController *navVC =segue.destinationViewController;
        
        ListWithCodeTableViewController *listCodeVC = navVC.viewControllers.firstObject;
        listCodeVC.delegate = self;
        listCodeVC.titleOfList = titleOfList;
        listCodeVC.name = nameOfField;
        listCodeVC.url = sender;
    }
    
    if ([segue.identifier isEqualToString:kProjectHousingSegue]) {
        ProjectHousingViewController* housingVC = segue.destinationViewController;
        housingVC.updateHandler = ^(ProjectHousingModel *model) {
            [self replaceContentForSection:4 InRow:0 withValue:model.housingCode];
        };
    }
    
    if ([segue.identifier isEqualToString:kContactGetListSegue]) {
        PropertyContactListViewController* contactVC = segue.destinationViewController;
        contactVC.updateHandler = ^(StaffModel *model) {
            [self replaceContentForSection:4 InRow:selectedContactRow withValue:model.name];
        };
    }
    
    if ([segue.identifier isEqualToString:kPropertyTypeSegue]) {
        PropertyListViewController* propertyVC = segue.destinationViewController;
        propertyVC.updateHandler = ^(FullPropertyModel *model) {
            [self replaceContentForSection:0 InRow:0 withValue:model.fullTitle];
            selectedPropertyType = model.propertyCode;
        };
    }
    
}

@end
