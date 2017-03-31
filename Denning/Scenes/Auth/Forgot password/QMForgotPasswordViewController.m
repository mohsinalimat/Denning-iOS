//
//  QMForgotPasswordTVC.m
//  Qmunicate
//
//  Created by Andrey Ivanov on 30.06.14.
//  Copyright (c) 2014 Quickblox. All rights reserved.
//

#import "QMForgotPasswordViewController.h"
#import "QMTasks.h"

@interface QMForgotPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *TACTextField;

@property (weak, nonatomic) BFTask *task;

@end

@implementation QMForgotPasswordViewController

- (void)dealloc {
    ILog(@"%@ - %@",  NSStringFromSelector(_cmd), self);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.phoneNumberTextField becomeFirstResponder];
    
    // initialize the number of bad try to log in
    [QMNetworkManager sharedManager].invalidTry = @0;
    
    [self addTapGesture];
}

#pragma mark Private

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self.view addGestureRecognizer:tap];
}

- (void)handleTap {
    [self.view endEditing:YES];
}

- (void)addKeyboardObservers{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addKeyboardObservers];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeKeyboardObservers];
    [SVProgressHUD dismiss];
    [self.view endEditing:YES];
}

#pragma mark - Keyboard
- (void)keyboardWillShow:(NSNotification*) notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    if (keyboardSize.height != 0.0f)
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

#pragma mark - actions

- (void)resetPasswordForMail:(NSString *)emailString {
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"QM_STR_LOADING", nil)];
    
    @weakify(self);
    self.task = [[QMTasks taskResetPasswordForEmail:emailString] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        
        @strongify(self);
        if (task.isFaulted) {
            
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"QM_STR_USER_WITH_EMAIL_WASNT_FOUND", nil)];
        }
        else {
            
            [SVProgressHUD showWithStatus:NSLocalizedString(@"QM_STR_MESSAGE_WAS_SENT_TO_YOUR_EMAIL", nil)];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        return nil;
    }];
}

- (BOOL) validateInputsWithEmail: (NSString*) email phoneNumber:(NSString*) phoneNumber
{
    if (email.length == 0 || phoneNumber.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"QM_STR_FILL_IN_ALL_THE_FIELDS", nil)];
        return false;
    }
    return true;
}

- (IBAction)requestSMS:(id)sender {
    NSString *email = self.emailTextField.text;
    NSString *phoneNumber = self.phoneNumberTextField.text;
    
    if (![self validateInputsWithEmail:email phoneNumber:phoneNumber])
    {
        return;
    }
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"QM_STR_LOADING", nil)];
    
    [[QMNetworkManager sharedManager] sendSMSRequestWithEmail:email phoneNumber:phoneNumber reason:@"from Forget Password form" withCompletion:^(BOOL success, NSInteger statusCode, NSString * _Nonnull error, NSDictionary * _Nonnull response) {
        
        if (!success) {
            
            [SVProgressHUD showErrorWithStatus:error];
        }
        else {
            
            [SVProgressHUD showSuccessWithStatus:@"SMS is sent to your phone"];
        }

    }];
}

- (IBAction)forgotPassword:(id)sender {
    NSString *email = self.emailTextField.text;
    NSString *phoneNumber = self.phoneNumberTextField.text;
    
    if (![self validateInputsWithEmail:email phoneNumber:phoneNumber])
    {
        return;
    }
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"QM_STR_LOADING", nil)];

    [[QMNetworkManager sharedManager] requestForgetPasswordWithEmail:self.emailTextField.text phoneNumber:self.phoneNumberTextField.text activationCode:self.TACTextField.text withCompletion:^(BOOL success, NSString * _Nonnull error) {
        
        if (!success) {
            [SVProgressHUD showErrorWithStatus:error];
        }
        else {
            [SVProgressHUD showSuccessWithStatus:@"Email is sent"];
        }
    }];
}

@end
