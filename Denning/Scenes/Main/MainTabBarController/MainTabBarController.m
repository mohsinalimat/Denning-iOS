//
//  MainTabBarController.m
//  Denning
//
//  Created by DenningIT on 02/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()
@property (nonatomic, strong) NSArray *menuItems;


@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIImage *img = [UIImage imageNamed:@"denning_logo_white.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    [imgView setImage:img];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray *)menuItems
{
    if (!_menuItems)
    {
        NSString* userInfo = [DataManager sharedManager].user.username;
        if (userInfo.length == 0) {
            userInfo = @"Login";
        }
        
        _menuItems =
        @[
          [RWDropdownMenuItem itemWithText:userInfo image:[UIImage imageNamed:@"icon_profile"] action:^{
              
          }],
          
          [RWDropdownMenuItem itemWithText:@"Home" image:[UIImage imageNamed:@"home"] action:^{
              
          }],
          
          [RWDropdownMenuItem itemWithText:@"Add" image:[UIImage imageNamed:@"icon_add"] action:^{
              
          }],
          
          [RWDropdownMenuItem itemWithText:@"Overview" image:[UIImage imageNamed:@"icon_overview"] action:^{
              
          }],
          
          [RWDropdownMenuItem itemWithText:@"Our Products" image:[UIImage imageNamed:@"icon_our_product"] action:^{
            
          }],
          
          [RWDropdownMenuItem itemWithText:@"Help" image:[UIImage imageNamed:@"icon_help"] action:^{
              
          }],
          
          [RWDropdownMenuItem itemWithText:@"Settings" image:[UIImage imageNamed:@"icon_settings"] action:^{
              
          }],
          
          [RWDropdownMenuItem itemWithText:@"Contact Us" image:[UIImage imageNamed:@"icon_phone"] action:^{
              
          }],
          
          [RWDropdownMenuItem itemWithText:@"Terms of Uses" image:[UIImage imageNamed:@"icon_termsOfUses"] action:^{
              
          }],
          
          [RWDropdownMenuItem itemWithText:@"Log out" image:[UIImage imageNamed:@"icon_signout"] action:^{
              
          }],
        ];
    }
    return _menuItems;
}


- (IBAction)tapMenu:(id)sender {
    [RWDropdownMenu presentFromViewController:self withItems:self.menuItems align:RWDropdownMenuCellAlignmentRight style:RWDropdownMenuStyleBlackGradient navBarImage:[(UIBarItem*)sender image] completion:nil];
}

- (IBAction)tapLogin:(id)sender {
    [self performSegueWithIdentifier:kAuthSegue sender:nil];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
