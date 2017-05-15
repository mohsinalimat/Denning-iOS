//
//  ListOfTypeViewController.h
//  Denning
//
//  Created by DenningIT on 11/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateTypeHandler)(NSString* type);


@interface ListOfTypeViewController : UITableViewController

@property (assign, nonatomic) NSString *titleOfList;
@property (assign, nonatomic) NSString *url;

@property (strong, nonatomic) UpdateTypeHandler  updateHandler;

@end
