//
//  DashboardViewController.m
//  Denning
//
//  Created by DenningIT on 20/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "DashboardViewController.h"
#import "TwoColumnWithDotCell.h"
#import "ThreeColumWithDotCell.h"
#import "MaterListingViewController.h"
#import "DashboardContactListViewController.h"
#import "OneRowWithDot.h"
#import "LineGraphCell.h"
#import "DashboardStyle4Cell.h"
#import "DashboardTaxInvoiceViewController.h"
#import "BankCashViewController.h"
#import "DashboardFeeTransferViewController.h"


@interface DashboardViewController ()
<UIDocumentInteractionControllerDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SWTableViewCellDelegate>
{
    NSString *titleOfList;
    NSString* nameOfField;
    __block BOOL isLoading;
    __block BOOL isSaved;
    
    NSMutableArray* xAxisData, *yAxisData;
}

@property (weak, nonatomic) IBOutlet FZAccordionTableView *tableView;
@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) NSMutableArray *headers;

@property (strong, nonatomic) ThreeItemModel* initialModel;

@property (strong, nonatomic)
NSMutableDictionary* keyValue;

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareUI];
    [self registerNib];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareUI {
    self.navigationController.tabBarItem.image = [UIImage imageNamed:@"icon_overview"];

    self.keyValue = [@{@(0): @(1), @(1): @(0), @(0): @(0), @(1): @(0), @(0): @(0), @(1): @(0), @(0): @(0), @(1): @(0), @(0): @(0), @(1): @(0), @(0): @(0)} mutableCopy];
    _contents = [NSMutableArray new];
    _headers = [NSMutableArray new];
    yAxisData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 30; i++) {
        [yAxisData addObject:[NSNumber numberWithLong:random() % 100]];
    }
    
    xAxisData = [[NSMutableArray alloc] init];
    for (int i = 1; i <= 30; i++) {
        [xAxisData addObject:[NSString stringWithFormat:@"%d Jun", i]];
    }
}

- (void) addItemToContentsInIndex: (NSNumber*) index withItem: (NSArray*) item
{
    NSMutableArray* newConents = [NSMutableArray new];
    if (_contents.count == 0) {
        [newConents addObjectsFromArray:item];
    } else {
        BOOL isAdded = NO;
        for (NSArray* obj in _contents) {
            if ([obj[0] integerValue] == [index integerValue]) {
                isAdded = YES;
                [newConents addObjectsFromArray:item];
            } else {
                [newConents addObjectsFromArray:@[obj]];
            }
        }
        if (!isAdded) {
            [newConents addObjectsFromArray:item];
        }
    }

    _contents = [newConents mutableCopy];
}

- (void) makeHeaders:(NSArray*) main {
    _headers = [NSMutableArray new];
    for (VisibleModel* obj in main) {
        if ([obj.isVisible integerValue] == 1) {
            [_headers addObject:obj];
        }
    }
}

- (void) getDashbardWithAPI:(NSString*)api inSessionID:(NSNumber*)sessionID  withCompletion: (void(^)(void)) completion
{
    if (isLoading) return;
    isLoading = YES;
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:NSLocalizedString(@"QM_STR_LOADING", nil) duration:0];
    __weak UINavigationController *navigationController = self.navigationController;
    NSString* url = [NSString stringWithFormat:@"%@denningwcf/%@", [DataManager sharedManager].user.serverAPI, api];
    @weakify(self);
    [[QMNetworkManager sharedManager] getDashboardThreeItmesInURL:url withCompletion:^(ThreeItemModel * _Nonnull result, NSError * _Nonnull error) {
       @strongify(self)
        self->isLoading = NO;
        if (error == nil) {
            [navigationController showNotificationWithType:QMNotificationPanelTypeSuccess message:@"Success" duration:1.0];
            self.initialModel = result;
            [self makeHeaders:_initialModel.main];
            [self addItemToContentsInIndex:sessionID withItem:@[@[sessionID, _initialModel.items]]];
            
            if (completion != nil) {
                completion();
            }
        } else {
            [navigationController showNotificationWithType:QMNotificationPanelTypeWarning message:error.localizedDescription duration:1.0];
        }
    }];
}

- (void) changeTitle {
    self.tabBarController.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.title = @"DASHBOARD";
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hideTabBar];
    [self changeTitle];

    
    [self getDashbardWithAPI:@"v1/app/dashboard/S1" inSessionID:@(1) withCompletion:^{
        [self.tableView reloadData];
    }];
 
}

- (void) registerNib {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
    
    self.tableView.allowMultipleSectionsOpen = YES;
    self.tableView.initialOpenSections = [NSSet setWithObjects:@(1), @(0), nil];
    // Hide empty separators
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [TwoColumnWithDotCell registerForReuseInTableView:self.tableView];
    [ThreeColumWithDotCell registerForReuseInTableView:self.tableView];
    [OneRowWithDot registerForReuseInTableView:self.tableView];
    [LineGraphCell registerForReuseInTableView:self.tableView];
    [DashboardStyle4Cell registerForReuseInTableView:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT * 2;
}


- (NSInteger) calcTag: (NSIndexPath*) indexPath {
    NSInteger tag = 0;
    for (int i = 0; i < [_contents count]; i++) {
        if (i < indexPath.section) {
            tag += [_contents[i] count];
        }
    }
    
    tag += indexPath.row;
    
    return tag;
}

- (NSArray*) calcSectionNumber: (NSInteger) tag {
    NSInteger section = 0;
    NSInteger remain = tag;
    for (int i = 0; i < self.tableView.numberOfSections; i++) {
        section = i;
        if (remain - (NSInteger)[_contents[i] count] < 0) {
            break;
        }
        remain = (remain - (NSInteger)[_contents[i] count]);
    }
    
    return @[@(section), @(remain)];
}

- (NSArray*) itemsFromIndexpath: (NSIndexPath*) indexPath{
    NSArray* items = @[];
    for (NSArray* obj in _contents) {
        if ([obj[0] integerValue] == indexPath.section + 1) {
            items = [obj[1] mutableCopy];
            break;
        }
    }
    return items;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    VisibleModel* model = _headers[section];
    NSInteger count = 0;
    for (NSArray* obj in _contents) {
        if ([obj[0] integerValue] == section + 1) {
            count = [obj[1] count];
            if (count > 1 && ([model.iStyle integerValue] == 1 ||[model.iStyle integerValue] == 6)) {
                count = 1;
            }
        }
    }
    
    if ([model.iStyle integerValue] == 5) {
        count = _initialModel.graphs.count;
    }
    
    return count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VisibleModel* model = _headers[indexPath.section];
    if ([model.iStyle integerValue] == 1) {
        return 55;
    } else if ([model.iStyle integerValue] == 3 || [model.iStyle integerValue] == 4) {
        return 55;
    }else if ([model.iStyle integerValue] == 5) {
        return 320;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VisibleModel* visibleModel = _headers[indexPath.section];
    if ([visibleModel.iStyle integerValue] == 1) {
        ThreeColumWithDotCell *cell = [tableView dequeueReusableCellWithIdentifier:[ThreeColumWithDotCell cellIdentifier] forIndexPath:indexPath];
        NSArray* items = [self itemsFromIndexpath:indexPath];
        
        cell.allViewHandler = ^{
            if ([((VisibleModel*)_headers[indexPath.section]).sessionName  isEqualToString:@"MATTERS"]) {
                [self performSegueWithIdentifier:kDashboardMatterSegue sender:items[0]];
            } else {
                [self performSegueWithIdentifier:kDashboardContactSegue sender:items[0]];
            }
        };
        cell.todayViewHandler = ^{
            if ([((VisibleModel*)_headers[indexPath.section]).sessionName  isEqualToString:@"MATTERS"]) {
                [self performSegueWithIdentifier:kDashboardMatterSegue sender:items[1]];
            } else {
                [self performSegueWithIdentifier:kDashboardContactSegue sender:items[1]];
            }
        };
        cell.thisWeekViewHandler = ^{
            if ([((VisibleModel*)_headers[indexPath.section]).sessionName  isEqualToString:@"MATTERS"]) {
                [self performSegueWithIdentifier:kDashboardMatterSegue sender:items[2]];
            } else {
                [self performSegueWithIdentifier:kDashboardContactSegue sender:items[2]];
            }
        };
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        [cell configureCellWithFirstItem:items[0] secondItem:items[1] thirdItem:items[2]];
        return cell;
    } else if ([visibleModel.iStyle integerValue] == 3) {
        NSArray* items = [self itemsFromIndexpath:indexPath];
        OneRowWithDot *cell = [tableView dequeueReusableCellWithIdentifier:[OneRowWithDot cellIdentifier] forIndexPath:indexPath];
        cell.leftLabel.text = ((ItemModel*)items[indexPath.row]).label;
        cell.dotValue.text = ((ItemModel*)items[indexPath.row]).value;
        return cell;
    } else if ([visibleModel.iStyle integerValue] == 4) {
        NSArray* items = [self itemsFromIndexpath:indexPath];
        DashboardStyle4Cell *cell = [tableView dequeueReusableCellWithIdentifier:[DashboardStyle4Cell cellIdentifier] forIndexPath:indexPath];
        cell.leftLabel.text = ((ItemModel*)items[indexPath.row]).label;
        cell.value.text = ((ItemModel*)items[indexPath.row]).value;
        return cell;
    } else if ([visibleModel.iStyle integerValue] == 5) {
        LineGraphCell *cell = [tableView dequeueReusableCellWithIdentifier:[LineGraphCell cellIdentifier] forIndexPath:indexPath];
        GraphModel* graph = _initialModel.graphs[indexPath.row];
        [cell createLineGraph:self.tableView withGraphModel:graph];
        
        return cell;
    } else if ([visibleModel.iStyle integerValue] == 6) {
        NSArray* items = [self itemsFromIndexpath:indexPath];
        TwoColumnWithDotCell *cell = [tableView dequeueReusableCellWithIdentifier:[TwoColumnWithDotCell cellIdentifier] forIndexPath:indexPath];
        [cell configureCellWithFirstItem:items[0] secondItem:items[1]];
        return cell;
    }
    
    return nil;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kDefaultAccordionHeaderViewHeight;
}

//- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 10;
//}

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
    headerView.headerTitle.text = ((VisibleModel*)self.headers[section]).sessionName;
    
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

#pragma mark - <FZAccordionTableViewDelegate> -

- (void)tableView:(FZAccordionTableView *)tableView willOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        VisibleModel* visibleModel = _headers[section];
        [self getDashbardWithAPI:visibleModel.sessionAPI inSessionID:visibleModel.sessionID withCompletion:^{
            self.keyValue[[NSNumber numberWithInteger:section]] = @(1);
            
            [self.tableView reloadData];
            [self reloadHeaders];
        }];
    });
    
}

- (void)tableView:(FZAccordionTableView *)tableView didOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
   
}

- (void)tableView:(FZAccordionTableView *)tableView willCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
    self.keyValue[[NSNumber numberWithInteger:section]] = @(0);
    [self reloadHeaders];
}

- (void)tableView:(FZAccordionTableView *)tableView didCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header {
    
}

- (void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ItemModel* item;
    for (NSArray* obj in _contents) {
        if ([obj[0] integerValue] == indexPath.section + 1) {
            item = obj[1][indexPath.row];
        }
    }
    
    if ([((VisibleModel*)_headers[indexPath.section]).sessionName  isEqualToString:@"BANK & CASH BALANCES"]) {
        [self performSegueWithIdentifier:kBankCashSegue sender:item];
    } else if ([((VisibleModel*)_headers[indexPath.section]).sessionName  isEqualToString:@"TAX INVOICES"]) {
        [self performSegueWithIdentifier:kDashboardTaxInvoiceSegue sender:item];
    } else if ([((VisibleModel*)_headers[indexPath.section]).sessionName  isEqualToString:@"FEES TRANSFER"]) {
        [self performSegueWithIdentifier:kDashboardFeesTranserSegue sender:item];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:kDashboardMatterSegue]) {
        UINavigationController* navVC = segue.destinationViewController;
        MaterListingViewController* vc = navVC.viewControllers.firstObject;
        
        vc.url = ((ItemModel*)sender).api;
        vc.updateHandler = ^(NewMatterModel *model) {
            
        };
    }
    
    if ([segue.identifier isEqualToString:kDashboardContactSegue]) {
        UINavigationController* navVC = segue.destinationViewController;
        DashboardContactListViewController* vc = navVC.viewControllers.firstObject;
        
        vc.url = ((ItemModel*)sender).api;
    }
    
    if ([segue.identifier isEqualToString:kDashboardTaxInvoiceSegue]) {
        UINavigationController* navVC = segue.destinationViewController;
        DashboardTaxInvoiceViewController* vc = navVC.viewControllers.firstObject;
        
        vc.url = ((ItemModel*)sender).api;
    }
    
    if ([segue.identifier isEqualToString:kBankCashSegue]) {
        UINavigationController* navVC = segue.destinationViewController;
        BankCashViewController* vc = navVC.viewControllers.firstObject;
        
        vc.url = ((ItemModel*)sender).api;
    }
    
    if ([segue.identifier isEqualToString:kDashboardFeesTranserSegue]) {
        UINavigationController* navVC = segue.destinationViewController;
        DashboardFeeTransferViewController* vc = navVC.viewControllers.firstObject;
        
        vc.url = ((ItemModel*)sender).api;
    }
}


@end
