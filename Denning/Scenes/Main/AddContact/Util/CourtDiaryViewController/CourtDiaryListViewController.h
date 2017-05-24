//
//  CourtDiaryViewController.h
//  Denning
//
//  Created by Ho Thong Mee on 23/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^UpdateCourtDiaryHandler)(CourtDiaryModel* model);

@interface CourtDiaryListViewController : UITableViewController

@property (strong, nonatomic) UpdateCourtDiaryHandler  updateHandler;

@end
