//
//  QMForgotPasswordTVC.m
//  Qmunicate
//
//  Created by Andrey Ivanov on 30.06.14.
//  Copyright (c) 2014 Quickblox. All rights reserved.
//

#import "QMForgotPasswordViewController.h"
#import "QMTasks.h"
#import "UINavigationController+QMNotification.h"

@interface QMForgotPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *TACTextField;

@property (weak, nonatomic) BFTask *task;

@end

@implementation QMForgotPasswordViewController

- (void)dealloc {
    ILog(@"%@ - %@",  NSStringFromSelector(_cmd), self);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.emailTextField becomeFirstResponder];
    
    // initialize the number of bad try to log in
    [QMNetworkManager sharedManager].invalidTry = @0;
}

#pragma mark - actions

- (IBAction)pressResetPasswordBtn:(id)__unused sender {
    
    if (self.task != nil) {
        // task in progress
        return;
    }
    
    NSString *email = self.emailTextField.text;
    
    if (email.length > 0) {
        
        [self resetPasswordForMail:email];
    }
    else {
        
        [self.navigationController showNotificationWithType:QMNotificationPanelTypeWarning message:NSLocalizedString(@"QM_STR_EMAIL_FIELD_IS_EMPTY", nil) duration:kQMDefaultNotificationDismissTime];
    }
}

- (void)resetPasswordForMail:(NSString *)emailString {

    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading
                                                message:NSLocalizedString(@"QM_STR_LOADING", nil)
                                               duration:0];
    
    __weak UINavigationController *navigationController = self.navigationController;
    
    @weakify(self);
    self.task = [[QMTasks taskResetPasswordForEmail:emailString] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        
        @strongify(self);
        if (task.isFaulted) {
            
            [navigationController showNotificationWithType:QMNotificationPanelTypeFailed message:NSLocalizedString(@"QM_STR_USER_WITH_EMAIL_WASNT_FOUND", nil) duration:kQMDefaultNotificationDismissTime];
        }
        else {
            
            [navigationController showNotificationWithType:QMNotificationPanelTypeSuccess message:NSLocalizedString(@"QM_STR_MESSAGE_WAS_SENT_TO_YOUR_EMAIL", nil) duration:kQMDefaultNotificationDismissTime];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        return nil;
    }];
}

- (IBAction)requestSMS:(id)sender {
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading
                                                message:NSLocalizedString(@"QM_STR_LOADING", nil)
                                               duration:0];
    
    __weak UINavigationController *navigationController = self.navigationController;
    
    [[QMNetworkManager sharedManager] sendSMSRequestWithEmail:self.emailTextField.text phoneNumber:self.phoneNumberTextField.text reason:@"from Forget Password form" withCompletion:^(BOOL success, NSString * _Nonnull error) {
        
        if (!success) {
            
            [navigationController showNotificationWithType:QMNotificationPanelTypeFailed message:error duration:kQMDefaultNotificationDismissTime];
        }
        else {
            
            [navigationController showNotificationWithType:QMNotificationPanelTypeSuccess message:@"SMS is sent to your phone" duration:kQMDefaultNotificationDismissTime];
        }

    }];
}

- (IBAction)forgotPassword:(id)sender {
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading
                                                message:NSLocalizedString(@"QM_STR_LOADING", nil)
                                               duration:0];
    
    __weak UINavigationController *navigationController = self.navigationController;

    [[QMNetworkManager sharedManager] requestForgetPasswordWithEmail:self.emailTextField.text phoneNumber:self.phoneNumberTextField.text activationCode:self.TACTextField.text withCompletion:^(BOOL success, NSString * _Nonnull error) {
        
        if (!success) {
            [navigationController showNotificationWithType:QMNotificationPanelTypeFailed message:error duration:kQMDefaultNotificationDismissTime];
        }
        else {
            [navigationController showNotificationWithType:QMNotificationPanelTypeSuccess message:@"SMS is sent to your phone" duration:kQMDefaultNotificationDismissTime];
        }
    }];
}

@end
