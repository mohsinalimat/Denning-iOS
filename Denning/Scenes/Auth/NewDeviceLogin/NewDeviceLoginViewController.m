//
//  NewDeviceLoginViewController.m
//  Denning
//
//  Created by DenningIT on 06/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "NewDeviceLoginViewController.h"

@interface NewDeviceLoginViewController()
@property (weak, nonatomic) IBOutlet UITextField *TACTextField;

@end

@implementation NewDeviceLoginViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self prepareUI];
}

- (void) prepareUI
{
    self.title = @"New Device Login";
   
    UIBarButtonItem *confirmButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Confirm" style:UIBarButtonItemStylePlain target:self action:@selector(confirmTAC)];
    
    [self.navigationItem setRightBarButtonItems:@[ confirmButtonItem] animated:YES];
}

- (void) confirmTAC {
    if (self.TACTextField.text.length < 1){
        return;
    }
    
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading
                                                message:NSLocalizedString(@"QM_STR_LOADING", nil)
                                               duration:0];
    
    __weak UINavigationController *navigationController = self.navigationController;
    @weakify(self);
    [[QMNetworkManager sharedManager] sendSMSForNewDeviceWithEmail:[DataManager sharedManager].user.email activationCode:self.TACTextField.text withCompletion:^(BOOL success, NSString * _Nonnull error, NSDictionary * _Nonnull response) {
        @strongify(self);
        if (!success) {
            
            [navigationController showNotificationWithType:QMNotificationPanelTypeFailed message:error duration:kQMDefaultNotificationDismissTime];
        }
        else {
            [[DataManager sharedManager] setUserInfoFromNewDeviceLogin:response];
            
            [navigationController showNotificationWithType:QMNotificationPanelTypeSuccess message:@"SMS is sent to your phone" duration:kQMDefaultNotificationDismissTime];
            [self performSegueWithIdentifier:kChangePasswordSegue sender:nil];
        }
    }];
}

- (IBAction)resendSMSTAC:(id)sender {
    self.TACTextField.text = @"";
    
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading
                                                message:NSLocalizedString(@"QM_STR_LOADING", nil)
                                               duration:0];
    
    __weak UINavigationController *navigationController = self.navigationController;

    [[QMNetworkManager sharedManager] sendSMSRequestWithEmail:[DataManager sharedManager].user.email phoneNumber:[DataManager sharedManager].user.phoneNumber reason:@"from new device login" withCompletion:^(BOOL success, NSString * _Nonnull error, NSDictionary * _Nonnull response) {

        if (!success) {
            [navigationController showNotificationWithType:QMNotificationPanelTypeFailed message:error duration:kQMDefaultNotificationDismissTime];
        }
        else {
            [[DataManager sharedManager] setUserInfoFromNewDeviceLogin:response];
            
            [navigationController showNotificationWithType:QMNotificationPanelTypeSuccess message:@"SMS is sent to your phone" duration:kQMDefaultNotificationDismissTime];
        }
    }];
}

@end
