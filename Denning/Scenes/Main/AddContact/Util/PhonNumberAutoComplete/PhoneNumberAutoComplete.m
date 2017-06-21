//
//  PhonNumberAutoComplete.m
//  Denning
//
//  Created by Ho Thong Mee on 15/06/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "PhoneNumberAutoComplete.h"
#import "MLPAutoCompleteTextField.h"
#import "DEMOCustomAutoCompleteCell.h"
#import "DEMOCustomAutoCompleteObject.h"
#import "AFHTTPSessionOperation.h"

@interface PhoneNumberAutoComplete()
<UITextFieldDelegate,MLPAutoCompleteTextFieldDelegate, MLPAutoCompleteTextFieldDataSource
>
{
    NSArray* countriesList;
    NSString* countryCode, *countryCallingCode;
}

@property (weak, nonatomic) IBOutlet MLPAutoCompleteTextField *autocompleteTF;
@end

@implementation PhoneNumberAutoComplete

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureAutocompleteSearch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [super viewWillDisappear:animated];
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) configureAutocompleteSearch {
    UIToolbar* _accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)];
    _accessoryView.barTintColor = [UIColor groupTableViewBackgroundColor];
    _accessoryView.tintColor = [UIColor babyRed];
    
    _accessoryView.items = @[
                             [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                             [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [_accessoryView sizeToFit];
    
    self.autocompleteTF.delegate = self;
    self.autocompleteTF.autoCompleteDataSource = self;
    self.autocompleteTF.autoCompleteDelegate = self;
    self.autocompleteTF.backgroundColor = [UIColor whiteColor];
    [self.autocompleteTF registerAutoCompleteCellClass:[DEMOCustomAutoCompleteCell class]
                                forCellReuseIdentifier:@"CustomCellId"];
    self.autocompleteTF.maximumNumberOfAutoCompleteRows = 7;
    self.autocompleteTF.applyBoldEffectToAutoCompleteSuggestions = YES;
    self.autocompleteTF.showAutoCompleteTableWhenEditingBegins = YES;
    self.autocompleteTF.disableAutoCompleteTableUserInteractionWhileFetching = YES;
    [self.autocompleteTF setAutoCompleteRegularFontName:@"SFUIText-Regular"];
    self.autocompleteTF.inputAccessoryView = _accessoryView;
    [self.autocompleteTF becomeFirstResponder];
    //    self.details.autoCompleteTableAppearsAsKeyboardAccessory = YES;
    
    
    // add search icon to the left view
    self.autocompleteTF.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* searchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search_black"]];
    self.autocompleteTF.leftView = searchImageView;
}

- (void)handleTap {
    [self.view endEditing:YES];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentSizeInPopup = CGSizeMake(250, 250);
    self.landscapeContentSizeInPopup = CGSizeMake(250, 250);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Select" style:UIBarButtonItemStylePlain target:self action:@selector(nextBtnDidTap)];
    self.title = @"Select ContryCode";
}

- (void) nextBtnDidTap
{
    [self.popupController dismissWithCompletion:^{
        self.updateHandler(countryCode, countryCallingCode);
    }];
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"countries" ofType:@"json"]];
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        NSLog(@"%@", [localError userInfo]);
    }
    
    countriesList = (NSArray *)parsedObject;
    NSMutableArray* countriesNameList = [NSMutableArray new];
    for (id obj in countriesList) {
        NSString* countryNameAndCode = [NSString stringWithFormat:@"%@ (%@)",[obj objectForKey:kCountryName],  [obj objectForKey:kCountryCallingCode]];
        [countriesNameList addObject:countryNameAndCode];
    }
    
    handler([countriesNameList copy]);
}


#pragma mark - MLPAutoCompleteTextField Delegate

- (BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    cell.textLabel.text = autocompleteString;
    return YES;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *items = [[selectedString componentsSeparatedByString:@"("] mutableCopy];
    if ([items count] > 1) {
        items[1] = [items[1] substringToIndex:((NSString*)items[1]).length-1];
    }
    
    countryCode = items[0];
    countryCallingCode = items[1];
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField willHideAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view will be removed from the view hierarchy");
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField willShowAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField didHideAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view ws removed from the view hierarchy");
    
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField didShowAutoCompleteTableView:(UITableView *)autoCompleteTableView {
    NSLog(@"Autocomplete table view was added to the view hierarchy");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
