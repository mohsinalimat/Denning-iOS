//
//  ChatContactCell.h
//  Denning
//
//  Created by DenningIT on 12/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralContactCell.h"

@class ChatContactCell;
@protocol ChatContactDelegate <NSObject>

@optional

- (void) didFavTapped: (ChatContactCell*) cell user:(QBUUser*) user tapType:(NSString*)type;

@end

@interface ChatContactCell : GeneralContactCell

@property (weak, nonatomic) id<ChatContactDelegate> chatDelegate;

- (void) configureCellWithContact: (QBUUser*) user;

@end
