//
//  AddCourtDiaryViewController.m
//  Denning
//
//  Created by DenningIT on 08/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AddCourtDiaryViewController.h"
#import "ListWithCodeTableViewController.h"
#import "StaffViewController.h"
#import "BirthdayCalendarViewController.h"
#import "DetailWithAutocomplete.h"
#import "SimpleMatterViewController.h"
#import "ClientModel.h"

@interface AddCourtDiaryViewController ()<ContactListWithCodeSelectionDelegate>
{
    NSString* titleOfList;
    NSString* nameOfField;
    NSString* url;
    
    NSString* selectedNatureOfHearing;
    NSString* selectedDetails;
    
    CGFloat autocompleteCellHeight;
    
    __block BOOL isLoading;
    NSString* serverAPI;
}

@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *fileNo;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *caseNo;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *caseName;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *hearingDate;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *time;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *enclosureNo;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *natureOfHearing;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *councilAssigned;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *details;
@property (weak, nonatomic) IBOutlet UIFloatLabelTextField *Remarks;

@property (strong, nonatomic) UIToolbar *accessoryView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedCtrl;

@end

@implementation AddCourtDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void) prepareUI {
    autocompleteCellHeight = 58;
    serverAPI = [DataManager sharedManager].user.serverAPI;
    
    self.fileNo.floatLabelActiveColor = self.fileNo.floatLabelPassiveColor = [UIColor redColor];
    self.caseNo.floatLabelActiveColor = [UIColor redColor];
    self.caseName.floatLabelActiveColor =  [UIColor redColor];
    self.caseName.floatLabelPassiveColor = self.caseNo.floatLabelPassiveColor = [UIColor grayColor];
    self.hearingDate.floatLabelActiveColor = self.hearingDate.floatLabelPassiveColor = [UIColor redColor];
    self.time.floatLabelActiveColor = self.time.floatLabelPassiveColor = [UIColor redColor];
    self.enclosureNo.floatLabelActiveColor = self.enclosureNo.floatLabelPassiveColor = [UIColor redColor];
    self.natureOfHearing.floatLabelActiveColor = self.natureOfHearing.floatLabelPassiveColor = [UIColor redColor];
    self.councilAssigned.floatLabelActiveColor = self.councilAssigned.floatLabelPassiveColor = [UIColor redColor];
//    self.details.floatLabelActiveColor = self.details.floatLabelPassiveColor = [UIColor redColor];
    self.Remarks.floatLabelActiveColor = self.Remarks.floatLabelPassiveColor = [UIColor redColor];
    
    _accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)];
    _accessoryView.barTintColor = [UIColor groupTableViewBackgroundColor];
    _accessoryView.tintColor = [UIColor babyRed];
    
    _accessoryView.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [_accessoryView sizeToFit];
    
    self.enclosureNo.inputAccessoryView = _accessoryView;
    self.Remarks.inputAccessoryView = _accessoryView;
    
    // Hide empty separators
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)handleTap {
    [self.view endEditing:YES];
}

- (IBAction)saveCourt:(id)sender {
    NSDictionary* data = @{
                           @"attendedStatus": @{
                               @"code": @"",
                               @"description": @"Postponed"
                           },
                           @"coram":
                               @{
                                   @"code": @""},
                           @"counselAssigned": self.councilAssigned.text,
                           @"counselAttended": @"",
                           @"court": @"",
                           @"courtDecision": @"",
                           @"enclosureDetails": self.details.text,
                           @"enclosureNo": self.enclosureNo.text,
                           @"fileNo1": self.fileNo.text,
                           @"hearingDate": [NSString stringWithFormat:@"%@ %@", self.hearingDate.text, self.time.text],
                           @"hearingType": self.natureOfHearing.text,
                           @"nextDate": @"",
                           @"nextDateType": @{
                               @"code": @"0",
                               @"description":@"Yes, set next appointment"
                           },
                           @"opponentCounsel": @"bla bla",
                           @"previousDate": @"2016-12-09 00:00:00",
                           @"remark": self.Remarks.text
                           };
    if (isLoading) return;
    isLoading = YES;
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:NSLocalizedString(@"QM_STR_LOADING", nil) duration:0];
    __weak UINavigationController *navigationController = self.navigationController;
    @weakify(self);
    [[QMNetworkManager sharedManager] saveCourtDiaryWithData:data WithCompletion:^(NSArray * _Nonnull result, NSError * _Nonnull error) {
        [navigationController dismissNotificationPanel];
        @strongify(self)
        self->isLoading = NO;
        if (error == nil) {
            [navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:@"Successfully saved" duration:1.0];
            
        } else {
            [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:error.localizedDescription duration:1.0];
        }
 
    }];
}



#pragma mark - Table view data source

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 120;
    } else if(indexPath.row == 6) {
        return autocompleteCellHeight;
    }
    return 58;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 8;
}

- (void) showPopup: (UIViewController*) vc {
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:vc];
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

- (void) showTimePicker {
    [self.view endEditing:YES];
    
    TimePickerViewController *timeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TimePickerView"];
    timeViewController.updateHandler =  ^(NSString* date) {
        self.time.text = date;
    };
    
    [self showPopup:timeViewController];
}

- (void) showCalendar {
    [self.view endEditing:YES];
    
    BirthdayCalendarViewController *calendarViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CalendarView"];
    calendarViewController.updateHandler =  ^(NSString* date) {
        self.hearingDate.text = date;
    };
    [self showPopup:calendarViewController];
}

- (void) showAutocomplete {
    [self.view endEditing:YES];
    
    DetailWithAutocomplete *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailWithAutocomplete"];
    vc.url = COURT_HEARINGDETAIL_GET_URL;
    vc.updateHandler =  ^(NSString* selectedString) {
        self.details.text = selectedString;
    };
    [self showPopup:vc];
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:kSimpleMatterSegue sender:nil];
    } else if (indexPath.row == 1) {
        [self showCalendar];
    } else if (indexPath.row == 2) {
        [self showTimePicker];
    } else if (indexPath.row == 4) {
        titleOfList = @"List of Hearing Type";
        nameOfField = @"natureOfHearing";
        [self performSegueWithIdentifier:kListWithCodeSegue sender:COURT_HEARINGTYPE_GET_URL];
    } else if (indexPath.row == 5) {
        [self performSegueWithIdentifier:kStaffSegue sender:@"attest"];
    } if (indexPath.row == 6) {
        [self showAutocomplete];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) setMatterInfo:(NSString*) fileNoVal caseNo:(NSString*) caseNoVal caseName:(NSString*) caseNameVal
{
    self.fileNo.text = fileNoVal;
    self.caseNo.text = caseNoVal;
    self.caseName.text = caseNameVal;
}

#pragma mark - ContactListWithCodeSelectionDelegate
- (void) didSelectList:(UIViewController *)listVC name:(NSString*) name withModel:(CodeDescription *)model
{
    if ([name isEqualToString:@"natureOfHearing"]) {
        self.natureOfHearing.text = model.descriptionValue;
        selectedNatureOfHearing = model.codeValue;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSimpleMatterSegue]) {
        SimpleMatterViewController* matterVC = segue.destinationViewController;
        matterVC.updateHandler = ^(MatterSimple *model) {
            self.fileNo.text = model.systemNo;
            self.caseNo.text = model.primaryClient.IDNo;
            self.caseName.text = model.primaryClient.name;
        };
    }
    
    if ([segue.identifier isEqualToString:kListWithCodeSegue]) {
        UINavigationController *navVC =segue.destinationViewController;
        
        ListWithCodeTableViewController *listCodeVC = navVC.viewControllers.firstObject;
        listCodeVC.delegate = self;
        listCodeVC.titleOfList = titleOfList;
        listCodeVC.name = nameOfField;
        listCodeVC.url = sender;
    }

    if ([segue.identifier isEqualToString:kStaffSegue]) {
        UINavigationController *navVC =segue.destinationViewController;
        StaffViewController* staffVC = navVC.viewControllers.firstObject;
        staffVC.typeOfStaff = sender;
        staffVC.updateHandler = ^(NSString* typeOfStaff, StaffModel* model) {
            self.councilAssigned.text = model.name;
        };
    }
}


@end
