//
//  ListOfMatterViewController.h
//  Denning
//
//  Created by DenningIT on 12/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateMatterCodeHandler)(MatterCodeModel* model);

@interface ListOfMatterViewController : UIViewController

@property (strong, nonatomic) UpdateMatterCodeHandler  updateHandler;

@end
