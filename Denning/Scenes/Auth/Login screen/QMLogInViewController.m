//
//  QMLogInViewController.m
//  Q-municate
//
//  Created by Igor Alefirenko on 13/02/2014.
//  Copyright (c) 2014 Quickblox. All rights reserved.
//

#import "QMLogInViewController.h"
#import "QMCore.h"
#import "UINavigationController+QMNotification.h"

@interface QMLogInViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) BFTask *task;

@end

@implementation QMLogInViewController

- (void)dealloc {
    ILog(@"%@ - %@",  NSStringFromSelector(_cmd), self);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.emailField becomeFirstResponder];
}

#pragma mark - Actions

- (IBAction)done:(id)__unused sender {
    
    [self.view endEditing:YES];
    
    if (self.task != nil) {
        // task in progress
        return;
    }
    
    NSString *email = self.emailField.text;
    NSString *password = self.passwordField.text;
    
    if (email.length == 0 || password.length == 0) {
        
        [self.navigationController showNotificationWithType:QMNotificationPanelTypeWarning message:NSLocalizedString(@"QM_STR_FILL_IN_ALL_THE_FIELDS", nil) duration:kQMDefaultNotificationDismissTime];
    }
    else if ([[QMNetworkManager sharedManager].invalidTry intValue] >= 1){
        NSDate* currentTime = [[NSDate alloc] init];
        float duration = [currentTime timeIntervalSinceDate:[QMNetworkManager sharedManager].startTrackTimeForLogin];
        if (fabsf(duration) < 60){
            [self.navigationController showNotificationWithType:QMNotificationPanelTypeWarning message:@"Locked for 1 minutes. invalid username and password more than 10 times..." duration:kQMDefaultNotificationDismissTime];
        } else {
            [self loginWithEmail:email password:password];
        }
    } else {
        [self loginWithEmail:email password:password];
    }
}

- (void) loginWithEmail: (NSString*) email password:(NSString*) password
{
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading
                                                message:NSLocalizedString(@"QM_STR_LOADING", nil)
                                               duration:0];
    
    __weak UINavigationController *navigationController = self.navigationController;
    @weakify(self);
    [[QMNetworkManager sharedManager] userSignInWithEmail:email password:password withCompletion:^(BOOL success, NSString * _Nonnull error, NSInteger statusCode) {
        
        @strongify(self)

        if (success){
            [navigationController dismissNotificationPanel];
            [self performSegueWithIdentifier:kQMSceneSegueMain sender:nil];
        } else {
            if (statusCode == 401) {
                int value = [[QMNetworkManager sharedManager].invalidTry intValue];
                [QMNetworkManager sharedManager].invalidTry = [NSNumber numberWithInt:value+1];
                
                if (value >= 1){
                    error = @"Locked for 1 minutes. invalid username and password more than 10 times...";
                    [QMNetworkManager sharedManager].startTrackTimeForLogin = [[NSDate alloc] init];
                }
            } 
            
            [self.navigationController showNotificationWithType:QMNotificationPanelTypeWarning message:error duration:kQMDefaultNotificationDismissTime];
        }
    }];
}

@end
