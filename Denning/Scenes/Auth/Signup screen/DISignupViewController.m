//
//  DISignupViewController.m
//  Denning
//
//  Created by DenningIT on 24/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "DISignupViewController.h"
#import "FirmListViewController.h"

@interface DISignupViewController ()<FirmListDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmField;
@property (weak, nonatomic) IBOutlet UISwitch *isLayerControl;
@property (weak, nonatomic) IBOutlet UILabel *firmName;

@property (strong, nonatomic) NSString* firmCode;

@end

@implementation DISignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) prepareUI
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT/2;
    
    [self.usernameField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self prepareUI];
}

- (BOOL) checkValidation
{
    BOOL isValid = NO;
    
    
    return isValid;
}

- (IBAction)done:(id)sender {
    if (![self checkValidation]) {
        return;
    }
    
    NSNumber* isLawyer = self.isLayerControl.isOn ? @1 : @0;
    
    [[QMNetworkManager sharedManager] userSignupWithUsername:self.usernameField.text phone:self.phoneField.text email:self.emailField.text password:self.passwordField.text isLayer:isLawyer firmCode:self.firmCode withCompletion:^(BOOL success, NSString * _Nonnull error) {
        if  (success)
        {
            [self performSegueWithIdentifier:@"ActivationSegue" sender:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:error];
        }
    }];
}


- (IBAction)tapLawyer:(UISwitch*)sender {
}

#pragma mark - FirmDelegate
- (void) didSelectFirm:(FirmListViewController *)signupVC withFirmModel:(FirmModel *)firmModel
{
    self.firmName.text = firmModel.name;
    self.firmCode = firmModel.firmCode;
}

#pragma mark - UITableView Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 6) {
        [self performSegueWithIdentifier:@"FirmListSegue" sender:nil];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"FirmListSegue"]) {
        FirmListViewController* firmListVC = segue.destinationViewController;
        firmListVC.firmDelegate = self;
    }
}


@end
