//
//  QMContactsDataSource.h
//  Q-municate
//
//  Created by Vitaliy Gorbachov on 3/15/16.
//  Copyright © 2016 Quickblox. All rights reserved.
//

#import "QMAlphabetizedDataSource.h"

@class FavContactsDataSource;
@protocol FavContactDataSourceDelegate <NSObject>

- (void)favContactDataSource:(FavContactsDataSource *)contactDataShource commitDeleteDialog:(QBUUser *)user;

@end

@interface FavContactsDataSource : QMAlphabetizedDataSource

@property (weak, nonatomic) id<FavContactDataSourceDelegate> delegate;

@end
