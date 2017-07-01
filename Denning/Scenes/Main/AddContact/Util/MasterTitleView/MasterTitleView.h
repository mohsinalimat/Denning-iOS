//
//  MasterTitleView.h
//  Denning
//
//  Created by Ho Thong Mee on 26/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateMasterTitleHandler)(MasterTitleModel* model);

@interface MasterTitleView : UIViewController


@property (strong, nonatomic) UpdateMasterTitleHandler updateHandler;
@end
