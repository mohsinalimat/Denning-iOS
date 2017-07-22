//
//  FileNote.h
//  Denning
//
//  Created by Ho Thong Mee on 19/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileNote : UIViewController

@property (strong, nonatomic) FileNoteModel* noteModel;
@property (strong, nonatomic) NSString *fileName;
@property (strong, nonatomic) NSString *fileNo;

@end
