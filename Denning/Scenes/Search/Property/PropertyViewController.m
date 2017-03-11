//
//  PropertyViewController.m
//  Denning
//
//  Created by DenningIT on 09/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "PropertyViewController.h"
#import "CommonTextCell.h"
#import "SearchResultCell.h"

@interface PropertyViewController ()
@property (strong, nonatomic) PropertyModel* propertyModel;
@end

@implementation PropertyViewController
@synthesize responseCell;

- (void) dealloc
{
    NSLog(@"dealloc PropertyViewController");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self registerNibs];
    [self loadProperty];
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:NO];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)registerNibs {
    
    [CommonTextCell registerForReuseInTableView:self.tableView];
    [SearchResultCell registerForReuseInTableView:self.tableView];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadProperty
{
    NSString* code = responseCell.searchCode;
    [[QMNetworkManager sharedManager] loadPropertyfromSearchWithCode:code completion:^(PropertyModel * _Nonnull propertyModel, NSError * _Nonnull error) {
        
        if (!error) {
            self.propertyModel = propertyModel;
            [self.tableView reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && self.propertyModel.fullTitle != nil){
        return 4;
    } else {
        if (self.propertyModel && self.propertyModel.relatedMatter){
            return self.propertyModel.relatedMatter.count;
        } else {
            return 0;
        }
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0){
        CommonTextCell *commonCell = [tableView dequeueReusableCellWithIdentifier:[CommonTextCell cellIdentifier] forIndexPath:indexPath];
        if (indexPath.row == 0){
            [commonCell configureCellWithFixeLabel:@"LotPt" value:self.propertyModel.lotpt];
        } else if (indexPath.row == 1){
            [commonCell configureCellWithFixeLabel:@"Full Title" value:self.propertyModel.fullTitle];
        } else if (indexPath.row == 2){
            [commonCell configureCellWithFixeLabel:@"Address" value:self.propertyModel.address];
        } else if (indexPath.row == 3){
            [commonCell configureCellWithFixeLabel:@"Area" value:self.propertyModel.area];
        }
        
        
        return commonCell;
    }
    
    SearchResultCell *searchResultCell = [tableView dequeueReusableCellWithIdentifier:[SearchResultCell cellIdentifier] forIndexPath:indexPath];
    
    
    return searchResultCell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
