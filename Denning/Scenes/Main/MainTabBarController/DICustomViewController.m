//
//  DICustomViewController.m
//  Denning
//
//  Created by DenningIT on 20/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "DICustomViewController.h"
#import "MainTabBarController.h"

@interface DICustomViewController ()

@end

@implementation DICustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self hideTabBar];
}

- (void) hideTabBar {
    self.tabBarController.tabBar.hidden = YES;
    
    [self configureBackBtnWithImageName:@"Back" withSelector:@selector(popupScreen:)];
//    [self configureMenuRightBtnWithImagename:@"menu_home" withSelector:@selector(popupScreen:)];
}

- (void) configureBackBtnWithImageName:(NSString*) imageName withSelector:(SEL) action {
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
    
    [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //    [backButton setTitle:self.previousScreen forState:UIControlStateNormal];
    [backButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [self.tabBarController.navigationItem setLeftBarButtonItems:@[backButtonItem] animated:YES];
}

- (void) configureMenuRightBtnWithImagename:(NSString*) imageName withSelector:(SEL) action {
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 23)];
    [menuBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    [self.tabBarController.navigationItem setRightBarButtonItems:@[menuButtonItem] animated:YES];
}

- (void) popupScreen:(id)sender {
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.selectedViewController = self.tabBarController.viewControllers[0];
    
    [self configureMenuRightBtnWithImagename:@"icon_menu" withSelector:@selector(gotoMenu)];
    [self configureBackBtnWithImageName:@"icon_user" withSelector:@selector(gotoLogin)];
}

- (void) gotoLogin {
    MainTabBarController *mainTabBarController = (MainTabBarController*)self.tabBarController;
    [mainTabBarController tapLogin:nil];
}

- (void) gotoMenu {
    MainTabBarController *mainTabBarController = (MainTabBarController*)self.tabBarController;
    [mainTabBarController tapMenu:nil];
}

@end
