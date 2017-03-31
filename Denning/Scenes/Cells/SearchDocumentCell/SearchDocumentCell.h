//
//  SearchDocumentCell.h
//  Denning
//
//  Created by DenningIT on 28/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIGeneralCell.h"
@protocol SearchDocumentDelegate;

@interface SearchDocumentCell : DIGeneralCell
@property (weak, nonatomic) id<SearchDocumentDelegate> delegate;

- (void) configureCellWithSearchModel: (SearchResultModel*) model;

@end

@protocol SearchDocumentDelegate <NSObject>

@optional

- (void) didTapOpenFolder: (SearchDocumentCell*) cell;

- (void) didTapOpenMatter: (SearchDocumentCell*) cell;

@end
