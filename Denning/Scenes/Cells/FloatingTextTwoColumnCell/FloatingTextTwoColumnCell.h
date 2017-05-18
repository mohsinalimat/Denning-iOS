//
//  FloatingTextTwoColumnCell.h
//  Denning
//
//  Created by DenningIT on 11/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

typedef void (^UpdateTypeHandler)(void);

@interface FloatingTextTwoColumnCell : DIGeneralCell
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *leftFloatingText;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *rightFloatingText;

@property (strong, nonatomic) UpdateTypeHandler updateHandler;
@end
