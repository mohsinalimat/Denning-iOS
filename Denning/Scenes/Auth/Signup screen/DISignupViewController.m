//
//  DISignupViewController.m
//  Denning
//
//  Created by DenningIT on 24/01/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "DISignupViewController.h"
#import "FirmListViewController.h"

@interface DISignupViewController ()<FirmListDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmField;
@property (weak, nonatomic) IBOutlet UISwitch *isLayerControl;
@property (weak, nonatomic) IBOutlet UILabel *firmName;

@property (weak, nonatomic) IBOutlet UIButton *firmListSelectionBtn;
@property (strong, nonatomic) NSString* firmCode;

@property (strong, nonatomic) NSArray* firmList;
@property (strong, nonatomic) NSMutableArray* firmNameList;

@end

@implementation DISignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    [self addTapGesture];
}

- (void) prepareUI
{
    [self.usernameField becomeFirstResponder];
}

- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)handleTap {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self addKeyboardObservers];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeKeyboardObservers];
    [SVProgressHUD dismiss];
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addKeyboardObservers{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard
- (void)keyboardWillShow:(NSNotification*) notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if (keyboardSize.height != 0.0f && !self.usernameField.isFirstResponder && !self.emailField.isFirstResponder && !self.phoneField.isFirstResponder)
    {
        CGFloat y = -keyboardSize.height/2;
        CGRect frame = CGRectMake(self.view.frame.origin.x, y, self.view.frame.size.width, self.view.frame.size.height);
        [self.view setFrame:frame];
        [self.view layoutIfNeeded];
    }
}

- (void)keyboardWillHide:(NSNotification*) notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if (keyboardSize.height != 0.0f)
    {
        CGFloat y = 0;
        CGRect frame = CGRectMake(self.view.frame.origin.x, y, self.view.frame.size.width, self.view.frame.size.height);
        [self.view setFrame:frame];
        [self.view layoutIfNeeded];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *) __unused textField {
    if ([self.usernameField isFirstResponder]) {
        [self.emailField becomeFirstResponder];
    } else if ([self.emailField isFirstResponder]) {
        [self.phoneField becomeFirstResponder];
    } else if ([self.phoneField isFirstResponder]) {
        [self.passwordField becomeFirstResponder];
    } else if ([self.passwordField isFirstResponder]) {
        [self.passwordConfirmField becomeFirstResponder];
    } else if ([self.passwordConfirmField isFirstResponder]) {
        [self.view endEditing:YES];
        [self selectFirmList:nil];
    }
    
    return YES;
}

- (BOOL) checkValidation
{
    BOOL isValid = NO;
    if (self.usernameField.text.length == 0 || self.emailField.text.length == 0 || self.phoneField.text.length == 0 || self.passwordField.text.length == 0 || self.passwordConfirmField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"Please fill out all the fields"];
        return isValid;
    }
    
    if (![self.passwordField.text isEqualToString:self.passwordConfirmField.text]) {
        [SVProgressHUD showErrorWithStatus:@"Password should be matched"];
        return isValid;
    }
    
    isValid = YES;
    return isValid;
}

- (IBAction)done:(id)sender {
    if (![self checkValidation]) {
        return;
    }
    
    NSNumber* isLawyer = self.isLayerControl.isOn ? @1 : @0;
    NSString* phone = [@"+" stringByAppendingString:self.phoneField.text];
    
    [SVProgressHUD showWithStatus:@"Sign up"];
    [[QMNetworkManager sharedManager] userSignupWithUsername:self.usernameField.text phone:phone email:self.emailField.text password:self.passwordField.text isLayer:isLawyer firmCode:self.firmCode withCompletion:^(BOOL success, NSString * _Nonnull error) {
        [SVProgressHUD dismiss];
        if  (success)
        {
            [self dismissScreen:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:error];
        }
    }];
}


- (IBAction)tapLawyer:(UISwitch*)sender {
}

- (IBAction)selectLaywer:(UISwitch* )sender {
}

- (void) extractFirmNameList {
    self.firmNameList = [[NSMutableArray alloc]init];
    for (FirmModel *firm in self.firmList) {
        [self.firmNameList addObject:firm.name];
    }
}

- (void) showFirmList
{
    [ActionSheetStringPicker showPickerWithTitle:@"Select a Firm"
                                            rows:self.firmNameList
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           self.firmCode = ((FirmModel*)self.firmList[selectedIndex]       ).firmCode; [self.firmListSelectionBtn setTitle: selectedValue forState:UIControlStateNormal];
                                       }
     
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:self.firmListSelectionBtn];
}

- (IBAction)selectFirmList:(id)sender {
    [SVProgressHUD showWithStatus:@"Loading"];
    @weakify(self)
    [[QMNetworkManager sharedManager] getFirmListWithCompletion:^(NSArray * _Nonnull resultArray) {
        @strongify(self)
        [SVProgressHUD dismiss];
        self.firmList = resultArray;
        [self extractFirmNameList];
        [self showFirmList];
    }];
}


#pragma mark - FirmDelegate
- (void) didSelectFirm:(FirmListViewController *)signupVC withFirmModel:(FirmModel *)firmModel
{
    self.firmName.text = firmModel.name;
    self.firmCode = firmModel.firmCode;
}

@end
