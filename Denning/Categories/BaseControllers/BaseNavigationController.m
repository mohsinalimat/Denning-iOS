//
//  BaseNavigationController.m
//  Reach-iOS
//
//  Created by MaksymRachytskyy on 11/22/15.
//  Copyright © 2015 Maksym Rachytskyy. All rights reserved.
//

#import "BaseNavigationController.h"


@interface BaseNavigationController ()<QMChatServiceDelegate,
QMChatConnectionDelegate, ReachServiceDelegate>
@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *NavigationPortraitBackground = [[UIImage imageNamed:@"background"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [[UINavigationBar appearance] setBackgroundImage:NavigationPortraitBackground forBarMetrics:UIBarMetricsDefault];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[QMCore instance].chatService addDelegate:self];
    [[PushManager instance] addDelegate:self];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[QMCore instance].chatService removeDelegate:self];
    [[PushManager instance] removeDelegate:self];
}

#pragma mark - News Feed & Group Notification

- (void) didRecieveReachPushNotification:(PushManager *)__unused manager ID:(NSNumber*)ID title:(NSString *)title message:(NSString *)messageText avatar:(NSString *)avatar
{
    [QMSoundManager playMessageReceivedSound];
    
    MPGNotificationButtonHandler buttonHandler = nil;
    UIViewController *hvc = nil;
    
    buttonHandler = ^void(MPGNotification * __unused notification, NSInteger __unused buttonIndex) {
        
        };
    
    [QMNotification showMessageNotificationWithTitle:title message:messageText avatarURL:avatar buttonHandler:buttonHandler hostViewController:hvc];
}

#pragma mark - Notification

- (void)showNotificationForMessage:(QBChatMessage *)chatMessage {
    if (chatMessage.senderID == [QMCore instance].currentProfile.userData.ID) {
        // no need to handle notification for self message
        return;
    }
    
    if (chatMessage.dialogID == nil) {
        // message missing dialog ID
        NSAssert(nil, @"Message should contain dialog ID.");
        return;
    }
    
    if ([[QMCore instance].activeDialogID isEqualToString:chatMessage.dialogID]) {
        // dialog is already on screen
        return;
    }
    
    QBChatDialog *chatDialog = [[QMCore instance].chatService.dialogsMemoryStorage chatDialogWithID:chatMessage.dialogID];
    
    if (chatMessage.delayed && chatDialog.type == QBChatDialogTypePrivate) {
        // no reason to display private delayed messages
        // group chat messages are always considered delayed
        return;
    }
    
    [QMSoundManager playMessageReceivedSound];
    
    MPGNotificationButtonHandler buttonHandler = nil;
    UIViewController *hvc = nil;
    
    BOOL hasActiveCall = [QMCore instance].callManager.hasActiveCall;
    BOOL isiOS8 = iosMajorVersion() < 9;
    
    if (hasActiveCall
        || isiOS8) {
        
        // using hvc if active call or visible keyboard on ios8 devices
        // due to notification triggering window to be hidden
        hvc = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    
    if (!hasActiveCall) {
        // not showing reply button in active call
        buttonHandler = ^void(MPGNotification * __unused notification, NSInteger buttonIndex) {
            
            //if (buttonIndex == 1) {
                QMChatVC *chatVC = [QMChatVC chatViewControllerWithChatDialog:chatDialog];
                [self setNavigationBarHidden:NO];
                [self pushViewController:chatVC animated:YES];

           // }
        };
    }
    
    [QMNotification showMessageNotificationWithMessage:chatMessage buttonHandler:buttonHandler hostViewController:hvc];
}

#pragma mark - QMChatServiceDelegate

- (void)chatService:(QMChatService *)chatService didAddMessageToMemoryStorage:(QBChatMessage *)message forDialogID:(NSString *)dialogID {
    
    if (message.messageType == QMMessageTypeContactRequest) {
        
        QBChatDialog *chatDialog = [chatService.dialogsMemoryStorage chatDialogWithID:dialogID];
        [[[QMCore instance].usersService getUserWithID:[chatDialog opponentID]] continueWithSuccessBlock:^id _Nullable(BFTask<QBUUser *> * _Nonnull __unused task) {
            
            [self showNotificationForMessage:message];
            
            return nil;
        }];
    }
    else {
        
        [self showNotificationForMessage:message];
    }
}

@end
