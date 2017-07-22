//
//  SimpleMatterViewController.h
//  Denning
//
//  Created by DenningIT on 09/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateMatterHandler)(MatterSimple* model);

@interface SimpleMatterViewController : UIViewController

@property (strong, nonatomic) UpdateMatterHandler  updateHandler;

@property (strong, nonatomic) NSString* titleOfView;

@end
