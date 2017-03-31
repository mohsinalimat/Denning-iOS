//
//  SearchResultCell.h
//  Denning
//
//  Created by DenningIT on 20/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@protocol SearchDelegate;


@interface SearchResultCell : DIGeneralCell

@property (weak, nonatomic) id<SearchDelegate> delegate;

- (void) configureCellWithSearchModel: (SearchResultModel*) searchResult;

@end

@protocol SearchDelegate <NSObject>

@optional

- (void) didTapMatter: (SearchResultCell*) cell;

@end
