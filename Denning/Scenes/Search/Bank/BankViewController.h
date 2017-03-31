//
//  BankViewController.h
//  Denning
//
//  Created by DenningIT on 27/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankViewController : UITableViewController

@property (strong, nonatomic) BankModel* bankModel;
@property (strong, nonatomic) NSString* previousScreen;

@end
