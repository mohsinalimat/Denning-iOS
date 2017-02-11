//
//  FirmListViewController.h
//  Denning
//
//  Created by DenningIT on 25/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DISignupViewController;
@protocol FirmListDelegate;

@interface FirmListViewController : UITableViewController

@property (strong, nonatomic) id<FirmListDelegate> firmDelegate;
@property( strong, nonatomic) FirmModel* firmModel;

@end
