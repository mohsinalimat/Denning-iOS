//
//  PresetBillViewController.h
//  Denning
//
//  Created by DenningIT on 12/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdatePresetBillHandler)(PresetBillModel* model);

@interface PresetBillViewController : UITableViewController

@property (strong, nonatomic) UpdatePresetBillHandler  updateHandler;


@end
