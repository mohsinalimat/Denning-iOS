//
//  SolicitorListViewController.h
//  Denning
//
//  Created by DenningIT on 19/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateSolicitorHandler)(SoliciorModel* model);


@interface SolicitorListViewController : UIViewController

@property (strong, nonatomic) UpdateSolicitorHandler updateHandler;

@end
