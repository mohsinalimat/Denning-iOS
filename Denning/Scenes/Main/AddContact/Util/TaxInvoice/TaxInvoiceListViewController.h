//
//  TaxInvoiceListViewController.h
//  Denning
//
//  Created by DenningIT on 19/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateTaxHandler)(TaxModel* model);


@interface TaxInvoiceListViewController : UITableViewController

@property (strong, nonatomic) UpdateTaxHandler  updateHandler;

@end
