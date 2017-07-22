//
//  SuggestedFileName.h
//  Denning
//
//  Created by Ho Thong Mee on 20/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpdateNameHandler)(NSDictionary* response);

@interface SuggestedFileName : UIViewController

@property (strong, nonatomic) UpdateNameHandler updateHanlder;
@property (strong, nonatomic) NSString* url;
@end
