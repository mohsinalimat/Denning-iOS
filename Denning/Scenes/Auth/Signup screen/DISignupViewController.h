//
//  DISignupViewController.h
//  Denning
//
//  Created by DenningIT on 24/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FirmListViewController;

@protocol FirmListDelegate <NSObject>

- (void) didSelectFirm: (FirmListViewController*) signupVC withFirmModel: (FirmModel*) firmModel;

@end

@interface DISignupViewController : UITableViewController

@end
