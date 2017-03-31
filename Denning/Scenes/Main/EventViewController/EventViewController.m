//
//  EventViewController.m
//  Denning
//
//  Created by DenningIT on 15/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventContent;
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;

@property (strong, nonatomic) EventModel* latestEvent;

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self getLatestEvent];
    [super viewWillAppear:animated];
}

- (void) getLatestEvent
{
    @weakify(self)
    [[QMNetworkManager sharedManager] getLatestEventWithCompletion:^(EventModel * _Nonnull event, NSError * _Nonnull error) {
        
        @strongify(self)
        if (error == nil) {
            self.latestEvent = event;
            self.eventTitle.text = self.latestEvent.description;
            NSURL *URL = [NSURL URLWithString:
                          [NSString stringWithFormat:@"data:application/octet-stream;base64,%@",
                           self.latestEvent.imageData]];
            NSData* imageData = [NSData dataWithContentsOfURL:URL];

            self.eventImageView.image = [UIImage imageWithData:imageData];
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
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
