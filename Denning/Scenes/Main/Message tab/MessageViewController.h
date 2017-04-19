//
//  MessageViewController.h
//  Denning
//
//  Created by DenningIT on 04/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *companySelectionView;
@property (weak, nonatomic) IBOutlet UIStackView *chatOptionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageViewerTopConstraint;


@end
