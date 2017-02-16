//
//  NewsUpdatesViewController.m
//  Denning
//
//  Created by DenningIT on 15/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "NewsUpdatesViewController.h"

@interface NewsUpdatesViewController ()

@property (strong, nonatomic) NewsModel* latestNews;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsContent;

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
    [self getLatestNews];
    [super viewWillAppear:animated];
}

- (void) getLatestNews
{
    @weakify(self)
    [[QMNetworkManager sharedManager] getLatestNewsWithCompletion:^(NewsModel * _Nonnull news, NSError * _Nonnull error) {
        
        @strongify(self)
        if (error == nil) {
            self.latestNews = news;
            self.newsTitle.text = self.latestNews.title;
            NSURL *URL = [NSURL URLWithString:
                          [NSString stringWithFormat:@"data:application/octet-stream;base64,%@",
                           self.latestNews.imageData]];
            NSData* imageData = [NSData dataWithContentsOfURL:URL];
            self.newsImageView.image = [UIImage imageWithData:imageData];
            
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
