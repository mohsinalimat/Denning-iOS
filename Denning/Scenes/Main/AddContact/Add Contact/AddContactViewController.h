//
//  AddContactViewController.h
//  Denning
//
//  Created by DenningIT on 20/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListWithCodeTableViewController;


@interface AddContactViewController : UITableViewController<UITextFieldDelegate, ContactListWithCodeSelectionDelegate, ContactListWithDescSelectionDelegate,ContactPostCodeDelegate>


@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *postcodeTextField;

@property (strong, nonatomic) ContactModel* contactModel;
@property(strong, nonatomic) NSString* viewType;

@end
