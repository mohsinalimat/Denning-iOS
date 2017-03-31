//
//  IncomeTaxViewController.m
//  Denning
//
//  Created by DenningIT on 22/03/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

typedef NS_ENUM(NSInteger, DIIncomeTaxMaxValues) {
    DIPersonalReliefMax = 9000,
    DILifeInsuranceMax = 6000,
    DIEDUMedicalInsuranceMax = 3000,
    DISOCSOMax = 250,
    
    DISpouceAlimonyPaymentMax = 4000,
    DIMedicalExpMax = 5000,
    DIEducationFeeMax = 7000,
    DIMedicalCheckupMax = 500,
    DIBooksMagazinesMax = 1000,
    DIPCMax = 3000,
    DISportEquimentMax = 300,
    DIDiabledIndividualMax = 6000,
    DIBasicSupportingEquimentMax = 6000,
    
    DIChildReliefMaxPerEach = 2000,
    DIChildOf18PreCourseMaxPerEach = 2000,
    DIChildOf18InUniversityMaxPerEach = 2000,
    DIDiabledChildMaxPerEach = 2000,
    DIAddDisabledChildInUniMaxPerEach = 2000,
    DISSPNMax = 6000,
    DIHouseLoanInterestMax = 10000,
};

#import "IncomeTaxViewController.h"
#import "QMAlert.h"

@interface IncomeTaxViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *PersonalReliefTF;
@property (weak, nonatomic) IBOutlet UITextField *LifeInsuranceTF;
@property (weak, nonatomic) IBOutlet UITextField *EduMedicalInsuranceTF;
@property (weak, nonatomic) IBOutlet UITextField *SOCSOTF;

@property (weak, nonatomic) IBOutlet UITextField *SpouceAlimonyTF;
@property (weak, nonatomic) IBOutlet UITextField *medicalExpTF;
@property (weak, nonatomic) IBOutlet UITextField *educationFeeTF;
@property (weak, nonatomic) IBOutlet UITextField *medicalCheckupTF;
@property (weak, nonatomic) IBOutlet UITextField *booksMagazinesTF;
@property (weak, nonatomic) IBOutlet UITextField *PCTF;
@property (weak, nonatomic) IBOutlet UITextField *sportEquipmentTF;
@property (weak, nonatomic) IBOutlet UITextField *disabledIndividualTF;
@property (weak, nonatomic) IBOutlet UITextField *basicSupportingTF;

@property (weak, nonatomic) IBOutlet UITextField *childReliefTF;
@property (weak, nonatomic) IBOutlet UITextField *numberOfChildReliefTF;
@property (weak, nonatomic) IBOutlet UITextField *childOf18OnPreCourseTF;
@property (weak, nonatomic) IBOutlet UITextField *numberOfChildOf18OnPreCourseTF;
@property (weak, nonatomic) IBOutlet UITextField *childOf18InUniversity;
@property (weak, nonatomic) IBOutlet UITextField *numberOfChildOf18InUniversityTF;
@property (weak, nonatomic) IBOutlet UITextField *disabledChildTF;
@property (weak, nonatomic) IBOutlet UITextField *numberOfDisabledChildTF;
@property (weak, nonatomic) IBOutlet UITextField *addDisabledChildInUniTF;
@property (weak, nonatomic) IBOutlet UITextField *numberOfAddDisabledChildInUniTF;
@property (weak, nonatomic) IBOutlet UITextField *SSPNTF;
@property (weak, nonatomic) IBOutlet UITextField *houseLoanInterestTF;

@property (weak, nonatomic) IBOutlet UITextField *resultLabel;

@end

@implementation IncomeTaxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareUI {
    self.PersonalReliefTF.delegate = self;
    self.LifeInsuranceTF.delegate = self;
    self.EduMedicalInsuranceTF.delegate = self;
    self.SOCSOTF.delegate = self;
    self.SpouceAlimonyTF.delegate = self;
    self.medicalExpTF.delegate = self;
    self.educationFeeTF.delegate = self;
    self.medicalCheckupTF.delegate = self;
    self.booksMagazinesTF.delegate = self;
    self.PCTF.delegate = self;
    self.sportEquipmentTF.delegate = self;
    self.disabledIndividualTF.delegate = self;
    self.basicSupportingTF.delegate = self;
    
    self.childReliefTF.delegate = self;
    self.numberOfChildReliefTF.delegate = self;
    self.childOf18OnPreCourseTF.delegate = self;
    self.numberOfChildOf18OnPreCourseTF.delegate = self;
    self.childOf18InUniversity.delegate = self;
    self.numberOfChildOf18InUniversityTF.delegate = self;
    self.disabledChildTF.delegate = self;
    self.numberOfDisabledChildTF.delegate = self;
    self.addDisabledChildInUniTF.delegate = self;
    self.numberOfAddDisabledChildInUniTF.delegate = self;
    self.SSPNTF.delegate = self;
    self.houseLoanInterestTF.delegate = self;
    
    UIToolbar *accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)];
    accessoryView.barTintColor = [UIColor groupTableViewBackgroundColor];
    accessoryView.tintColor = [UIColor skyBlueColor];
    
    accessoryView.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [accessoryView sizeToFit];
    self.PersonalReliefTF.inputAccessoryView = accessoryView;
    self.LifeInsuranceTF.inputAccessoryView = accessoryView;
    self.EduMedicalInsuranceTF.inputAccessoryView = accessoryView;
    self.SOCSOTF.inputAccessoryView = accessoryView;
    self.SpouceAlimonyTF.inputAccessoryView = accessoryView;
    self.medicalExpTF.inputAccessoryView = accessoryView;
    self.educationFeeTF.inputAccessoryView = accessoryView;
    self.medicalCheckupTF.inputAccessoryView = accessoryView;
    self.booksMagazinesTF.inputAccessoryView = accessoryView;
    self.PCTF.inputAccessoryView = accessoryView;
    self.sportEquipmentTF.inputAccessoryView = accessoryView;
    self.disabledIndividualTF.inputAccessoryView = accessoryView;
    self.basicSupportingTF.inputAccessoryView = accessoryView;
    
    self.childReliefTF.inputAccessoryView = accessoryView;
    self.numberOfChildReliefTF.inputAccessoryView = accessoryView;
    self.childOf18OnPreCourseTF.inputAccessoryView = accessoryView;
    self.numberOfChildOf18OnPreCourseTF.inputAccessoryView = accessoryView;
    self.childOf18InUniversity.inputAccessoryView = accessoryView;
    self.numberOfChildOf18InUniversityTF.inputAccessoryView = accessoryView;
    self.disabledChildTF.inputAccessoryView = accessoryView;
    self.numberOfDisabledChildTF.inputAccessoryView = accessoryView;
    self.addDisabledChildInUniTF.inputAccessoryView = accessoryView;
    self.numberOfAddDisabledChildInUniTF.inputAccessoryView = accessoryView;
    self.SSPNTF.inputAccessoryView = accessoryView;
    self.houseLoanInterestTF.inputAccessoryView = accessoryView;
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
    double totalValue = 0;
    for (NSInteger i = 1; i <= 25; i++) {
        if (i == 14 || i == 16 || i == 18 || i == 20 || i == 22) {
            continue;
        }
        
        UITextField* inputField = [self.view viewWithTag:i];
        if (i == 15 || i == 17 || i == 19 || i == 21 || i == 23) {
            UITextField* numberOfChild = [self.view viewWithTag:i-1];
            totalValue += [inputField.text doubleValue] * [numberOfChild.text integerValue];
        } else {
            totalValue += [inputField.text doubleValue];
        }
    }
    
    // Apply formular to income tax
    double incomeTax = 0;
    
    if (totalValue < 500000) {
        incomeTax = totalValue * 0.01;
        incomeTax = MAX(incomeTax, 500);
    } else {
        incomeTax = 500000 * 0.01;
    }
    
    totalValue -= 500000;
    
    if (totalValue > 0 && totalValue < 500000 ) {
        incomeTax += totalValue * 0.008;
    } else if (totalValue >= 500000){
        incomeTax = 500000 * 0.008;
    }
    totalValue -= 500000;
    
    if (totalValue > 0 && totalValue < 2000000){
        incomeTax += totalValue * 0.007;
    } else if (totalValue > 2000000) {
        incomeTax += 2000000 * 0.007;
    }
    totalValue -= 2000000;
    
    if (totalValue > 0 && totalValue < 2000000){
        incomeTax += totalValue * 0.006;
    } else if (totalValue > 2000000) {
        incomeTax += 2000000 * 0.006;
    }
    totalValue -= 2000000;
    
    if (totalValue > 0 && totalValue < 2500000){
        incomeTax += totalValue * 0.005;
    } else if (totalValue > 2500000) {
        incomeTax += 2500000 * 0.005;
    }
    totalValue -= 2500000;
    
    if (totalValue > 0) {
        [QMAlert showAlertWithMessage:@"Some consideration" actionSuccess:NO inViewController:self];
    }
    
    self.resultLabel.text = [NSString stringWithFormat:@"%.2f", incomeTax];
}

- (IBAction)didTapReset:(id)sender {
    self.PersonalReliefTF.text = @"0";
    self.LifeInsuranceTF.text = @"0";
    self.EduMedicalInsuranceTF.text = @"0";
    self.SOCSOTF.text = @"0";
    self.SpouceAlimonyTF.text = @"0";
    self.medicalExpTF.text = @"0";
    self.educationFeeTF.text = @"0";
    self.medicalCheckupTF.text = @"0";
    self.booksMagazinesTF.text = @"0";
    self.PCTF.text = @"0";
    self.sportEquipmentTF.text = @"0";
    self.disabledIndividualTF.text = @"0";
    self.basicSupportingTF.text = @"0";
    
    self.childReliefTF.text = @"0";
    self.numberOfChildReliefTF.text = @"";
    self.childOf18OnPreCourseTF.text = @"0";
    self.numberOfDisabledChildTF.text = @"";
    self.childOf18InUniversity.text = @"0";
    self.numberOfDisabledChildTF.text = @"";
    self.disabledChildTF.text = @"0";
    self.numberOfDisabledChildTF.text = @"";
    self.addDisabledChildInUniTF.text = @"0";
    self.SSPNTF.text = @"0";
    self.houseLoanInterestTF.text = @"0";
    self.numberOfAddDisabledChildInUniTF.text = @"";
    self.resultLabel.text = @"0";
}

#pragma mark - TextField Delegate
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0 || [textField.text doubleValue] < 0) {
        textField.text = @"0";
    }
    
    switch (textField.tag) {
        case 1:
            if ([textField.text doubleValue] > DIPersonalReliefMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }
            
            break;
        case 2:
            if ([textField.text doubleValue] > DILifeInsuranceMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }
            break;
        case 3:
            if ([textField.text doubleValue] > DIEDUMedicalInsuranceMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }

            break;
        case 4:
            if ([textField.text doubleValue] > DISOCSOMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }

            break;
        case 5:
            if ([textField.text doubleValue] > DISpouceAlimonyPaymentMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }

            break;
        case 6:
            if ([textField.text doubleValue] > DIMedicalExpMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }

            break;
        case 7:
            if ([textField.text doubleValue] > DIEducationFeeMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }

            break;
        case 8:
            if ([textField.text doubleValue] > DIMedicalCheckupMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }

            break;
        case 9:
            if ([textField.text doubleValue] > DIBooksMagazinesMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }

            break;
        case 10:
            if ([textField.text doubleValue] > DIPCMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }

            break;
        
        case 11:
            if ([textField.text doubleValue] > DISportEquimentMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }
            
            break;
        case 12:
            if ([textField.text doubleValue] > DIDiabledIndividualMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }
            break;
        case 13:
            if ([textField.text doubleValue] > DIBasicSupportingEquimentMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }
            break;
        case 14: // Number of Child Relief
            break;
        case 15:
            if ([textField.text doubleValue] > DIChildReliefMaxPerEach){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }
            break;
        case 16: // Number of Child of 18 + on Pre-Course
            break;
        case 17:
            if ([textField.text doubleValue] > DIChildOf18PreCourseMaxPerEach){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }
            break;
        case 18: // number of Child of 18+ in University
            break;
        case 19:
            if ([textField.text doubleValue] > DIChildOf18InUniversityMaxPerEach){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }
            break;
        case 20: // number of Diabled Child
            break;
        case 21:
            if ([textField.text doubleValue] > DIDiabledChildMaxPerEach){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }
            break;
        case 22: // number of Add Disabled child in Uni
            break;
        case 23:
            if ([textField.text doubleValue] > DIAddDisabledChildInUniMaxPerEach){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }
            break;
        case 24:
            if ([textField.text doubleValue] > DISSPNMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }
            break;
        case 25:
            if ([textField.text doubleValue] > DIHouseLoanInterestMax){
                textField.text = [NSString stringWithFormat:@"%ld", (long)DIPersonalReliefMax ];
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 8;
    } else if (section == 2) {
        return 7;
    } else if (section == 3) {
        return 1;
    } else if (section == 4) {
        return 1;
    }
    
    return 0;
}


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
