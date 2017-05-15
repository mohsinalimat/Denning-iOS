//
//  WelcomeViewController.m
//  Denning
//
//  Created by DenningIT on 25/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "WelcomeViewController.h"
#import "BranchViewController.h"

typedef NS_ENUM(NSInteger, DIUserType) {
    DILawFirmStaff,
    DILawFirmClient,
    DIPublicUser
};

@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *denningBtn;
@property (weak, nonatomic) IBOutlet UIButton *bussinessBtn;
@property (weak, nonatomic) IBOutlet UIButton *personalBtn;

@property (nonatomic) DIUserType userType;
@property (strong, nonatomic) NSMutableArray* denningArray;
@property (strong, nonatomic) NSMutableArray* businessArray;
@property (strong, nonatomic) NSMutableArray* personalArray;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self reArrangeUserTypeBtn];
}

- (void) reArrangeUserTypeBtn
{
    if ([DataManager sharedManager].denningArray.count > 0) {
        self.denningBtn.hidden = NO;
    } else {
        self.denningBtn.hidden = YES;
    }
    
    if ([DataManager sharedManager].personalArray.count > 0) {
        self.personalBtn.hidden = NO;
    } else {
        self.personalBtn.hidden = YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    BranchViewController* branchVC = segue.destinationViewController;
    branchVC.firmArray = sender;
}


@end
