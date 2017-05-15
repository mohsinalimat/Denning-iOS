//
//  LedgerViewController.h
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DICustomTableViewController.h"

@interface LedgerViewController : DICustomTableViewController

@property (strong, nonatomic) NewLedgerModel* ledgerModel;
@property (strong, nonatomic) NSString* matterCode;
@property (strong, nonatomic) NSString *previousScreen;

@end
