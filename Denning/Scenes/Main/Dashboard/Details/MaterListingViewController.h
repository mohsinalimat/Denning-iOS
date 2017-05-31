//
//  MaterListingViewController.h
//  Denning
//
//  Created by Ho Thong Mee on 26/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateNewMatterHandler)(NewMatterModel* model);


@interface MaterListingViewController : UITableViewController

@property (strong, nonatomic) UpdateNewMatterHandler updateHandler;
@property (strong, nonatomic) NSString* url;

@end
