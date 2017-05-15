//
//  AddMatterViewController.m
//  Denning
//
//  Created by DenningIT on 08/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AddMatterViewController.h"
#import "FloatingTextCell.h"

@interface AddMatterViewController ()<UITableViewDelegate, UITableViewDataSource, ContactListWithDescSelectionDelegate>
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

@implementation AddMatterViewController

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

- (void) registerNib {
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

- (void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
@end
