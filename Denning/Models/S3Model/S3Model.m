//
//  S3Model.m
//  Denning
//
//  Created by Ho Thong Mee on 22/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "S3Model.h"

@implementation S3Model
+ (S3Model*) getS3FromResponse: (NSDictionary*) response
{
    S3Model* model = [S3Model new];
    
    model.isVisible = [response valueForKeyNotNull:@"isVisible"];
    model.items = [ThirdItemModel getThirdItemArrayFromResponse:[response objectForKeyNotNull:@"items"]];
    model.style = [response valueForKeyNotNull:@"style"];
    model.title = [response valueForKeyNotNull:@"title"];
    
    return model;
}
@end
