//
//  CustomeSearchCollectionLayout.m
//  Prekkha
//
//  Created by Joseph on 2016-07-05.
//  Copyright © 2016 Hoopty Organization. All rights reserved.
//

#import "CustomeSearchCollectionLayout.h"

@implementation CustomeSearchCollectionLayout

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.minimumLineSpacing = 1.0;
        self.minimumInteritemSpacing = 1.0;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

- (CGSize)itemSize
{
    NSInteger numberOfColumns = 4;
    
//    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - (numberOfColumns - 1)) / numberOfColumns - 20;
    CGFloat itemWidth = CGRectGetWidth(self.collectionView.frame) / numberOfColumns;
    CGFloat itemHeight = itemWidth;
    return CGSizeMake(itemWidth, itemHeight);
}

@end
