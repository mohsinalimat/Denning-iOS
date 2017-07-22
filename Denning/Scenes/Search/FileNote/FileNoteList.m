//
//  FileNoteList.m
//  Denning
//
//  Created by Ho Thong Mee on 19/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "FileNoteList.h"
#import "FileNoteCell.h"
#import "FileNote.h"

@interface FileNoteList ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    __block BOOL isLoading;
    __block BOOL isFirstLoading;
    BOOL initCall;
    BOOL isAppending;
    NSNumber* _page;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *fileNo;
@property (weak, nonatomic) IBOutlet UILabel *fileName;

@end

@implementation FileNoteList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateHeaderInfo];
    [self registerNibs];
}


- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillDisappear:animated];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [self openFileNote];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerNibs {
    [FileNoteCell registerForReuseInTableView:self.tableView];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = THE_CELL_HEIGHT;
}

- (void) updateHeaderInfo {
    NSArray* item = [DIHelpers separateFileNameAndNoFromTitle:_resultModel.title];
    _fileNo.text = item[0];
    _fileName.text = item[1];

    _page = @(1);
}

- (IBAction)dismissScreen:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) openFileNote {
    if (isLoading) return;
    isLoading = YES;
    
    [SVProgressHUD showWithStatus:@"Loading"];
    @weakify(self);
    [[QMNetworkManager sharedManager] loadFileNoteListWithCode:_resultModel.key withPage:_page completion:^(NSArray * _Nonnull result, NSError * _Nonnull error) {
        
        @strongify(self);
        self->isLoading = NO;
        [SVProgressHUD dismiss];
        if (error == nil) {
            if (result.count != 0) {
                _page = [NSNumber numberWithInteger:[_page integerValue] + 1];
            }
            if (isAppending) {
                _listOfFileNotes = [[_listOfFileNotes arrayByAddingObjectsFromArray:result] mutableCopy];
                
            } else {
                _listOfFileNotes = result;
            }
            [self.tableView reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
        
        [self performSelector:@selector(clean) withObject:nil afterDelay:0.5];
    }];
}

- (void) clean {
    isLoading = NO;
    isFirstLoading = NO;
}

- (void) appendList {
    isAppending = YES;
    [self openFileNote];
}

- (IBAction)addNewNote:(id)sender {
    [self performSegueWithIdentifier:kFileNoteSegue sender:nil];
}


#pragma mark - ScrollView Delegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    
    if (offsetY > contentHeight - scrollView.frame.size.height && !isFirstLoading && !isLoading) {
        
        [self appendList];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _listOfFileNotes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FileNoteModel *model = _listOfFileNotes[indexPath.row];
    
    FileNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:[FileNoteCell cellIdentifier] forIndexPath:indexPath];
    
    [cell configureCellWithModel:model];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kFileNoteSegue sender:_listOfFileNotes[indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:kFileNoteSegue]) {
        FileNote *vc = segue.destinationViewController;
        vc.noteModel = sender;
        vc.fileNo = _fileNo.text;
        vc.fileName = _fileName.text;
    }
}


@end
