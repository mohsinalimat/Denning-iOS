//
//  AddReceiptViewController.m
//  Denning
//
//  Created by DenningIT on 18/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AddReceiptViewController.h"
#import "ListWithCodeTableViewController.h"
#import "ListWithDescriptionViewController.h"
#import "SimpleMatterViewController.h"
#import "TaxInvoiceListViewController.h"
#import "AccountTypeViewController.h"
#import "SimpleAutocomplete.h"

@interface AddReceiptViewController ()<ContactListWithCodeSelectionDelegate, ContactListWithDescSelectionDelegate>
{
    NSString* titleOfList;
    NSString* nameOfField;
    
    CGFloat autocompleteCellHeight;
    NSString* serverAPI;
    
    NSString* selectedIssuerBankCode;
    NSString* selectedID;
}
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *fileNo;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *billNo;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *accountType;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *receivedFrom;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *amount;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *transaction;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *mode;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *issuerBank;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *bankBranch;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *chequeNo;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *checqueAmount;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *remarks;

@end

@implementation AddReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dismissScreen:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) prepareUI {
    autocompleteCellHeight = 58;
    serverAPI = [DataManager sharedManager].user.serverAPI;
    
    self.fileNo.floatLabelActiveColor = self.fileNo.floatLabelPassiveColor = [UIColor redColor];
    self.billNo.floatLabelActiveColor = self.billNo.floatLabelPassiveColor = [UIColor redColor];
    self.accountType.floatLabelActiveColor = self.accountType.floatLabelPassiveColor = [UIColor redColor];
    self.receivedFrom.floatLabelPassiveColor = self.receivedFrom.floatLabelPassiveColor = [UIColor redColor];
    self.amount.floatLabelActiveColor = self.amount.floatLabelPassiveColor = [UIColor redColor];
    self.transaction.floatLabelActiveColor = self.transaction.floatLabelPassiveColor = [UIColor redColor];
    self.mode.floatLabelActiveColor = self.mode.floatLabelPassiveColor = [UIColor redColor];
    self.issuerBank.floatLabelActiveColor = self.issuerBank.floatLabelPassiveColor = [UIColor redColor];
    self.bankBranch.floatLabelActiveColor = self.bankBranch.floatLabelPassiveColor = [UIColor redColor];
    self.chequeNo.floatLabelActiveColor = self.chequeNo.floatLabelPassiveColor = [UIColor redColor];
    self.checqueAmount.floatLabelActiveColor = self.checqueAmount.floatLabelPassiveColor = [UIColor redColor];

    self.remarks.floatLabelActiveColor = self.remarks.floatLabelPassiveColor = [UIColor redColor];
    
    UIToolbar* _accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)];
    _accessoryView.barTintColor = [UIColor groupTableViewBackgroundColor];
    _accessoryView.tintColor = [UIColor babyRed];
    
    _accessoryView.items = @[
                             [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                             [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [_accessoryView sizeToFit];
    
    self.amount.inputAccessoryView = _accessoryView;
    self.transaction.inputAccessoryView = _accessoryView;
    self.bankBranch.inputAccessoryView = _accessoryView;
    self.chequeNo.inputAccessoryView = _accessoryView;
    self.checqueAmount.inputAccessoryView = _accessoryView;
    self.remarks.inputAccessoryView = _accessoryView;
    
    // Hide empty separators
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)handleTap {
    [self.view endEditing:YES];
}


- (void) showPopup: (UIViewController*) vc {
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:vc];
    [STPopupNavigationBar appearance].barTintColor = [UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.0f];
    [STPopupNavigationBar appearance].tintColor = [UIColor whiteColor];
    [STPopupNavigationBar appearance].barStyle = UIBarStyleDefault;
    [STPopupNavigationBar appearance].titleTextAttributes = @{ NSFontAttributeName: [UIFont fontWithName:@"Cochin" size:18], NSForegroundColorAttributeName: [UIColor whiteColor] };
    popupController.transitionStyle = STPopupTransitionStyleFade;;
    popupController.containerView.layer.cornerRadius = 4;
    popupController.containerView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
    popupController.containerView.layer.shadowOffset = CGSizeMake(4, 4);
    popupController.containerView.layer.shadowOpacity = 1;
    popupController.containerView.layer.shadowRadius = 1.0;
    
    [popupController presentInViewController:self];
}

- (void) showAutocomplete {
    [self.view endEditing:YES];
    
    SimpleAutocomplete *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SimpleAutocomplete"];
    vc.url = RECEIPT_TRANS_DESC_GET_LIST_URL;
    vc.title = @"";
    vc.updateHandler =  ^(NSString* selectedString) {
        self.transaction.text = selectedString;
    };
    
    [self showPopup:vc];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self performSegueWithIdentifier:kSimpleMatterSegue sender:MATTERSIMPLE_GET_URL];
        } else if (indexPath.row == 1) {
            [self performSegueWithIdentifier:kTaxInvoiceSegue sender:RECEIPT_TAX_INVOICE_GET_LIST_URL];
        } else if (indexPath.row == 2) {
            [self performSegueWithIdentifier: kAccountTypeSegue sender:  ACCOUNT_TYPE_GET_LIST_URL];
        } else if (indexPath.row == 5) {
            [self showAutocomplete];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            titleOfList = @"Select Payment";
            nameOfField = @"payment";
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:ACCOUNT_PAYMENT_MODE_GET_URL];
        } else if (indexPath.row == 1) {
            titleOfList = @"Select Issuer";
            nameOfField = @"issuer";
            [self performSegueWithIdentifier:kListWithCodeSegue sender:ACCOUNT_CHEQUE_ISSUEER_GET_URL];;
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - ContactListWithCodeSelectionDelegate
- (void) didSelectList:(UIViewController *)listVC name:(NSString*) name withModel:(CodeDescription *)model
{
    if ([name isEqualToString:@"issuer"]) {
        self.issuerBank.text = model.descriptionValue;
        selectedIssuerBankCode = model.codeValue;
    }
}

#pragma mark - ContactListWithDescriptionDelegate
- (void) didSelectListWithDescription:(UIViewController *)listVC name:(NSString*) name withString:(NSString *)description
{
    if ([name isEqualToString:@"payment"]) {
        self.mode.text = description;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kListWithCodeSegue]) {
        UINavigationController *navVC =segue.destinationViewController;
        
        ListWithCodeTableViewController *listCodeVC = navVC.viewControllers.firstObject;
        listCodeVC.delegate = self;
        listCodeVC.titleOfList = titleOfList;
        listCodeVC.name = nameOfField;
        listCodeVC.url = sender;
    }
    
    if ([segue.identifier isEqualToString:kListWithDescriptionSegue]) {
        UINavigationController *navVC =segue.destinationViewController;
        
        ListWithDescriptionViewController *listDescVC = navVC.viewControllers.firstObject;
        listDescVC.contactDelegate = self;
        listDescVC.titleOfList = titleOfList;
        listDescVC.name = nameOfField;
        listDescVC.url = sender;
    }
    
    if ([segue.identifier isEqualToString:kSimpleMatterSegue]) {
        SimpleMatterViewController* matterVC = segue.destinationViewController;
        matterVC.updateHandler = ^(MatterSimple *model) {
            
            self.fileNo.text = model.systemNo;
        };
    }
    
    if ([segue.identifier isEqualToString:kTaxInvoiceSegue]) {
        TaxInvoiceListViewController* vc = segue.destinationViewController;
        vc.updateHandler = ^(TaxModel *model) {
            self.billNo.text = model.documentNo;
        };
    }
    
    if ([segue.identifier isEqualToString:kAccountTypeSegue]) {
        AccountTypeViewController* vc = segue.destinationViewController;
        vc.updateHandler = ^(AccountTypeModel *model) {
            self.accountType.text = model.shortDescription;
            selectedID = model.ID;
        };
    }
}


@end
