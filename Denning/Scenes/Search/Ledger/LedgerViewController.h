//
//  LedgerViewController.h
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LedgerViewController : UITableViewController

@property (strong, nonatomic) NSArray* ledgerArray;
@property (strong, nonatomic) NSString* matterCode;

@property (strong, nonatomic) NSString *previousScreen;

@end
