//
//  ContactViewController.h
//  Denning
//
//  Created by DenningIT on 08/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UITableViewController

@property (strong, nonatomic) ContactModel* contactModel;
@property (strong, nonatomic) NSString* previousScreen;

@end
