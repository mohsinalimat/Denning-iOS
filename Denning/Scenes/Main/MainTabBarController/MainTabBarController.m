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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray *)menuItems
{
    if (!_menuItems)
    {
        _menuItems =
        @[
          [RWDropdownMenuItem itemWithText:@"Twitter" image:[UIImage imageNamed:@"icon_twitter"] action:nil],
          [RWDropdownMenuItem itemWithText:@"Facebook" image:[UIImage imageNamed:@"icon_facebook"] action:nil],
          [RWDropdownMenuItem itemWithText:@"Message" image:[UIImage imageNamed:@"icon_message"] action:nil],
          [RWDropdownMenuItem itemWithText:@"Email" image:[UIImage imageNamed:@"icon_email"] action:nil],
          [RWDropdownMenuItem itemWithText:@"Save to Photo Album" image:[UIImage imageNamed:@"icon_album"] action:nil],
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
