//
//  UploadTo.h
//  Denning
//
//  Created by Ho Thong Mee on 20/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateMatterCodeHandler)(MatterCodeModel* model);

@interface UploadTo : UIViewController

@property (strong, nonatomic) UpdateMatterCodeHandler  updateHandler;


@end
