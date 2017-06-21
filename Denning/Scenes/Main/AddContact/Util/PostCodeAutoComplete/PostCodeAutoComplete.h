//
//  PostCodeAutoComplete.h
//  Denning
//
//  Created by Ho Thong Mee on 05/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdatePostCodeHandler)(CityModel* model);

@interface PostCodeAutoComplete : UIViewController


@property (strong, nonatomic) NSString* url;

@property (strong, nonatomic) UpdatePostCodeHandler updateHandler;
@end
