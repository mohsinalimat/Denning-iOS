//
//  FirmPasswordViewController.m
//  Denning
//
//  Created by DenningIT on 30/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "FirmPasswordViewController.h"
#import "FolderViewController.h"

@interface FirmPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *TACTextField;

@end

@implementation FirmPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareUI];
    [self addTapGesture];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [DIHelpers drawWhiteBorderToTextField:self.TACTextField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareUI
{

}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)handleTap {
    [self.view endEditing:YES];
}

- (IBAction)confirmTAC:(id)sender  {
    if (self.TACTextField.text.length < 1){
        [QMAlert showAlertWithMessage:@"Please input the password" actionSuccess:NO inViewController:self];
        return;
    }
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"QM_STR_LOADING", nil)];
    @weakify(self);
    NSString *password = self.TACTextField.text; // 5566
    [[QMNetworkManager sharedManager] clientSignIn:[[DataManager sharedManager].user.serverAPI stringByAppendingString:DENNING_CLIENT_FIRST_SIGNIN] password:password withCompletion:^(BOOL success, NSDictionary * _Nonnull responseObject, NSString * _Nonnull error, DocumentModel * _Nonnull doumentModel) {
        
        [SVProgressHUD dismiss];
        @strongify(self);
        if (success) {
            [self performSegueWithIdentifier:kQMSceneSegueMain sender:nil];
        } else {
            [QMAlert showAlertWithMessage:error actionSuccess:NO inViewController:self];
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kPersonalFolderSegue]) {
        FolderViewController* folderVC = segue.destinationViewController;
        folderVC.documentModel = sender;
    }
}


@end
