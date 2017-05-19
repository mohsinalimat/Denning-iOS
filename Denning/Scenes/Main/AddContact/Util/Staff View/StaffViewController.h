//
//  StaffViewController.h
//  Denning
//
//  Created by DenningIT on 09/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateStaffHandler)(NSString* type, StaffModel *model);

@interface StaffViewController : UITableViewController

@property (strong, nonatomic) NSString* typeOfStaff;

@property (strong, nonatomic) UpdateStaffHandler updateHandler;

@end
