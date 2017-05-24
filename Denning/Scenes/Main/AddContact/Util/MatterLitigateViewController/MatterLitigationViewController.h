//
//  MatterLitigationViewController.h
//  Denning
//
//  Created by Ho Thong Mee on 23/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateMatterLitigationHandler)(MatterLitigationModel* model);

@interface MatterLitigationViewController : UITableViewController

@property (strong, nonatomic) UpdateMatterLitigationHandler  updateHandler;


@end
