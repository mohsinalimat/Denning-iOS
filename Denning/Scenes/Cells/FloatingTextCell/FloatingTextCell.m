//
//  FloatingTextCell.m
//  Denning
//
//  Created by DenningIT on 11/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "FloatingTextCell.h"

@implementation FloatingTextCell

- (void) configurePlaceholder:(NSString*)placeHolder withType:(NSString*)type
{
    self.floatingTextField.placeholder = placeHolder;
    if (type.length != 0) {
        self.floatingTextField.floatLabelActiveColor = self.floatingTextField.floatLabelPassiveColor = [UIColor greenColor];
    } else {
        self.floatingTextField.floatLabelActiveColor = self.floatingTextField.floatLabelPassiveColor = [UIColor redColor];
    }
}

@end
