//
//  StartViewController.m
//  FileService
/*
 * *********************************************************************************************************************
 *
 *  BACKENDLESS.COM CONFIDENTIAL
 *
 *  ********************************************************************************************************************
 *
 *  Copyright 2014 BACKENDLESS.COM. All Rights Reserved.
 *
 *  NOTICE: All information contained herein is, and remains the property of Backendless.com and its suppliers,
 *  if any. The intellectual and technical concepts contained herein are proprietary to Backendless.com and its
 *  suppliers and may be covered by U.S. and Foreign Patents, patents in process, and are protected by trade secret
 *  or copyright law. Dissemination of this information or reproduction of this material is strictly forbidden
 *  unless prior written permission is obtained from Backendless.com.
 *
 *  ********************************************************************************************************************
 */

#import "StartViewController.h"
#import "Backendless.h"
#import "ImagePreviewViewController.h"

@interface StartViewController ()
-(void)showAlert:(NSString *)message;
@end

@implementation StartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BackendlessUser *currentUser;
    currentUser = backendless.userService.currentUser;
    NSLog(@"The current user is: %@", currentUser);
    
    @try {
        [backendless initAppFault];
    }
    @catch (Fault *fault) {
        [self showAlert:fault.message];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlert:(NSString *)message {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error:" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [av show];
}

- (void)takePhoto:(id)sender
{

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
    
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
//        picker.showsCameraControls = YES;
//    }
//    else
//    {
//        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//    }
//    [self presentViewController:picker animated:YES completion:^{}];
}

- (IBAction)uploadPhoto:(id)sender {
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.navigationController presentViewController:imgPicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        ImagePreviewViewController *imgPreview = [[self storyboard] instantiateViewControllerWithIdentifier:@"ImagePreviewViewController"];
        imgPreview.mainImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self.navigationController pushViewController:imgPreview animated:YES];
    }];  
}
@end
