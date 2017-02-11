//
//  DIGeneralCell.h
//  Denning
//
//  Created by DenningIT on 01/02/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DIGeneralCell : UITableViewCell

+ (void)registerForReuseInTableView:(UITableView *)tableView;
+ (NSString *)cellIdentifier;
+ (CGFloat)height;

@end
