//
//  NewLedgerViewController.h
//  Denning
//
//  Created by DenningIT on 19/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewLedgerViewController : UIViewController
@property (strong, nonatomic) NSString* selectedAccountName;
@property (strong, nonatomic) NewLedgerModel* ledgerModelNew;

@end
