//
//  QuotationGetListViewController.h
//  Denning
//
//  Created by DenningIT on 16/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UpdateQuotationHandler)(QuotationModel* model);

@interface QuotationGetListViewController : UITableViewController
@property (strong, nonatomic) UpdateQuotationHandler  updateHandler;


@end
