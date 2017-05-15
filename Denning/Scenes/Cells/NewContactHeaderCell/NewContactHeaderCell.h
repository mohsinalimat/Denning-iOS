//
//  NewContactHeaderCell.h
//  Denning
//
//  Created by DenningIT on 25/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@class NewContactHeaderCell;
@protocol NewContactHeaderCellDelegate <NSObject>

@optional

- (void) didTapMessage: (NewContactHeaderCell*) cell;

@end

@interface NewContactHeaderCell : DIGeneralCell

@property (weak, nonatomic) id<NewContactHeaderCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fileNumberLable;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

- (void) configureCellWithInfo:(NSString*) name number:(NSString*) number image:(UIImage*) image;

@end
