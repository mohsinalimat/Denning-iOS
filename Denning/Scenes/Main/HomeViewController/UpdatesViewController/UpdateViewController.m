//
//  UpdateViewController.m
//  Denning
//
//  Created by DenningIT on 24/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "UpdateViewController.h"
#import "NewsCell.h"

@interface UpdateViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *topNewsTitle;
@property (weak, nonatomic) IBOutlet UILabel *topNewsContent;
@property (weak, nonatomic) IBOutlet UILabel *topNewsDate;

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self displayLatestNewsOnTop];
    [self registerNibs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareUI
{
    self.title = @"Updates";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
    self.tableView.tableFooterView = [UIView new];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 13, 23)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onBackAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [self.navigationItem setLeftBarButtonItems:@[backButtonItem] animated:YES];
}

- (void) onBackAction: (id) sender
{
    [self.view endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) viewWillAppear:(BOOL)animated
{  
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

- (void) displayLatestNewsOnTop
{
    if (self.updatesArray.count == 0){
        return;
    }
    NewsModel* newsModel = self.updatesArray[0];
    NSURL *URL = [NSURL URLWithString:
                  [NSString stringWithFormat:@"data:application/octet-stream;base64,%@",
                   newsModel.imageData]];
    NSData* imageData = [NSData dataWithContentsOfURL:URL];
    
    if (imageData != nil) {
        self.topImageView.image = [UIImage imageWithData:imageData];
    }
    
    self.topNewsTitle.text = newsModel.title;
    self.topNewsContent.text = newsModel.shortDescription;
    self.topNewsDate.text = [DIHelpers getDateInShortForm:newsModel.theDateTime] ;
}

- (void)registerNibs {
    [NewsCell registerForReuseInTableView:self.tableView];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT/2;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)__unused tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)__unused tableView numberOfRowsInSection:(NSInteger)__unused section {
    
    return [self.updatesArray count]-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[NewsCell cellIdentifier] forIndexPath:indexPath];
    
    cell.tag = indexPath.row;
    [cell configureCellWithNews:self.updatesArray[indexPath.row+1]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel* news = self.updatesArray[indexPath.row+1];
    NSURL* url = [NSURL URLWithString:news.URL];
    
    if (![url.scheme isEqual:@"http"] && ![url.scheme isEqual:@"https"]) {
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
        }
    }
    
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
