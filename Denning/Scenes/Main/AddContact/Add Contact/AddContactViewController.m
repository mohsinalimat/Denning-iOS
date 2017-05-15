//
//  AddContactViewController.m
//  Denning
//
//  Created by DenningIT on 20/04/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AddContactViewController.h"
#import "ListWithCodeTableViewController.h"
#import "ListWithDescriptionViewController.h"
#import "ListWithPostCodeViewController.h"
#import "BirthdayCalendarViewController.h"
#import "ContactViewController.h"
#import <NBPhoneNumberUtil.h>
#import <NBPhoneNumber.h>

@interface AddContactViewController()
{
    NSString* titleOfList;
    NSString* nameOfField;
    NSString* selectedIDTypeCode;
    NSString* selectedCitizenCode;
    NSString* selectedIRDBranchCode;
    NSString* selectedTitleCode;
    NSString* selectedOccupationCode;
    
    NSArray *countriesList;
    NSMutableArray *countriesNameList;
    NSString* homeCountryCallingCode;
    NSString* homeCountryCode;
    
    NSString* mobileCountryCallingCode;
    NSString* mobileCountryCode;
    
    NSString* officeCountryCallingCode;
    NSString* officeCountryCode;
    
    NSString* selectedPhoneHome;
    NSString* selectedPhoneMobile;
    NSString* selectedPhoneOffice;
}

@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *IDType;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *IDNo;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *oldIC;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *name;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *contactTitle;

@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *address1;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *address2;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *address3;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *town;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *state;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *postcode;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *email;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *phoneHome;
@property (weak, nonatomic) IBOutlet UIButton *phoneHomeBtn;

@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *phoneMobile;
@property (weak, nonatomic) IBOutlet UIButton *phoneMobileBtn;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *phoneOffice;
@property (weak, nonatomic) IBOutlet UIButton *phoneOfficeBtn;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *country;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *fax;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *contactPerson;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *website;

@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *citizenship;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *dateOfBirth;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *occupation;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *taxFileNo;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *IRDBranch;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *registeredOffice;


@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
    [self parseJSON];
    [self setDefaultCountryCode];
}

- (void)parseJSON {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"countries" ofType:@"json"]];
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        NSLog(@"%@", [localError userInfo]);
    }
    countriesList = (NSArray *)parsedObject;
    countriesNameList = [NSMutableArray new];
    for (id obj in countriesList) {
        NSString* countryNameAndCode = [NSString stringWithFormat:@"%@ (%@)",[obj objectForKey:kCountryName],  [obj objectForKey:kCountryCallingCode]];
        [countriesNameList addObject:countryNameAndCode];
    }
}

- (void) setDefaultCountryCode
{
    NSString* selectedCountryCallingCode, *selectedCountryCode;
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    NSString *buttonTitle;
    for (id obj in countriesList) {
        if ([[obj objectForKey:kCountryCode] isEqualToString:countryCode]) {
            buttonTitle = [NSString stringWithFormat:@"(%@)", [obj objectForKey:kCountryCallingCode]];
            selectedCountryCallingCode = [obj objectForKey:kCountryCallingCode];
            selectedCountryCode = [obj objectForKey:kCountryCode];
        }
    }
    
    [self.phoneHomeBtn setTitle:buttonTitle forState:UIControlStateNormal];
    [self.phoneMobileBtn setTitle:buttonTitle forState:UIControlStateNormal];
    [self.phoneOfficeBtn setTitle:buttonTitle forState:UIControlStateNormal];
    
    homeCountryCode = mobileCountryCode = officeCountryCode = selectedCountryCode;
    homeCountryCallingCode = mobileCountryCallingCode = officeCountryCallingCode = selectedCountryCallingCode;
}

- (IBAction)didTapHomeBtn:(id)sender {
    NSSet* dataSet = [self showCountryCodeList:self.phoneHomeBtn];
    homeCountryCallingCode = [dataSet allObjects].firstObject;
    homeCountryCode =  [dataSet allObjects].lastObject;
}

- (IBAction)didTapMobileBtn:(id)sender {
    NSSet* dataSet = [self showCountryCodeList:self.phoneMobileBtn];
    mobileCountryCallingCode = [dataSet allObjects].firstObject;
    mobileCountryCode =  [dataSet allObjects].lastObject;
}

- (IBAction)didTapOfficeBtn:(id)sender {
    NSSet* dataSet = [self showCountryCodeList:self.phoneOfficeBtn];
    officeCountryCallingCode = [dataSet allObjects].firstObject;
    officeCountryCode =  [dataSet allObjects].lastObject;
}

- (NSSet*) showCountryCodeList:(UIButton*) countryBtn {
    __block NSString* selectedCountryCallingCode;
    __block NSString* selectedCountryCode;

    [ActionSheetStringPicker showPickerWithTitle:@"Select a Contry Code"
                                            rows:countriesNameList
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           selectedCountryCode = [countriesList[selectedIndex] objectForKey:kCountryCode];
                                           selectedCountryCallingCode = [countriesList[selectedIndex] objectForKey:kCountryCallingCode];
                                           NSString *buttonTitle = [NSString stringWithFormat:@"(%@)",selectedCountryCallingCode];
                                           [countryBtn setTitle: buttonTitle forState:UIControlStateNormal];
                                       }
     
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:countryBtn];
    
    NSSet *dataSet = [[NSSet alloc] initWithObjects:selectedCountryCallingCode, selectedCountryCode, nil];
    return dataSet;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) checkPhoneValidation:(NSString*) selectedCountryCallingCode selectedCountryCode:(NSString*)selectedCountryCode textfield:(UITextField*)phoneField
{
    if (phoneField.text.length == 0) {
        return YES;
    }
    NBPhoneNumberUtil *phoneUtil = [[NBPhoneNumberUtil alloc] init];
    NSError *anError = nil;
    selectedPhoneHome = [selectedCountryCallingCode stringByAppendingString:phoneField.text];
    NBPhoneNumber *myPhoneNumber = [phoneUtil parse:phoneField.text
                                 defaultRegion:selectedCountryCode error:&anError];
    if (![phoneUtil isValidNumber:myPhoneNumber]) {
        [QMAlert showAlertWithMessage:@"Please input valid phone number" actionSuccess:NO inViewController:self];
        return NO;
    }
    
    return YES;
}

- (BOOL) checkValidation {
    if (selectedIDTypeCode.length == 0) {
        [QMAlert showAlertWithMessage:@"ID Type is must" actionSuccess:NO inViewController:self];
        return NO;
    }
    
    if (self.IDNo.text.length == 0) {
        [QMAlert showAlertWithMessage:@"ID No is must" actionSuccess:NO inViewController:self];
        return NO;
    }
    
    if (self.name.text.length == 0) {
        [QMAlert showAlertWithMessage:@"ID No is must" actionSuccess:NO inViewController:self];
        return NO;
    }
    
    if (self.IDNo.text.length == 0) {
        [QMAlert showAlertWithMessage:@"ID No is must" actionSuccess:NO inViewController:self];
        return NO;
    }
    
    if (![self checkPhoneValidation:homeCountryCallingCode selectedCountryCode:homeCountryCode textfield:self.phoneHome]) {
        return NO;
    }
    
    if (![self checkPhoneValidation:mobileCountryCallingCode selectedCountryCode:mobileCountryCode textfield:self.phoneMobile]) {
        return NO;
    }
    
    if (![self checkPhoneValidation:officeCountryCallingCode selectedCountryCode:officeCountryCode textfield:self.phoneOffice]) {
        return NO;
    }
    
    return YES;
}

- (IBAction)saveContact:(id)sender {
    if (![self checkValidation]) {
        return;
    }
    
    NSString* fullAddress = [[self.address1.text stringByAppendingString:self.address2.text] stringByAppendingPathComponent:self.address3.text];
    
    NSDictionary* address = @{@"city": self.town.text,
                              @"state": self.state.text,
                              @"country": self.country.text,
                              @"postcode": self.postcode.text,
                              @"fullAddress":fullAddress,
                              @"line1": self.address1.text,
                              @"line2": self.address2.text,
                              @"line2": self.address3.text};
    
    selectedPhoneHome = @"";
    if (self.phoneHome.text.length > 0) {
        selectedPhoneHome = [homeCountryCallingCode stringByAppendingString: self.phoneHome.text];
    }
    selectedPhoneMobile = @"";
    if (self.phoneHome.text.length > 0) {
        selectedPhoneMobile = [mobileCountryCallingCode stringByAppendingString: self.phoneMobile.text];
    }
    selectedPhoneOffice = @"";
    if (self.phoneHome.text.length > 0) {
        selectedPhoneOffice = [officeCountryCallingCode stringByAppendingString: self.phoneOffice.text];
    }
    
    NSDictionary *data = @{@"IDNo": self.IDNo.text,
                           @"IDType": selectedIDTypeCode,
                           @"address": address,
                           @"emailAddress": self.email.text,
                           @"name": self.name.text,
                           @"phoneFax": self.fax.text,
                           @"phoneHome":selectedPhoneHome,
                           @"phoneMobile": selectedPhoneMobile,
                           @"phoneOffice": selectedPhoneOffice,
                           @"title": self.contactTitle.text,
                           @"webSite": self.website.text,
                           @"KPLama": self.oldIC.text};
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:NSLocalizedString(@"QM_STR_LOADING", nil) duration:0];
    
    __weak UINavigationController *navigationController = self.navigationController;

    [[QMNetworkManager sharedManager] saveContactWithData:data withCompletion:^(ContactModel * _Nonnull contactModel, NSError * _Nonnull error) {
        [navigationController dismissNotificationPanel];
        if (error == nil) {
            [navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:@"Successfully Saved" duration:0];
            [self performSegueWithIdentifier:kContactSearchSegue sender:contactModel];
            return;
        } else {
            [navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:error.localizedDescription duration:0];
        }
    }];
}

- (void) prepareUI {
    self.IDType.floatLabelPassiveColor = self.IDType.floatLabelActiveColor = [UIColor redColor];
    self.IDNo.floatLabelActiveColor = self.IDNo.floatLabelPassiveColor = [UIColor redColor];
    self.oldIC.floatLabelActiveColor = self.oldIC.floatLabelPassiveColor = [UIColor redColor];
    self.name.floatLabelActiveColor = self.name.floatLabelPassiveColor = [UIColor redColor];
    self.contactTitle.floatLabelActiveColor = self.contactTitle.floatLabelPassiveColor = [UIColor redColor];
    self.address1.floatLabelActiveColor = self.address1.floatLabelPassiveColor = [UIColor redColor];
    self.address2.floatLabelActiveColor = self.address2.floatLabelPassiveColor = [UIColor redColor];
    self.address3.floatLabelActiveColor = self.address3.floatLabelPassiveColor = [UIColor redColor];
    self.town.floatLabelActiveColor = self.town.floatLabelPassiveColor = [UIColor redColor];
    self.state.floatLabelActiveColor = self.state.floatLabelPassiveColor = [UIColor redColor];
    self.postcode.floatLabelActiveColor = self.postcode.floatLabelPassiveColor = [UIColor redColor];
    self.email.floatLabelActiveColor = self.email.floatLabelPassiveColor = [UIColor redColor];
    self.phoneHome.floatLabelActiveColor = self.phoneHome.floatLabelPassiveColor = [UIColor redColor];
    self.phoneMobile.floatLabelActiveColor = self.phoneMobile.floatLabelPassiveColor = [UIColor redColor];
    self.phoneOffice.floatLabelActiveColor = self.phoneOffice.floatLabelPassiveColor = [UIColor redColor];
    self.country.floatLabelActiveColor = self.country.floatLabelPassiveColor = [UIColor redColor];
    self.fax.floatLabelActiveColor = self.fax.floatLabelPassiveColor = [UIColor redColor];
    self.contactPerson.floatLabelActiveColor = self.contactPerson.floatLabelPassiveColor = [UIColor redColor];
    self.website.floatLabelActiveColor = self.website.floatLabelPassiveColor = [UIColor redColor];
    self.citizenship.floatLabelActiveColor = self.citizenship.floatLabelPassiveColor = [UIColor redColor];
    self.dateOfBirth.floatLabelActiveColor = self.dateOfBirth.floatLabelPassiveColor = [UIColor redColor];
    self.occupation.floatLabelActiveColor = self.occupation.floatLabelPassiveColor = [UIColor redColor];
    self.taxFileNo.floatLabelActiveColor = self.taxFileNo.floatLabelPassiveColor = [UIColor redColor];
    self.IRDBranch.floatLabelActiveColor = self.IRDBranch.floatLabelPassiveColor = [UIColor redColor];
    self.registeredOffice.floatLabelActiveColor = self.registeredOffice.floatLabelPassiveColor = [UIColor redColor];
 
    UIToolbar *accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)];
    accessoryView.barTintColor = [UIColor groupTableViewBackgroundColor];
    accessoryView.tintColor = [UIColor babyRed];
    
    accessoryView.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [accessoryView sizeToFit];
    
    self.IDNo.inputAccessoryView = accessoryView;
    self.oldIC.inputAccessoryView = accessoryView;
    self.name.inputAccessoryView = accessoryView;
    self.address1.inputAccessoryView = accessoryView;
    self.address2.inputAccessoryView = accessoryView;
    self.address3.inputAccessoryView = accessoryView;
    self.email.inputAccessoryView = accessoryView;
    self.phoneHome.inputAccessoryView = accessoryView;
    self.phoneMobile.inputAccessoryView = accessoryView;
    self.phoneOffice.inputAccessoryView = accessoryView;
    self.fax.inputAccessoryView = accessoryView;
    self.contactPerson.inputAccessoryView = accessoryView;
    self.website.inputAccessoryView = accessoryView;
    self.registeredOffice.inputAccessoryView = accessoryView;
    
    // Hide empty separators
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)handleTap {
    [self.view endEditing:YES];
}

- (void) showCalendar {
    [self.view endEditing:YES];
    
    BirthdayCalendarViewController *calendarViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CalendarView"];
    calendarViewController.updateHandler =  ^(NSString* date) {
        self.dateOfBirth.text = date;
    };
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    } else if (section == 1) {
        return 14;
    } else if (section == 2) {
        return 5;
    } else if (section == 3) {
        return 1;
    }
    
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - UIResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(![touch.view isMemberOfClass:[UITextField class]]) {
        [touch.view endEditing:YES];
    }
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { // ID type
            titleOfList = @"List of ID Type";
            nameOfField = @"IDType";
            [self performSegueWithIdentifier:kListWithCodeSegue sender:CONTACT_IDTYPE_URL];
        }
        else if (indexPath.row == 4) { // title
            titleOfList = @"List Of Title";
            nameOfField = @"Title";
            [self performSegueWithIdentifier:kListWithCodeSegue sender:CONTACT_TITLE_URL];
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 3) { // City
            titleOfList = @"List of Cities";
            nameOfField = @"Town";
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:CONTACT_CITY_URL];
        } else if (indexPath.row == 4) { // State
            titleOfList = @"List of States";
            nameOfField = @"State";
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:CONTACT_STATE_URL];
        } else if (indexPath.row == 5) { // Postcode
            [self performSegueWithIdentifier:kListWithPostcodeSegue sender:CONTACT_POSTCODE_URL];
        } else if (indexPath.row == 10) { // Postcode
            titleOfList = @"List of Countries";
            nameOfField = @"Country";
            [self performSegueWithIdentifier:kListWithDescriptionSegue sender:CONTACT_COUNTRY_URL];
        }
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) { // Citizenship
            titleOfList = @"List of Citizens";
            nameOfField = @"Citizen";
            [self performSegueWithIdentifier:kListWithCodeSegue sender:CONTACT_CITIZENSHIP_URL];
        } else if (indexPath.row == 1) {
            [self showCalendar];
        } else if (indexPath.row == 2) { // Occupation
            titleOfList = @"List of Occupations";
            nameOfField = @"Occupation";
            [self performSegueWithIdentifier:kListWithCodeSegue sender:CONTACT_OCCUPATION_URL];
        } else if (indexPath.row == 4) { // Occupation
            titleOfList = @"List of IRD Branches";
            nameOfField = @"IRD Branch";
            [self performSegueWithIdentifier:kListWithCodeSegue sender:CONTACT_IRDBRANCH_URL];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kListWithCodeSegue]) {
        UINavigationController *navVC =segue.destinationViewController;

        ListWithCodeTableViewController *listCodeVC = navVC.viewControllers.firstObject;
        listCodeVC.delegate = self;
        listCodeVC.titleOfList = titleOfList;
        listCodeVC.name = nameOfField;
        listCodeVC.url = sender;
    }
    
    if ([segue.identifier isEqualToString:kListWithDescriptionSegue]) {
        UINavigationController *navVC =segue.destinationViewController;
        
        ListWithDescriptionViewController *listDescVC = navVC.viewControllers.firstObject;
        listDescVC.contactDelegate = self;
        listDescVC.titleOfList = titleOfList;
        listDescVC.name = nameOfField;
        listDescVC.url = sender;
    }
    
    if ([segue.identifier isEqualToString:kListWithPostcodeSegue]) {
        UINavigationController *navVC =segue.destinationViewController;
        
        ListWithPostCodeViewController *listPostcodeVC = navVC.viewControllers.firstObject;
        listPostcodeVC.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:kContactSearchSegue]){
//        UINavigationController* navVC = segue.destinationViewController;
        ContactViewController* contactVC = segue.destinationViewController;
        contactVC.contactModel = sender;
        contactVC.gotoRelatedMatter = @"";
    }
}

#pragma mark - ContactListWithCodeSelectionDelegate
- (void) didSelectList:(UIViewController *)listVC name:(NSString*) name withModel:(CodeDescription *)model
{
    if ([name isEqualToString:@"IDType"]) {
        self.IDType.text = model.descriptionValue;
        selectedIDTypeCode = model.codeValue;
    } else if ([name isEqualToString:@"Title"]) {
        self.contactTitle.text = model.descriptionValue;
        selectedTitleCode = model.codeValue;
    } else if ([name isEqualToString:@"Citizen"]) {
        self.citizenship.text = model.descriptionValue;
        selectedCitizenCode = model.codeValue;
    } else if ([name isEqualToString:@"Occupation"]) {
        self.occupation.text = model.descriptionValue;
        selectedOccupationCode = model.codeValue;
    } else if ([name isEqualToString:@"IRD Branch"]) {
        self.IRDBranch.text = model.descriptionValue;
        selectedIRDBranchCode = model.codeValue;
    }
}

#pragma mark - ContactListWithDescriptionDelegate
- (void) didSelectListWithDescription:(UIViewController *)listVC name:(NSString*) name withString:(NSString *)description
{
    if ([name isEqualToString:@"Town"]) {
        self.town.text = description;
    } else if ([name isEqualToString:@"State"]) {
        self.state.text = description;
    } else if ([name isEqualToString:@"Country"]) {
        self.country.text = description;
    }
}

#pragma mark - ContactPostCodeDelegate
- (void) didSelectListWithPostcode:(UIViewController *)listVC withCityModel:(CityModel *)city
{
    self.postcode.text = city.postcode;
    self.town.text = city.city;
    self.state.text = city.state;
    self.country.text = city.country;
}

@end
