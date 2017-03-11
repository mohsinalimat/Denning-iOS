//
//  AppDelegate.m
//  Denning
//
//  Created by DenningIT on 19/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "QMCore.h"
#import "QMImages.h"
#import "QMHelpers.h"
#import "QMNetworkManager.h"
#import "DataManager.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#define DEVELOPMENT 0

#if DEVELOPMENT == 1


// Production
static const NSUInteger kQMApplicationID = 52393;
static NSString * const kQMAuthorizationKey = @"cbL3q5BvSS2AWUH";
static NSString * const kQMAuthorizationSecret = @"rMtJW5gyH4YWMVZ";
static NSString * const kQMAccountKey = @"C8mpRE2Cs5qSfFBzxJ7Z";

#else

// Development
static const NSUInteger kQMApplicationID = 52393;
static NSString * const kQMAuthorizationKey = @"cbL3q5BvSS2AWUH";
static NSString * const kQMAuthorizationSecret = @"rMtJW5gyH4YWMVZ";
static NSString * const kQMAccountKey = @"C8mpRE2Cs5qSfFBzxJ7Z";

#endif

@interface AppDelegate ()<QMPushNotificationManagerDelegate, CLLocationManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Quickblox settings
    [QBSettings setApplicationID:kQMApplicationID];
    [QBSettings setAuthKey:kQMAuthorizationKey];
    [QBSettings setAuthSecret:kQMAuthorizationSecret];
    [QBSettings setAccountKey:kQMAccountKey];
    
    [QBSettings setAutoReconnectEnabled:YES];
    [QBSettings setCarbonsEnabled:YES];
    
    [Fabric with:@[CrashlyticsKit]];

    
#if DEVELOPMENT == 0
    [QBSettings setLogLevel:QBLogLevelNothing];
    [QBSettings disableXMPPLogging];
    [QMServicesManager enableLogging:NO];
#else
    [QBSettings setLogLevel:QBLogLevelDebug];
    [QBSettings enableXMPPLogging];
    [QMServicesManager enableLogging:YES];
#endif
    // QuickbloxWebRTC settings
    [QBRTCClient initializeRTC];
    [QBRTCConfig setICEServers:[[QMCore instance].callManager quickbloxICE]];
    [QBRTCConfig mediaStreamConfiguration].audioCodec = QBRTCAudioCodecISAC;
    [QBRTCConfig setStatsReportTimeInterval:0.0f]; // set to 1.0f to enable stats report
    
    // Handling push notifications if needed
    if (launchOptions != nil) {
        NSDictionary *pushNotification = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        [QMCore instance].pushNotificationManager.pushNotification = pushNotification;
    }

    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    [[QMCore instance].chatManager disconnectFromChatIfNeeded];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[QMCore instance] login];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBSDKAppEvents activateApp];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
