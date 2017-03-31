//
//  RealPropertyGainTaxViewController.m
//  Denning
//
//  Created by DenningIT on 23/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "RealPropertyGainTaxViewController.h"
#import "CalendarViewController.h"
#import "QMAlert.h"

@interface RealPropertyGainTaxViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *saleCommissionTF;
@property (weak, nonatomic) IBOutlet UITextField *legalCostsTF;
@property (weak, nonatomic) IBOutlet UITextField *renovationImprovementTF;
@property (weak, nonatomic) IBOutlet UITextField *netDisposalPriceTF;
@property (weak, nonatomic) IBOutlet UITextField *purchaseCommisionTF;
@property (weak, nonatomic) IBOutlet UITextField *legalCostsStampDutyTF;
@property (weak, nonatomic) IBOutlet UITextField *otherCostsIncurredTF;
@property (weak, nonatomic) IBOutlet UITextField *netAcquisitionPriceTF;
@property (weak, nonatomic) IBOutlet UITextField *gainsLossTF;
@property (weak, nonatomic) IBOutlet UITextField *dateOfDisposalTF;
@property (weak, nonatomic) IBOutlet UITextField *dateOfAcquizition;
@property (weak, nonatomic) IBOutlet UITextField *numberOfYearHeldTF;
@property (weak, nonatomic) IBOutlet UITextField *statusOfTaxPayerTF;
@property (weak, nonatomic) IBOutlet UITextField *taxPayable;
@property (weak, nonatomic) IBOutlet UITextField *taxRateTF;

@property (strong, nonatomic) NSArray* statusOfTaxPayerArray;

@end

@implementation RealPropertyGainTaxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) prepareUI {
    self.statusOfTaxPayerArray = @[@"Malaysian Individual / PR", @"Malaysian Company", @"Foreigner", @"Foreign Company"];
    
    UIToolbar *accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)];
    accessoryView.barTintColor = [UIColor groupTableViewBackgroundColor];
    accessoryView.tintColor = [UIColor skyBlueColor];
    
    accessoryView.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [accessoryView sizeToFit];
    self.saleCommissionTF.inputAccessoryView = accessoryView;
    self.legalCostsTF.inputAccessoryView = accessoryView;
    self.renovationImprovementTF.inputAccessoryView = accessoryView;
    self.purchaseCommisionTF.inputAccessoryView = accessoryView;
    self.legalCostsStampDutyTF.inputAccessoryView = accessoryView;
    self.otherCostsIncurredTF.inputAccessoryView = accessoryView;
    self.numberOfYearHeldTF.inputAccessoryView = accessoryView;
    
    self.dateOfDisposalTF.delegate = self;
    self.dateOfAcquizition.delegate = self;

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


- (void)showCalendar: (NSString*) typeString {
    [self.view endEditing:YES];
    
    CalendarViewController *calendarViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CalendarView"];
    calendarViewController.realVC = self;
    calendarViewController.typeOfDate = typeString;
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:calendarViewController];
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

- (IBAction)didTapCalculate:(id)sender {
    double netDisposalPrice = [self.saleCommissionTF.text doubleValue] + [self.legalCostsTF.text doubleValue] + [self.renovationImprovementTF.text doubleValue];
    self.netDisposalPriceTF.text = [NSString stringWithFormat:@"%.2f", netDisposalPrice];
    
    double netAcquisitionPrice = [self.purchaseCommisionTF.text doubleValue] + [self.legalCostsStampDutyTF.text doubleValue] + [self.otherCostsIncurredTF.text doubleValue];
    self.netAcquisitionPriceTF.text = [NSString stringWithFormat:@"%.2f", netAcquisitionPrice];
    
    double gainsLoss = netDisposalPrice - netAcquisitionPrice;
    self.gainsLossTF.text = [NSString stringWithFormat:@"%.2f", gainsLoss];
    
    if ([self.dateOfDisposalTF.text isEqualToString:@""]){
        [QMAlert showAlertWithMessage:@"Please input the date of Disposal!" actionSuccess:NO inViewController:self];
        return;
    }
    
    if ([self.dateOfAcquizition.text isEqualToString:@""]){
        [QMAlert showAlertWithMessage:@"Please input the date of Acquisition!" actionSuccess:NO inViewController:self];
        return;
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *disposalDate = [dateFormat dateFromString:self.dateOfDisposalTF.text];
    NSDate *acquisitionDate = [dateFormat dateFromString:self.dateOfAcquizition.text];
    
    if ([disposalDate earlierDate:acquisitionDate]) {
        [QMAlert showAlertWithMessage:@"Opps! there is something. please input valid dates." actionSuccess:NO inViewController:self];
        return;
    }
    
    if ([self.statusOfTaxPayerTF.text isEqualToString:@"Malaysian Company"]) {
        
    } else if ([self.statusOfTaxPayerTF.text isEqualToString:@"Malaysian Individual / PR"]) {
        
    } else if ([self.statusOfTaxPayerTF.text isEqualToString:@"Foreigner"]) {
        
    } else if ([self.statusOfTaxPayerTF.text isEqualToString:@"Foreign Company"]) {
        
    }
}

- (IBAction)didTapReset:(id)sender {
    self.saleCommissionTF.text = @"";
    self.legalCostsTF.text = @"";
    self.renovationImprovementTF.text = @"";
    self.netDisposalPriceTF.text = @"";
    
    self.purchaseCommisionTF.text = @"";
    self.legalCostsStampDutyTF.text = @"";
    self.otherCostsIncurredTF.text = @"";
    self.netAcquisitionPriceTF.text = @"";
    
    self.gainsLossTF.text = @"";
    self.dateOfAcquizition.text = @"";
    self.dateOfDisposalTF.text = @"";
    self.numberOfYearHeldTF.text = @"";
    self.statusOfTaxPayerTF.text = @"";
    self.taxRateTF.text = @"";
    self.taxPayable.text = @"";
}

- (void) updateDateOfDisposal: (NSString*) date
{
    self.dateOfDisposalTF.text = date;
}

- (void) updateDateOfAcquisition: (NSString*) date
{
    self.dateOfAcquizition.text = date;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 4;
    } else if (section == 2) {
        return 6;
    } else if (section == 3) {
        return 1;
    } else if (section == 4) {
        return 1;
    }

    return 0;
}

#pragma mark - TextField delegate
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 28){
        [self showCalendar: @"Date of Disposal"];
    } else if (textField.tag == 29) {
        [self showCalendar: @"Date of Acquisition"];
    }
    
    return false;
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    
    if (indexPath.section == 2 && indexPath.row == 4) {
        [ActionSheetStringPicker showPickerWithTitle:@"Status of Taxpayer"
                                                rows:self.statusOfTaxPayerArray
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               self.statusOfTaxPayerTF.text = selectedValue;
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:self.statusOfTaxPayerTF];
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
