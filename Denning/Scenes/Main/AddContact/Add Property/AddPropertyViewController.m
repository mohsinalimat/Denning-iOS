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
#import "BirthdayCalendarViewController.h"

@interface AddPropertyViewController ()<UITableViewDelegate, UITableViewDataSource, ContactListWithDescSelectionDelegate>
{
    NSString *titleOfList;
    NSString* nameOfField;
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
    self.keyValue = [@{
                       @(0): @(1), @(1):@(1),
                       @(2):@(0),
                       @(3):@(0),
                       @(4):@(0)
                      } mutableCopy];
    NSArray* temp = @[
                  @[@[@"Property Description", @""], @[@"Individual/Strata Title", @""]],
                  @[@[@"ID", @""], @[@"Title Type", @""], @[@"Title No.", @""], @[@"Lot Type", @""], @[@"Lot/PT No.", @""], @[@"Select Mukim", @""], @[@"Daerah", @""], @[@"Negeri", @""], @[@"Area", @""], @[@"Tenure", @""], @[@"Address/Place", @""], @[@"Lease Expiry Date", @""], @[@"Restriction in Interest", @""], @[@"Restriction Against", @""], @[@"Approving Authority", @""], @[@"Category of Land Use", @""]
                    ],
                  @[@[@"Parcel No.", @""], @[@"Storey No.", @""], @[@"Building No", @""], @[@"Accessory Prcel No.", @""], @[@"Accessory Storey No.", @""], @[@"Accessory Building No.", @""], @[@"Units of Shares", @""], @[@"Total Shares", @""]],
                  @[@[@"Parcel Type", @""], @[@"Unit/Parcel No.", @""], @[@"Storey No.", @""], @[@"Building/Block No.", @""], @[@"Apt/Condo name", @""], @[@"Accessory Parcel No", @""], @[@"Unit Area", @""]],
                  @[@[@"Project Code (optional)", @""], @[@"Project Name", @""], @[@"Developer", @""], @[@"Proprietor", @""], @[@"Block/Master Title", @""]],
                  ];
    _contents = [temp mutableCopy];
    
    _headers = @[
                @"", @"Title Details (if issued)", @"Strata Title Details (if issued)", @"Unit / Parcel Details (Per Principal SPA)", @"Project"
                ];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveProperty:(id)sender {
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
    if (section == 3) {
        return 6;
    }
    return [self.contents[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIToolbar *accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)];
    accessoryView.barTintColor = [UIColor groupTableViewBackgroundColor];
    accessoryView.tintColor = [UIColor babyRed];
    
    accessoryView.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [accessoryView sizeToFit];
    
    if (indexPath.section == 3 && indexPath.row == 0) {
        FloatingTextTwoColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:[FloatingTextTwoColumnCell cellIdentifier] forIndexPath:indexPath];
        cell.leftFloatingText.placeholder = self.contents[indexPath.section][indexPath.row][0];
        cell.rightFloatingText.placeholder = self.contents[indexPath.section][indexPath.row+1][0];
        cell.leftFloatingText.text = self.contents[indexPath.section][indexPath.row][1];
        cell.rightFloatingText.text = self.contents[indexPath.section][indexPath.row+1][1];
        cell.rightFloatingText.floatLabelActiveColor = cell.rightFloatingText.floatLabelPassiveColor = cell.leftFloatingText.floatLabelActiveColor = cell.leftFloatingText.floatLabelPassiveColor = [UIColor redColor];
        
        cell.leftFloatingText.inputAccessoryView = accessoryView;
        cell.rightFloatingText.inputAccessoryView = accessoryView;
        cell.leftFloatingText.keyboardType = UIKeyboardTypeDefault;
        cell.rightFloatingText.keyboardType = UIKeyboardTypeNumberPad;
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    
    FloatingTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[FloatingTextCell cellIdentifier] forIndexPath:indexPath];
    if (indexPath.section == 3) {
        if (indexPath.row == 5) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.floatingTextField.userInteractionEnabled = NO;
        }
    }
    
    int rows = (int)indexPath.row;
    if (indexPath.section == 3) {
        rows += 1;
    }
    cell.floatingTextField.placeholder = self.contents[indexPath.section][rows][0];
    cell.floatingTextField.text = self.contents[indexPath.section][rows][1];
    cell.floatingTextField.floatLabelActiveColor = cell.floatingTextField.floatLabelPassiveColor = [UIColor redColor];
    
    cell.floatingTextField.inputAccessoryView = accessoryView;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.floatingTextField.userInteractionEnabled = YES;
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.floatingTextField.userInteractionEnabled = NO;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 1 || indexPath.row == 3 ||  indexPath.row == 5 || indexPath.row == 8 || indexPath.row == 9 || indexPath.row == 11 || indexPath.row == 12 || indexPath.row == 13 || indexPath.row == 15) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.floatingTextField.userInteractionEnabled = NO;
        }
        
        if (indexPath.row == 0) {
            cell.floatingTextField.userInteractionEnabled = NO;
        }
        
        if (indexPath.row == 2 || indexPath.row == 4) {
            cell.floatingTextField.keyboardType = UIKeyboardTypeNumberPad;
        } else {
            cell.floatingTextField.keyboardType = UIKeyboardTypeDefault;
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 6 || indexPath.row == 6) {
            cell.floatingTextField.keyboardType = UIKeyboardTypeDefault;
        } else {
            cell.floatingTextField.keyboardType = UIKeyboardTypeNumberPad;
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 5) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.floatingTextField.userInteractionEnabled = NO;
        }
        if (indexPath.row == 3) {
            cell.floatingTextField.keyboardType = UIKeyboardTypeDefault;
        } else {
            cell.floatingTextField.keyboardType = UIKeyboardTypeNumberPad;
        }
    } else if (indexPath.section == 4) {
        if (indexPath.row == 0 || indexPath.row == 2 ||  indexPath.row == 5 || indexPath.row == 3) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.floatingTextField.userInteractionEnabled = NO;
        }
        cell.floatingTextField.keyboardType = UIKeyboardTypeDefault;
    }
    
    return cell;
}

- (void)handleTap {
    [self.view endEditing:YES];
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
        [self replaceContentForSection:1 InRow:11 withValue:date];
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
            titleOfList = @"Type of Property";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_TYPE_GET_URL];
        } else if (indexPath.row == 1) {
            titleOfList = @"Issued Title of Property";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_TITLE_ISSUED_GET_URL];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            titleOfList = @"Type of Property";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_TITLE_TYPE_GET_URL];
        } else if (indexPath.row == 3) {
            titleOfList = @"Lot Type of Property";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_LOT_TYPE_GET_URL];
        } else if (indexPath.row == 5) {
            titleOfList = @"Mukim Type of Property";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_MUKIM_TYPE_GET_URL];
        } else if (indexPath.row == 8) {
            titleOfList = @"Area Type of Property";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_AREA_TYPE_GET_URL];
        } else if (indexPath.row == 9) {
            titleOfList = @"Tenure Type of Property";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_TENURE_TYPE_GET_URL];
        } else if (indexPath.row == 9) {
            [self showCalendar];
        } else if (indexPath.row == 12) {
            titleOfList = @"Restriction of Property";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_RESTRICTION_GET_URL];
        } else if (indexPath.row == 13) {
            titleOfList = @"Restriction Against of Property";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_RESTRICTION_AGAINST_GET_URL];
        } else if (indexPath.row == 15) {
            titleOfList = @"Conduse of Property";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_CONDUSE_GET_URL];
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 5) {
            titleOfList = @"Area Type of Property";
            nameOfField = self.contents[indexPath.section][indexPath.row+1][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_AREA_TYPE_GET_URL];
        }
    } else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            titleOfList = @"Project Housing of Property";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:PROPERTY_PROJECT_HOUSING_GET_URL];
        } else if (indexPath.row == 2) {
            titleOfList = @"List of Contact";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:CONTACT_GETLIST_URL];
        } else if (indexPath.row == 3) {
            titleOfList = @"List of Contact";
            nameOfField = self.contents[indexPath.section][indexPath.row][0];
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:CONTACT_GETLIST_URL];
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
}

@end
