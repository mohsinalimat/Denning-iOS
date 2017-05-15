//
//  PropertyViewController.h
//  Denning
//
//  Created by DenningIT on 09/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DICustomTableViewController.h"

@interface PropertyViewController : DICustomTableViewController

@property (strong, nonatomic) PropertyModel* propertyModel;
@property (strong, nonatomic) NSString* previousScreen;
@end
