//
//  FloatingTextCell.h
//  Denning
//
//  Created by DenningIT on 11/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralContactCell.h"

@interface FloatingTextCell : GeneralContactCell
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *floatingTextField;

- (void) configurePlaceholder:(NSString*)placeHolder withType:(NSString*)type;

@end
