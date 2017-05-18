//
//  ProjectHousingViewController.h
//  Denning
//
//  Created by DenningIT on 17/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UpdatePropertyHousingHandler)(ProjectHousingModel* model);

@interface ProjectHousingViewController : UITableViewController

@property (strong, nonatomic) UpdatePropertyHousingHandler updateHandler;

@end
