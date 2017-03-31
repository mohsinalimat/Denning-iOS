//
//  EventViewController.m
//  Denning
//
//  Created by DenningIT on 15/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "EventViewController.h"
#import "EventCell.h"

@interface EventViewController ()
@property (strong, nonatomic) NSArray* eventsArray;
@property (weak, nonatomic) IBOutlet UIImageView *topEventImageView;
@property (weak, nonatomic) IBOutlet UILabel *topEventTitle;
@property (weak, nonatomic) IBOutlet UILabel *topEventContent;
@property (weak, nonatomic) IBOutlet UILabel *topEventDate;

@property (strong, nonatomic) EventModel* latestEvent;

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showTopViews: (BOOL) show
{
    self.topEventImageView.hidden = !show;
    self.topEventDate.hidden = !show;
    self.topEventTitle.hidden = !show;
    self.topEventContent.hidden = !show;
}

- (void) displayLatestNewsOnTop
{
    EventModel* eventModel = self.eventsArray[0];
    NSURL *URL = [NSURL URLWithString:
                  [NSString stringWithFormat:@"data:application/octet-stream;base64,%@",
                   eventModel.imageData]];
    NSData* imageData = [NSData dataWithContentsOfURL:URL];
    
    if (imageData != nil) {
        self.topEventImageView.image = [UIImage imageWithData:imageData];
    }
    
    self.topEventTitle.text = eventModel.FileNo;
    self.topEventContent.text = eventModel.description;
    self.topEventDate.text = eventModel.eventStart;
    
    [self showTopViews:YES];
}


- (void) viewWillAppear:(BOOL)animated
{
    [self geteventsArrayWithCompletion:^{
        [self displayLatestNewsOnTop];
        [self registerNibs];
    }];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}

- (void) prepareUI
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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

- (void)registerNibs {
    
    [EventCell registerForReuseInTableView:self.tableView];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT/2;
}

- (void) geteventsArrayWithCompletion: (void (^)(void))completion
{
    @weakify(self)
    [[QMNetworkManager sharedManager] getLatestEventWithCompletion:^(NSArray * _Nonnull eventsArray, NSError * _Nonnull error) {
        
        @strongify(self)
        if (error == nil) {
            self.eventsArray = eventsArray;
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
    
    return [self.eventsArray count]-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     EventCell *cell = [tableView dequeueReusableCellWithIdentifier:[EventCell cellIdentifier] forIndexPath:indexPath];
    
    cell.tag = indexPath.row;
    [cell configureCellWithEvent:self.eventsArray[indexPath.row+1]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventModel* event = self.eventsArray[indexPath.row+1];
    NSURL* url = [NSURL URLWithString:event.URL];
    
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
