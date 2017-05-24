//
//  PropertyListViewController.h
//  Denning
//
//  Created by DenningIT on 19/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdatePropertyHandler)(FullPropertyModel* model);


@interface PropertyListViewController : UITableViewController

@property (strong, nonatomic) UpdatePropertyHandler updateHandler;

@end
