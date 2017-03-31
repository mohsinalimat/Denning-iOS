//
//  NewsUpdatesViewController.m
//  Denning
//
//  Created by DenningIT on 15/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "NewsUpdatesViewController.h"
#import "NewsCell.h"

@interface NewsUpdatesViewController ()

@property (strong, nonatomic) NSArray* newsArray;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *topNewsTitle;
@property (weak, nonatomic) IBOutlet UILabel *topNewsContent;
@property (weak, nonatomic) IBOutlet UILabel *topNewsDate;

@end

@implementation NewsUpdatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self getLatestNewsWithCompletion:^{
        [self prepareUI];
        [self registerNibs];
        [self displayLatestNewsOnTop];
    }];
    
    [super viewWillAppear:animated];
}

- (void) prepareUI
{
    self.title = @"News & Updates";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
}

- (void) displayLatestNewsOnTop
{
    if (self.newsArray.count == 0){
        return;
    }
    NewsModel* newsModel = self.newsArray[0];
    NSURL *URL = [NSURL URLWithString:
                  [NSString stringWithFormat:@"data:application/octet-stream;base64,%@",
                   newsModel.imageData]];
    NSData* imageData = [NSData dataWithContentsOfURL:URL];

    self.topImageView.image = [UIImage imageWithData:imageData];
    self.topNewsTitle.text = newsModel.title;
    self.topNewsContent.text = newsModel.shortDescription;
    self.topNewsDate.text = newsModel.theDateTime;
}

- (void)registerNibs {
    [NewsCell registerForReuseInTableView:self.tableView];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT/2;
}

- (void) getLatestNewsWithCompletion: (void (^)(void))completion
{
    @weakify(self)
    [[QMNetworkManager sharedManager] getLatestNewsWithCompletion:^(NSArray * _Nonnull newsArray, NSError * _Nonnull error) {
        
        @strongify(self)
        if (error == nil) {
            self.newsArray = newsArray;
            if (completion != nil) {
                completion();
                [self.tableView reloadData];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)__unused tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)__unused tableView numberOfRowsInSection:(NSInteger)__unused section {
    
    return [self.newsArray count]-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[NewsCell cellIdentifier] forIndexPath:indexPath];
    
    cell.tag = indexPath.row;
    [cell configureCellWithNews:self.newsArray[indexPath.row+1]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel* news = self.newsArray[indexPath.row+1];
    NSURL* url = [NSURL URLWithString:news.URL];
    
    if (![url.scheme isEqual:@"http"] && ![url.scheme isEqual:@"https"]) {
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
