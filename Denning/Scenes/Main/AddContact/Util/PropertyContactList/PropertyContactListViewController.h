//
//  PropertyContactListViewController.h
//  Denning
//
//  Created by DenningIT on 17/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

@class ClientModel;
#import <UIKit/UIKit.h>
typedef void (^UpdatePropertyContactHandler)(ClientModel* model);

@interface PropertyContactListViewController : UITableViewController

@property (strong, nonatomic) UpdatePropertyContactHandler updateHandler;

@end
