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
{
    double numberOfYears;
    NSDate *disposalDate;
    NSDate *acquisitionDate;
    NSDateFormatter *dateFormat;
    double taxRate;
    double realpropertyTax;
}
@property (weak, nonatomic) IBOutlet UITextField *disposalPriceTF;
@property (weak, nonatomic) IBOutlet UITextField *saleCommissionTF;
@property (weak, nonatomic) IBOutlet UITextField *legalCostsTF;
@property (weak, nonatomic) IBOutlet UITextField *renovationImprovementTF;
@property (weak, nonatomic) IBOutlet UITextField *netDisposalPriceTF;

@property (weak, nonatomic) IBOutlet UITextField *acquisitionPriceTF;
@property (weak, nonatomic) IBOutlet UITextField *purchaseCommisionTF;
@property (weak, nonatomic) IBOutlet UITextField *legalCostsStampDutyTF;
@property (weak, nonatomic) IBOutlet UITextField *otherCostsIncurredTF;
@property (weak, nonatomic) IBOutlet UITextField *netAcquisitionPriceTF;
@property (weak, nonatomic) IBOutlet UITextField *gainsLossTF;
@property (weak, nonatomic) IBOutlet UITextField *dateOfDisposalTF;
@property (weak, nonatomic) IBOutlet UITextField *dateOfAcquizition;
@property (weak, nonatomic) IBOutlet UITextField *numberOfYearHeldTF;
@property (weak, nonatomic) IBOutlet UITextField *statusOfTaxPayerTF;
@property (weak, nonatomic) IBOutlet UITextField *taxRateTF;

@property (weak, nonatomic) IBOutlet UITextField *taxPayable;

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
    accessoryView.tintColor = [UIColor babyRed];
    
    accessoryView.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [accessoryView sizeToFit];
    self.disposalPriceTF.inputAccessoryView = accessoryView;
    self.saleCommissionTF.inputAccessoryView = accessoryView;
    self.legalCostsTF.inputAccessoryView = accessoryView;
    self.renovationImprovementTF.inputAccessoryView = accessoryView;
    self.purchaseCommisionTF.inputAccessoryView = accessoryView;
    self.acquisitionPriceTF.inputAccessoryView = accessoryView;
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
    
//    self.saleCommissionTF.delegate = self;
//    self.legalCostsTF.delegate = self;
//    self.renovationImprovementTF.delegate = self;
//    self.netDisposalPriceTF.delegate = self;
//    
//    self.purchaseCommisionTF.delegate = self;
//    self.legalCostsTF.delegate = self;
//    self.otherCostsIncurredTF.delegate = self;
//    self.netAcquisitionPriceTF.delegate = self;
//    self.gainsLossTF.delegate = self;
//    self.numberOfYearHeldTF.delegate = self;
//    self.taxRateTF.delegate = self;
//    
//    self.taxPayable.delegate = self;
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
    double netDisposalPrice = [self getActualNumber:self.disposalPriceTF.text] - [self getActualNumber:self.saleCommissionTF.text] - [self getActualNumber:self.legalCostsTF.text] - [self getActualNumber:self.renovationImprovementTF.text];
    self.netDisposalPriceTF.text = [NSString stringWithFormat:@"%.2f", netDisposalPrice];
    
    double netAcquisitionPrice = [self getActualNumber:self.acquisitionPriceTF.text] + [self getActualNumber:self.purchaseCommisionTF.text] + [self getActualNumber:self.legalCostsStampDutyTF.text] + [self getActualNumber:self.otherCostsIncurredTF.text];
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
    
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    disposalDate = [dateFormat dateFromString:self.dateOfDisposalTF.text];
    acquisitionDate = [dateFormat dateFromString:self.dateOfAcquizition.text];
    
    if (![disposalDate earlierDate:acquisitionDate]) {
        [QMAlert showAlertWithMessage:@"Opps! there is something. please input valid dates." actionSuccess:NO inViewController:self];
        return;
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [gregorian components:units fromDate:acquisitionDate toDate:disposalDate options:0];
    numberOfYears = [components year];
    NSInteger numberOfMonths = [components month];
    NSInteger numberOfDays = [components day];
    numberOfYears += numberOfMonths / 12 + numberOfDays/365;
    
    self.numberOfYearHeldTF.text = [NSString stringWithFormat:@"%.2f", numberOfYears];
    
    if ([self.statusOfTaxPayerTF.text isEqualToString:@"Malaysian Company"]) {
        [self calculateTaxRateForLocalCompany];
        realpropertyTax =  gainsLoss * taxRate / 100;
    } else if ([self.statusOfTaxPayerTF.text isEqualToString:@"Malaysian Individual / PR"]) {
        [self calculateTaxRateForLocalPerson];
        realpropertyTax =  gainsLoss * taxRate / 100;
        [self applyTaxRestriction];
    } else if ([self.statusOfTaxPayerTF.text isEqualToString:@"Foreigner"]) {
        [self calculateTaxRateForForeignerAndCompany];
        realpropertyTax =  gainsLoss * taxRate / 100;
        [self applyTaxRestriction];
    } else if ([self.statusOfTaxPayerTF.text isEqualToString:@"Foreign Company"]) {
        [self calculateTaxRateForForeignerAndCompany];
        realpropertyTax =  gainsLoss * taxRate / 100;
    }
    
    self.taxRateTF.text = [NSString stringWithFormat:@"%.2f", taxRate];
    self.taxPayable.text = [NSString stringWithFormat:@"%2.f", realpropertyTax];
}

- (void) applyTaxRestriction
{
    if ([acquisitionDate earlierDate:[dateFormat dateFromString:@"2013-01-01"]]) {
        realpropertyTax = MAX(realpropertyTax, 5000);
    } else {
        realpropertyTax = MAX(realpropertyTax, 10000);
    }
}

- (void) calculateTaxRateForLocalCompany
{
    taxRate = 0;
    if ([acquisitionDate laterDate:[dateFormat dateFromString:@"2009-12-31"]] && [acquisitionDate earlierDate:[dateFormat dateFromString:@"2012-01-01"]]){
        taxRate = 5;
    } else if ([acquisitionDate laterDate:[dateFormat dateFromString:@"2011-12-31"]] && [acquisitionDate earlierDate:[dateFormat dateFromString:@"2013-01-01"]]) {
        if (numberOfYears <= 2) {
            taxRate = 10;
        } else if (numberOfYears <= 5) {
            taxRate = 5;
        }
    } else if ([acquisitionDate laterDate:[dateFormat dateFromString:@"2012-12-31"]] && [acquisitionDate earlierDate:[dateFormat dateFromString:@"2014-01-01"]]) {
        if (numberOfYears <= 2) {
            taxRate = 15;
        } else if (numberOfYears <= 5) {
            taxRate = 10;
        }
    } else if ([acquisitionDate laterDate:[dateFormat dateFromString:@"2013-12-31"]]) {
        if (numberOfYears <= 3) {
            taxRate = 30;
        } else if (numberOfYears <= 4) {
            taxRate = 20;
        } else if (numberOfYears <= 5) {
            taxRate = 15;
        } else if (numberOfYears <= 6) {
           taxRate = 5;
        }
    }

}

- (void) calculateTaxRateForLocalPerson
{
    taxRate = 0;
    if ([acquisitionDate laterDate:[dateFormat dateFromString:@"2009-12-31"]] && [acquisitionDate earlierDate:[dateFormat dateFromString:@"2012-01-01"]]){
        taxRate = 5;
    } else if ([acquisitionDate laterDate:[dateFormat dateFromString:@"2011-12-31"]] && [acquisitionDate earlierDate:[dateFormat dateFromString:@"2013-01-01"]]) {
        if (numberOfYears <= 2) {
            taxRate = 10;
        } else if (numberOfYears <= 5) {
            taxRate = 5;
        }
    } else if ([acquisitionDate laterDate:[dateFormat dateFromString:@"2012-12-31"]] && [acquisitionDate earlierDate:[dateFormat dateFromString:@"2014-01-01"]]) {
        if (numberOfYears <= 2) {
            taxRate = 15;
        } else if (numberOfYears <= 5) {
            taxRate = 10;
        }
    } else if ([acquisitionDate laterDate:[dateFormat dateFromString:@"2013-12-31"]]) {
        if (numberOfYears <= 3) {
            taxRate = 30;
        } else if (numberOfYears <= 4) {
            taxRate = 20;
        } else if (numberOfYears <= 5) {
            taxRate = 15;
        }
    }
}

- (void) calculateTaxRateForForeignerAndCompany
{
    taxRate = 0;
    if ([acquisitionDate laterDate:[dateFormat dateFromString:@"1997-10-16"]] && [acquisitionDate earlierDate:[dateFormat dateFromString:@"2007-04-01"]]){
        if (numberOfYears <= 5) {
            taxRate = 30;
        } else {
            taxRate = 5;
        }
    } else if ([acquisitionDate laterDate:[dateFormat dateFromString:@"2007-03-31"]] && [acquisitionDate earlierDate:[dateFormat dateFromString:@"2010-01-01"]]){
        taxRate = 0;
    } else if ([acquisitionDate laterDate:[dateFormat dateFromString:@"2010-05-31"]] && [acquisitionDate earlierDate:[dateFormat dateFromString:@"2012-06-01"]]){
        if (numberOfYears <= 5) {
            taxRate = 5;
        }
    } else if ([acquisitionDate laterDate:[dateFormat dateFromString:@"2012-05-31"]] && [acquisitionDate earlierDate:[dateFormat dateFromString:@"2013-06-01"]]){
        if (numberOfYears <= 2) {
            taxRate = 10;
        } else if (numberOfYears <= 5) {
            taxRate = 5;
        }
    } else if ([acquisitionDate laterDate:[dateFormat dateFromString:@"2013-05-31"]] && [acquisitionDate earlierDate:[dateFormat dateFromString:@"2014-06-01"]]){
        if (numberOfYears <= 2) {
            taxRate = 15;
        } else if (numberOfYears <= 5) {
            taxRate = 10;
        }
    } else if ([acquisitionDate laterDate:[dateFormat dateFromString:@"2014-05-31"]]){
        if (numberOfYears <= 5) {
            taxRate = 30;
        } else {
            taxRate = 5;
        }
    }
}


- (IBAction)didTapReset:(id)sender {
    self.disposalPriceTF.text = @"";
    self.saleCommissionTF.text = @"";
    self.legalCostsTF.text = @"";
    self.renovationImprovementTF.text = @"";
    self.netDisposalPriceTF.text = @"";
    
    self.acquisitionPriceTF.text = @"";
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


- (NSString*) removeCommaFromString: (NSString*) formattedNumber
{
    NSArray * comps = [formattedNumber componentsSeparatedByString:@","];
    
    NSString * result = nil;
    for(NSString *s in comps)
    {
        if(result)
        {
            result = [result stringByAppendingFormat:@"%@",[s capitalizedString]];
        } else
        {
            result = [s capitalizedString];
        }
    }
    
    return result;
}
- (double) getActualNumber: (NSString*) formattedNumber
{
    return [[self removeCommaFromString:formattedNumber] doubleValue];
}

#pragma mark - UITexFieldDelegate
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length > 0) {
        NSString *mystring = [self removeCommaFromString:textField.text];
        NSNumber *number = [NSDecimalNumber decimalNumberWithString:mystring];
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        textField.text = [formatter stringFromNumber:number];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    } else if (section == 1) {
        return 5;
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
