//
//  SearchResultCell.h
//  Denning
//
//  Created by DenningIT on 20/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"

@interface SearchResultCell : DIGeneralCell

- (void) configureCellWithSearchModel: (SearchResultModel*) searchResult;

@end
