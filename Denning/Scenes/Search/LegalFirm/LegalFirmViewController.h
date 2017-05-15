//
//  LegalFirmViewController.h
//  Denning
//
//  Created by DenningIT on 13/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DICustomTableViewController.h"

@interface LegalFirmViewController : DICustomTableViewController

@property (strong, nonatomic) LegalFirmModel* legalFirmModel;
@property (strong, nonatomic) NSString* previousScreen;
@property (strong, nonatomic) NSString* gotoRelatedMatter;

@end
