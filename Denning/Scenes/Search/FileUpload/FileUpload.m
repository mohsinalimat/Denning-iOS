//
//  FileUpload.m
//  Denning
//
//  Created by Ho Thong Mee on 19/07/2017.
//  Copyright © 2017 DenningIT. All rights reserved.
//

#import "FileUpload.h"
#import "ChangeBranchViewController.h"
#import "SuggestedFileName.h"
#import <NYTPhotoViewer/NYTPhotosViewController.h>
#import "QMPhoto.h"
#import "SimpleMatterViewController.h"
#import "UIImage+Base64.h"

@interface FileUpload ()< UIImagePickerControllerDelegate, UINavigationControllerDelegate,
NYTPhotosViewControllerDelegate>
{
    NSString* API;
    NSString* nameCode, *systemNo;
    __block BOOL isLoading;
}
@property (weak, nonatomic) IBOutlet UILabel *firmName;
@property (weak, nonatomic) IBOutlet UILabel *uploadedFile;
@property (weak, nonatomic) IBOutlet UILabel *uploadTo;
@property (weak, nonatomic) IBOutlet UIImageView *imagePreview;
@property (weak, nonatomic) IBOutlet UILabel *renameFile;
@property (weak, nonatomic) IBOutlet UITextView *remarks;
//@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (nonatomic) UIImagePickerController *imagePickerController;

@end

@implementation FileUpload

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
    UIToolbar *accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.view.frame), 50)];
    accessoryView.barTintColor = [UIColor groupTableViewBackgroundColor];
    accessoryView.tintColor = [UIColor babyRed];
    
    accessoryView.items = @[
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(handleTap)]];
    [accessoryView sizeToFit];
    self.remarks.inputAccessoryView = accessoryView;
    
//    @weakify(self);
//    self.imagePicker.finalizationBlock = ^(UIImagePickerController __unused  *picker, NSDictionary *info) {
//        @strongify(self);
//        //Your implementation here
//        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//        self.imagePreview.image = image;
//        [self dismissViewControllerAnimated:YES completion:nil];
//    };
//    
//    self.imagePicker.cancellationBlock = ^(UIImagePickerController  __unused *picker)
//    {
//        @strongify(self);
//        [self dismissViewControllerAnimated:YES completion:nil];
//    };
}


//- (UIImagePickerController *)imagePicker {
//    if (_imagePicker == nil) {
//        _imagePicker = [[UIImagePickerController alloc] init];
//    }
//    
//    _imagePicker.allowsEditing = NO;
//    _imagePicker.cropMode = DZNPhotoEditorViewControllerCropModeNone;
////    CGSize newRectSize = self.view.frame.size;
////    _imagePicker.cropSize = newRectSize;
////    
//    return _imagePicker;
//}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.imagePreview.image = [info valueForKey:UIImagePickerControllerOriginalImage];
    _imagePickerController = nil;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        //.. done dismissing
    }];
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType fromButton:(UIBarButtonItem *)button
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    imagePickerController.modalPresentationStyle =
    (sourceType == UIImagePickerControllerSourceTypeCamera) ? UIModalPresentationFullScreen : UIModalPresentationPopover;
    
    UIPopoverPresentationController *presentationController = imagePickerController.popoverPresentationController;
    presentationController.barButtonItem = button;  // display popover from the UIBarButtonItem as an anchor
    presentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        // The user wants to use the camera interface. Set up our custom overlay view for the camera
        
        /*
         Load the overlay view from the OverlayView nib file. Self is the File's Owner for the nib file, so the overlayView outlet is set to the main view in the nib. Pass that view to the image picker controller to use as its overlay view, and set self's reference to the view to nil.
         */
    }
    
    _imagePickerController = imagePickerController; // we need this for later
    
    [self presentViewController:self.imagePickerController animated:YES completion:^{
        //.. done presenting
    }];
}


- (void) handleTap {
    [self.view endEditing:YES];
}

- (IBAction)didTapSend:(id)sender {
    if (isLoading) return;
    isLoading = YES;
    if (_firmName.text.length == 0) {
        [QMAlert showAlertWithMessage:@"Please select the firm to upload" actionSuccess:NO inViewController:self];
        return;
    }

    if (_uploadedFile.text.length == 0) {
        [QMAlert showAlertWithMessage:@"Please select the file to upload" actionSuccess:NO inViewController:self];
        return;
    }
    if (_renameFile.text.length == 0) {
        [QMAlert showAlertWithMessage:@"Please input the file name" actionSuccess:NO inViewController:self];
        return;
    }
    NSData* imageData = UIImageJPEGRepresentation(_imagePreview.image, 1);
    NSNumber* length = [NSNumber numberWithInteger:imageData.length];
    NSDictionary* params = @{@"fileNo1":systemNo,
                             @"FileName":[_renameFile.text stringByAppendingString:@".jpg"],
                             @"MimeType":@"jpg",
                             @"dateCreate":[DIHelpers todayWithTime],
                             @"dateModify":[DIHelpers todayWithTime],
                             @"fileLength":length,
                             @"remarks":_remarks.text,
                             @"base64":[_imagePreview.image encodeToBase64String]
                             };
    [self.navigationController showNotificationWithType:QMNotificationPanelTypeLoading message:NSLocalizedString(@"QM_STR_LOADING", nil) duration:0];
    __weak UINavigationController *navigationController = self.navigationController;
    @weakify(self);
    [[QMNetworkManager sharedManager] uploadFileWithUrl:MATTER_FILEFOLDER params:params WithCompletion:^(NSString * _Nonnull result, NSError * _Nonnull error) {
        @strongify(self)
        self->isLoading = NO;
        if (error == nil && [result isEqualToString:@"200"]) {
            [navigationController showNotificationWithType:QMNotificationPanelTypeSuccess message:@"Success" duration:1.0];
        } else {
           [navigationController showNotificationWithType:QMNotificationPanelTypeWarning message:error.localizedDescription duration:1.0];
        }
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 2;
    } else if (section == 2) {
        return 1;
    } else if (section == 3)
    {
        return 3;
    }
    return 0;
}

- (void)changeBranch {
    if ([DataManager sharedManager].user.userType.length == 0) {
        [QMAlert showAlertWithMessage:@"You cannot access this folder. please subscribe dening user" actionSuccess:NO inViewController:self];
        return;
    }
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"QM_STR_LOADING", nil)];
    
    [[QMNetworkManager sharedManager] userSignInWithEmail:[DataManager sharedManager].user.email password:[DataManager sharedManager].user.password withCompletion:^(BOOL success, NSString * _Nonnull error, NSInteger statusCode, NSDictionary* responseObject) {
        [SVProgressHUD dismiss];
        if (success){
            [[DataManager sharedManager] setUserInfoFromLogin:responseObject];
            if ([[DataManager sharedManager].user.userType isEqualToString:@"denning"]) {
                [self performSegueWithIdentifier:kChangeBranchSegue sender:[DataManager sharedManager].denningArray];
            } else if ([DataManager sharedManager].personalArray.count > 0) {
                [self performSegueWithIdentifier:kChangeBranchSegue sender:[DataManager sharedManager].personalArray];
            } else {
                [QMAlert showAlertWithMessage:@"No more branches" actionSuccess:NO inViewController:self];
            }
        }
    }];
}

- (void) takePhoto {
//    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    [self presentViewController:self.imagePicker animated:YES completion:nil];
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied)
    {
        // Denies access to camera, alert the user.
        // The user has previously denied access. Remind the user that we need camera access to be useful.
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:@"Unable to access the Camera"
                                            message:@"To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app."
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined)
        // The user has not yet been presented with the option to grant access to the camera hardware.
        // Ask for it.
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^( BOOL granted ) {
            // If access was denied, we do not set the setup error message since access was just denied.
            if (granted)
            {
                // Allowed access to camera, go ahead and present the UIImagePickerController.
                [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera fromButton:nil];
            }
        }];
    else
    {
        // Allowed access to camera, go ahead and present the UIImagePickerController.
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera fromButton:nil];
    }
}

- (void) uploadFile {
//    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentViewController:self.imagePicker animated:YES completion:nil];
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary fromButton:nil];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self changeBranch];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self uploadFile];
        } else {
            [self takePhoto];
        }
    } else if (indexPath.section == 2) {
        [self performSegueWithIdentifier:kSimpleMatterSegue sender:nil];
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            if (_imagePreview.image == nil) {
                return;
            }
            QMPhoto *photo = [[QMPhoto alloc] init];
            photo.image = _imagePreview.image;
            
            NYTPhotosViewController *photosViewController = [[NYTPhotosViewController alloc] initWithPhotos:@[photo]];
            
            if ([self conformsToProtocol:@protocol(NYTPhotosViewControllerDelegate)]) {
                
                photosViewController.delegate = (UIViewController<NYTPhotosViewControllerDelegate> *)self;
            }
            
            [photosViewController updateImageForPhoto:photo];
            
            [self presentViewController:photosViewController animated:YES completion:nil];
        } else if (indexPath.row == 1) {
            [self performSegueWithIdentifier:kListWithCodeSegue sender:SEARCH_UPLOAD_SUGGESTED_FILENAME];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - NYTPhotosViewControllerDelegate
- (UIView *)photosViewController:(NYTPhotosViewController *)__unused photosViewController referenceViewForPhoto:(id<NYTPhoto>)__unused photo {
    
    return self.imagePreview;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kChangeBranchSegue]){
        ChangeBranchViewController* changeBranchVC = segue.destinationViewController;
        changeBranchVC.branchArray = sender;
        changeBranchVC.updateHandler = ^(FirmURLModel* model) {
            API = model.firmServerURL;
            _firmName.text = model.name;
        };
    }
    
    if ([segue.identifier isEqualToString:kListWithCodeSegue]) {
        
        SuggestedFileName *listCodeVC = segue.destinationViewController;
        listCodeVC.url = sender;
        listCodeVC.updateHanlder = ^(NSDictionary *response) {
            _renameFile.text = [response valueForKeyNotNull:@"strSuggestedFilename"];
            nameCode = [response valueForKeyNotNull:@"code"];
        };
    }
    
    if ([segue.identifier isEqualToString:kSimpleMatterSegue]) {
        SimpleMatterViewController* matterVC = segue.destinationViewController;
        matterVC.title = @"Upload To";
        matterVC.updateHandler = ^(MatterSimple *model) {
            systemNo = model.systemNo;
            _uploadTo.text = model.primaryClient.name;
        };
        
    }
}


@end
