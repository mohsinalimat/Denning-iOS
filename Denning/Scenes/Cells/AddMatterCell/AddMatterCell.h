//
//  AddMatterCell.h
//  Denning
//
//  Created by DenningIT on 19/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"
typedef void(^AddNewHandler)(void);


@interface AddMatterCell : DIGeneralCell

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) AddNewHandler addNew;

@end
