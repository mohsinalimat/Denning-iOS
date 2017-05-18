//
//  ListWithPostCodeViewController.h
//  Denning
//
//  Created by DenningIT on 03/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContactPostCodeDelegate;
@interface ListWithPostCodeViewController : UITableViewController

@property (strong, nonatomic) id<ContactPostCodeDelegate> delegate;
@end
