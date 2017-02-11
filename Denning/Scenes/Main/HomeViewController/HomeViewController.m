//
//  HomeViewController.m
//  Denning
//
//  Created by DenningIT on 01/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsCell.h"
#import "EventCell.h"

@interface HomeViewController ()

@property (strong, nonatomic) NewsModel* latestNews;
@property (strong, nonatomic) EventModel* latestEvent;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerNibs];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getLatestNews];
    [self getLatestEvent];
}

- (void) getLatestNews
{
    @weakify(self)
    [[QMNetworkManager sharedManager] getLatestNewsWithCompletion:^(NewsModel * _Nonnull news, NSError * _Nonnull error) {
       
        @strongify(self)
        if (error == nil) {
            self.latestNews = news;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:rowToReload, nil] withRowAnimation:UITableViewRowAnimationNone];
            });
            
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

- (void) getLatestEvent
{
    @weakify(self)
    [[QMNetworkManager sharedManager] getLatestEventWithCompletion:^(EventModel * _Nonnull event, NSError * _Nonnull error) {
        
        @strongify(self)
        if (error == nil) {
            self.latestEvent = event;
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:0 inSection:1];
                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:rowToReload, nil] withRowAnimation:UITableViewRowAnimationNone];

                });
            } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

- (void)registerNibs {
    
    [NewsCell registerForReuseInTableView:self.tableView];
    [EventCell registerForReuseInTableView:self.tableView];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[NewsCell cellIdentifier] forIndexPath:indexPath];
        
        cell.tag = indexPath.section;
        [cell configureCellWithNews:self.latestNews];
        return cell;
    }
    
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:[EventCell cellIdentifier] forIndexPath:indexPath];
    
    cell.tag = indexPath.section;
    [cell configureCellWithEvent:self.latestEvent];

    
    return cell;
}

- (void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self performSegueWithIdentifier:kTopicReplySegue sender:self.group.topics[indexPath.section]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
