//
//  ContactCell.h
//  Denning
//
//  Created by DenningIT on 26/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@class ContactCell;
@protocol ContactCellDelegate <NSObject>

@optional

- (void) didTapRightBtn:(ContactCell*) cell value:(NSString*) value;

@end

@interface ContactCell : DIGeneralCell

@property (weak, nonatomic) id<ContactCellDelegate> delegate;

- (void) configureCellWithContact:(NSString*) title text:(NSString*) text;

- (void) setEnableRightBtn: (BOOL) enabled image:(UIImage*)rightImage;
@end
