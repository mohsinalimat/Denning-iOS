//
//  SplashControllerViewController.m
//  Q-municate
//
//  Created by Igor Alefirenko on 13/02/2014.
//  Copyright (c) 2014 Quickblox. All rights reserved.
//

#import "QMWelcomeScreenViewController.h"
#import "QMAlert.h"
#import <SVProgressHUD.h>

#import "QMFacebook.h"
#import "QMCore.h"
#import "QMContent.h"
#import "QMTasks.h"

#import <DigitsKit/DigitsKit.h>
#import "QMDigitsConfigurationFactory.h"

static NSString * const kQMFacebookIDField = @"id";

@implementation QMWelcomeScreenViewController

- (void)dealloc {
    
    ILog(@"%@ - %@",  NSStringFromSelector(_cmd), self);
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}




#pragma mark - Actions
- (IBAction)gotoMainView:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signUp:(UIButton *)sender {
    

}

- (IBAction)signIn:(UIButton *)sender {
    
}

- (void)chainFacebookConnect {
    
    @weakify(self);
    [[[QMFacebook connect] continueWithBlock:^id _Nullable(BFTask<NSString *> * _Nonnull task) {
        // Facebook connect
        if (task.isFaulted || task.isCancelled) {
            
            return nil;
        }
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        
        return [[QMCore instance].authService loginWithFacebookSessionToken:task.result];
        
    }] continueWithBlock:^id _Nullable(BFTask<QBUUser *> * _Nonnull task) {
        
        if (task.isFaulted) {
            
            [QMFacebook logout];
        }
        else if (task.result != nil) {
            
            @strongify(self);
            [SVProgressHUD dismiss];
            [self performSegueWithIdentifier:kQMSceneSegueMain sender:nil];
            [QMCore instance].currentProfile.accountType = QMAccountTypeFacebook;
            [[QMCore instance].currentProfile synchronizeWithUserData:task.result];
            
            if (task.result.avatarUrl.length == 0) {
                
                return [[[QMFacebook loadMe] continueWithSuccessBlock:^id _Nullable(BFTask<NSDictionary *> * _Nonnull loadTask) {
                    // downloading user avatar from url
                    NSURL *userImageUrl = [QMFacebook userImageUrlWithUserID:loadTask.result[kQMFacebookIDField]];
                    return [QMContent downloadImageWithUrl:userImageUrl];
                    
                }] continueWithSuccessBlock:^id _Nullable(BFTask<UIImage *> * _Nonnull imageTask) {
                    // uploading image to content module
                    return [QMTasks taskUpdateCurrentUserImage:imageTask.result progress:nil];
                }];
            }
            
            return [[QMCore instance].pushNotificationManager subscribeForPushNotifications];
        }
        
        return nil;
    }];
}

- (void)performDigitsLogin {
    
    @weakify(self);
    [[Digits sharedInstance] authenticateWithViewController:nil configuration:[QMDigitsConfigurationFactory qmunicateThemeConfiguration] completion:^(DGTSession *session, NSError *error) {
        @strongify(self);
        // twitter digits auth
        if (error.userInfo.count > 0) {
            
            [QMAlert showAlertWithMessage:NSLocalizedString(@"QM_STR_UNKNOWN_ERROR", nil) actionSuccess:NO inViewController:self];
        }
        else {
            
            DGTOAuthSigning *oauthSigning = [[DGTOAuthSigning alloc] initWithAuthConfig:[Digits sharedInstance].authConfig
                                                                            authSession:session];
            
            NSDictionary *authHeaders = [oauthSigning OAuthEchoHeadersToVerifyCredentials];
            if (!authHeaders) {
                // user seems skipped auth process
                return;
            }
            
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            
            [[[QMCore instance].authService loginWithTwitterDigitsAuthHeaders:authHeaders] continueWithBlock:^id _Nullable(BFTask<QBUUser *> * _Nonnull task) {
                
                [SVProgressHUD dismiss];
                
                if (!task.isFaulted) {
                    
                    [self performSegueWithIdentifier:kQMSceneSegueMain sender:nil];
                    
                    [QMCore instance].currentProfile.accountType = QMAccountTypeDigits;
                    
                    QBUUser *user = task.result;
                    if (user.fullName.length == 0) {
                        // setting phone as user full name
                        user.fullName = user.phone;
                        
                        QBUpdateUserParameters *updateUserParams = [QBUpdateUserParameters new];
                        updateUserParams.fullName = user.fullName;
                        
                        return [QMTasks taskUpdateCurrentUser:updateUserParams];
                    }
                    
                    [[QMCore instance].currentProfile synchronizeWithUserData:user];
                    
                    return [[QMCore instance].pushNotificationManager subscribeForPushNotifications];
                }
                
                return nil;
            }];
        }
    }];
}

@end
