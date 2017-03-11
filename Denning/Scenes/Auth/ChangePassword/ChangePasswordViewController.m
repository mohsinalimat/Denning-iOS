//
//  ChangePasswordViewController.m
//  Denning
//
//  Created by DenningIT on 07/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *newpasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareUI];
}

- (void) prepareUI
{
    self.title = @"Change Password";
    
    UIBarButtonItem *confirmButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Confirm" style:UIBarButtonItemStylePlain target:self action:@selector(changePassword:)];
    
    [self.navigationItem setRightBarButtonItems:@[ confirmButtonItem] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePassword:(id)sender {
    NSString *password1 = self.newpasswordTextField.text;
    NSString *password2 = self.confirmPasswordTextField.text;
    
    if (password1.length == 0 || password2.length == 0) {
        [self.navigationController showNotificationWithType:QMNotificationPanelTypeWarning message:NSLocalizedString(@"QM_STR_FILL_IN_ALL_THE_FIELDS", nil) duration:kQMDefaultNotificationDismissTime];
        return;
    } else if (![password1 isEqualToString:password2]){
        [self.navigationController showNotificationWithType:QMNotificationPanelTypeWarning message:@"Password should be matching" duration:kQMDefaultNotificationDismissTime];
        return;
    }
    
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading
                                                message:NSLocalizedString(@"QM_STR_LOADING", nil)
                                               duration:0];
    
    __weak UINavigationController *navigationController = self.navigationController;
    @weakify(self);

    [[QMNetworkManager sharedManager] changePasswordAfterLoginWithEmail:[DataManager sharedManager].user.email password:password1 withCompletion:^(BOOL success, NSString * _Nonnull error, NSDictionary * _Nonnull response) {
        @strongify(self)
        [navigationController dismissNotificationPanel];
        if (success){
            [[DataManager sharedManager] setUserInfoFromChangePassword:response];
            [self performSegueWithIdentifier:kQMSceneSegueMain sender:nil];
        }
        
        [self.navigationController showNotificationWithType:QMNotificationPanelTypeWarning message:error duration:kQMDefaultNotificationDismissTime];
    }];
}

- (IBAction)skipChange:(id)sender {
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
