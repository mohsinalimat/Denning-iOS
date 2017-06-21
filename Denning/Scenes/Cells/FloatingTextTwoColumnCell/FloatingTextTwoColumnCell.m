//
//  FloatingTextTwoColumnCell.m
//  Denning
//
//  Created by DenningIT on 11/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "FloatingTextTwoColumnCell.h"

@implementation FloatingTextTwoColumnCell

- (void) awakeFromNib
{
    [super awakeFromNib];
    self.rightDetailDisclosure.hidden = YES;
}

- (IBAction)didTapTypeField:(UITextField*)sender {
    self.updateTypeHandler();
}
- (IBAction)didTapValueField:(UITextField*)sender {
    self.updateValueHandler();
}



@end
