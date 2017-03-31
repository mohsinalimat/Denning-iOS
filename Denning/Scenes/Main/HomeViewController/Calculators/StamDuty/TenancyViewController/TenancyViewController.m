//
//  TenancyViewController.m
//  Denning
//
//  Created by DenningIT on 22/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "TenancyViewController.h"

@interface TenancyViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *monthlyRentTextField;
@property (weak, nonatomic) IBOutlet UILabel *annualRentLabel;
@property (weak, nonatomic) IBOutlet UITextField *termsOfTenancyTextField;
@property (weak, nonatomic) IBOutlet UITextField *resultTextField;

@end

@implementation TenancyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) prepareUI {
    self.monthlyRentTextField.delegate = self;
    
    UIToolbar *accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)];
    accessoryView.barTintColor = [UIColor groupTableViewBackgroundColor];
    accessoryView.tintColor = [UIColor skyBlueColor];
    
    accessoryView.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [accessoryView sizeToFit];
    self.monthlyRentTextField.inputAccessoryView = accessoryView;
    self.termsOfTenancyTextField.inputAccessoryView = accessoryView;
}

- (void)handleTap {
    [self.view endEditing:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 1;
    }
    
    return 0;
}

- (IBAction)didTapCalculate:(id)sender {
    if ([self.annualRentLabel.text floatValue] <= 2400){
        self.resultTextField.text = @"0";
        return;
    }
    
    double actualValue = [self.annualRentLabel.text floatValue]/250;
    if ([self.termsOfTenancyTextField.text isEqual:@"1"]){
        self.resultTextField.text = [NSString stringWithFormat:@"%.2f", actualValue];
    } else if ([self.termsOfTenancyTextField.text integerValue] < 4) {
        self.resultTextField.text = [NSString stringWithFormat:@"%.2f", actualValue * 2];
    } else {
        self.resultTextField.text = [NSString stringWithFormat:@"%.2f", actualValue * 4];
    }
    
}

- (IBAction)didTapReset:(id)sender {
    self.monthlyRentTextField.text = @"";
    self.annualRentLabel.text = @"";
    self.termsOfTenancyTextField.text = @"";
    self.resultTextField.text = @"";
}

#pragma mark - UITextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.annualRentLabel.text = [NSString stringWithFormat:@"%.2f", [self.monthlyRentTextField.text floatValue] * 12];
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
