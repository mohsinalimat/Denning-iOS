//
//  SPAViewController.m
//  Denning
//
//  Created by DenningIT on 22/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "SPAViewController.h"
#import "QMAlert.h"

@interface SPAViewController ()

@property (weak, nonatomic) IBOutlet UITextField *priceValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *resultTextField;
@property (weak, nonatomic) IBOutlet UILabel *relationshipLabel;
@property (strong, nonatomic) NSArray* relationsArray;

@end

@implementation SPAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void) prepareUI {
    self.relationsArray = [NSArray arrayWithObjects:@"Seller-Purchaser (100%)", @"Husband-wife (0%)", @"Parenet-Child (50%)", @"Grandparent-Grandchild(50%)", @"Trustee-Beneficiary (+RM10)", @"Administrator-Beneficiary (+RM10)", @"Others (100%)", nil];
    
    UIToolbar *accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)];
    accessoryView.barTintColor = [UIColor groupTableViewBackgroundColor];
    accessoryView.tintColor = [UIColor skyBlueColor];
    
    accessoryView.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [accessoryView sizeToFit];
    self.priceValueTextField.inputAccessoryView = accessoryView;
}

- (void)handleTap {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapReset:(id)sender {
    self.priceValueTextField.text = @"";
    self.relationshipLabel.text = @"";
    self.resultTextField.text = @"";
}

- (IBAction)didTapCalculate:(id)sender {
    NSUInteger stamDuty = [self.priceValueTextField.text integerValue];
    if ([self.priceValueTextField.text isEqualToString:@""]){
        [QMAlert showAlertWithMessage:@"Please input the price or market value to calculate stamp duty" actionSuccess:NO inViewController:self];
        return;
    }
    double calcluatedValue = 0;
    if (stamDuty >= 100000) {
        calcluatedValue += 100000* 0.01;
    } else {
        calcluatedValue += stamDuty* 0.01;
    }
    
    stamDuty -= 100000;
    
    if (stamDuty > 0 && stamDuty < 400000){
        calcluatedValue += stamDuty*0.02;
    } else if (stamDuty >= 400000) {
        calcluatedValue += 400000*0.02;
    }
    
    stamDuty -= 400000;
    
    if (stamDuty > 0) {
        calcluatedValue += stamDuty*0.03;
    }
    
    if ([self.relationshipLabel.text isEqualToString:@"Seller-Purchaser (100%)"])
    {
        calcluatedValue *= 1; // 100%
    } else if ([self.relationshipLabel.text isEqualToString:@"Husband-wife (0%)"]){
        // No more stamp duty
        calcluatedValue = 0;
    } else if ([self.relationshipLabel.text isEqualToString:@"Parenet-Child (50%)"]){
        calcluatedValue *= .5; // 50%
    } else if ([self.relationshipLabel.text isEqualToString:@"Grandparent-Grandchild (50%)"]){
        calcluatedValue *= .5; // 50%
    } else if ([self.relationshipLabel.text isEqualToString:@"Trustee-Beneficiary (+RM10)"] || [self.relationshipLabel.text isEqualToString:@"Administrator-Beneficiary (+RM10)"]){
        calcluatedValue += 10; // Add RM10
    } else {
        calcluatedValue *= 1; // 100%
    }
    
    
    self.resultTextField.text = [NSString stringWithFormat:@"%.2f", calcluatedValue];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 1;
    }
    return 0;
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        [ActionSheetStringPicker showPickerWithTitle:@"Select a Relation"
                                            rows:self.relationsArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               self.relationshipLabel.text = selectedValue;
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.relationshipLabel];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
