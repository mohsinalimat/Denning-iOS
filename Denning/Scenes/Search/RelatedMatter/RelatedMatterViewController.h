//
//  RelatedMatterViewController.h
//  Denning
//
//  Created by DenningIT on 08/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DICustomTableViewController.h"

@interface RelatedMatterViewController : DICustomTableViewController

@property (strong, nonatomic) RelatedMatterModel* relatedMatterModel;
@property (strong, nonatomic) NSString *previousScreen;
@end
