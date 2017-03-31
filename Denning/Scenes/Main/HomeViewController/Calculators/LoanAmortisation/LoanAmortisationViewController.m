//
//  LoanViewController.m
//  Denning
//
//  Created by DenningIT on 24/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "LoanAmortisationViewController.h"

@interface LoanAmortisationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loanAmountTF;
@property (weak, nonatomic) IBOutlet UITextField *annualInterestRateTF;
@property (weak, nonatomic) IBOutlet UITextField *loanPeriodInYear;

@property (weak, nonatomic) IBOutlet UITextField *monthlyInslament;
@property (weak, nonatomic) IBOutlet UITextField *numberOfMonths;
@property (weak, nonatomic) IBOutlet UITextField *totalInterest;

@end

@implementation LoanAmortisationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareUI {
    UIToolbar *accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)];
    accessoryView.barTintColor = [UIColor groupTableViewBackgroundColor];
    accessoryView.tintColor = [UIColor skyBlueColor];
    
    accessoryView.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [accessoryView sizeToFit];
    self.loanAmountTF.inputAccessoryView = accessoryView;
    self.annualInterestRateTF.inputAccessoryView = accessoryView;
    self.loanPeriodInYear.inputAccessoryView = accessoryView;

    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 23)];
    
    [backButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popupScreen:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    [self.navigationItem setLeftBarButtonItems:@[backButtonItem] animated:YES];
}

- (void) popupScreen:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleTap {
    [self.view endEditing:YES];
}

- (IBAction)didTapCalculate:(id)sender {
    double P = [self.loanAmountTF.text doubleValue];
    double r = [self.annualInterestRateTF.text doubleValue] / 100;
    double  n = [self.loanPeriodInYear.text doubleValue] * 12;
    
    double A = P * (r + r / (pow(1+r, n) - 1));
    double total = 360 * A;
    self.monthlyInslament.text = [NSString stringWithFormat:@"%.2f", A];
//    self.totalInterest.text = [NSString stringWithFormat:@"%.2f", total];
}

- (IBAction)didTapReset:(id)sender {
    self.loanAmountTF.text = @"";
    self.annualInterestRateTF.text = @"";
    self.loanPeriodInYear.text = @"";
    self.monthlyInslament.text = @"";
    self.numberOfMonths.text = @"";
    self.totalInterest.text = @"";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 1;
    }
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
