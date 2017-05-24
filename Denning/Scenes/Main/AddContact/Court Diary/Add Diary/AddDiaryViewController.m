//
//  AddDiaryViewController.m
//  Denning
//
//  Created by Ho Thong Mee on 22/05/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "AddDiaryViewController.h"
#import "OfficeDiaryViewController.h"
#import "CourtDiaryViewController.h"
#import "PersonalDiaryViewController.h"

@interface AddDiaryViewController ()
{
    NSInteger   selectedIndex;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *courtSegment;
@property (weak, nonatomic) IBOutlet UIView *container;


@property (strong, nonatomic) NSArray* viewControllers;
@property (strong, nonatomic) NSArray* viewControllerIdentifiers;
@end

@implementation AddDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareUI];
    if ([self.type isEqualToString:@"OfficeDiary"]) {
        [self gotoOfficeDiary];
        self.courtSegment.selectedSegmentIndex = 1;
    } else {
        [self gotoCourtDiary];
        self.courtSegment.selectedSegmentIndex = 0;
    }
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)segmentChanged:(UISegmentedControl*)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self gotoCourtDiary];
            break;
        case 1:
            [self gotoOfficeDiary];
            break;
        case 2:
            [self gotoPersonalDiary];
            break;
            
        default:
            break;
    }
}

- (IBAction)saveDiary:(id)sender {
    switch (selectedIndex) {
        case 0:
            [((CourtDiaryViewController*)self.viewControllers[0]) saveDiary];
            break;
        case 1:
            [((OfficeDiaryViewController*)self.viewControllers[1]) saveDiary];
            break;
        case 2:
            [((PersonalDiaryViewController*)self.viewControllers[2]) saveDiary];
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareUI {
    self.viewControllerIdentifiers = @[@"CourtDiaryViewController", @"OfficeDiaryViewController", @"PersonalDiaryViewController"];
    CourtDiaryViewController * courtDiaryVC = [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerIdentifiers[0]];
    OfficeDiaryViewController *officeDiaryVC = [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerIdentifiers[1]];
    PersonalDiaryViewController *personalDiaryVC = [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerIdentifiers[2]];
    self.viewControllers = @[courtDiaryVC, officeDiaryVC, personalDiaryVC];
    selectedIndex = 0;
}


- (void) addView: (UIViewController*) viewController
{
    [self addChildViewController:viewController];
    [self.container addSubview:viewController.view];
    viewController.view.frame = CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height);
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [viewController didMoveToParentViewController:self];
}

- (void) removeView: (UIViewController*) viewController
{
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}

- (void) gotoCourtDiary {
    self.navigationItem.title = @"Add Court Diary";
    selectedIndex = 0;
    
    [self addView:self.viewControllers[0]];
    [self removeView:self.viewControllers[1]];
    [self removeView:self.viewControllers[2]];
}

- (void) gotoOfficeDiary {
    self.navigationItem.title = @"Add Office Diary";
    selectedIndex = 1;
    
    [self addView:self.viewControllers[1]];
    [self removeView:self.viewControllers[2]];
    [self removeView:self.viewControllers[0]];
}

- (void) gotoPersonalDiary {
    self.navigationItem.title = @"Add Personal Diary";
    selectedIndex = 2;
    
    [self addView:self.viewControllers[2]];
    [self removeView:self.viewControllers[1]];
    [self removeView:self.viewControllers[0]];
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
