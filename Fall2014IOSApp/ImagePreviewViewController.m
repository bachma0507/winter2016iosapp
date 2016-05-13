//
//  ImagePreviewViewController.m
//  backendlessDemos
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

#define IS_INDEPENDENCE_VERSION 0

#import "ImagePreviewViewController.h"
#import "BEFile.h"
#import "Backendless.h"
#import "SuccessViewController.h"
#import "BrowseViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ImagePreviewViewController ()
- (void)showAlert:(NSString *)message;
- (void)saveEntityWithName:(NSString *)path;
- (void)prepareView;
@end

@implementation ImagePreviewViewController

@synthesize mainImageView, uploadBtn, urlLable, mainImage, isUpload, file, pathField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    
    
    
    [self prepareView];
	
	// Do any additional setup after loading the view.
}
- (void)prepareView
{
    mainImageView.image = mainImage;
    if (isUpload) {
        [uploadBtn setTitle:@"Report Pic" forState:UIControlStateNormal];
    }
    else{
        [uploadBtn setTitle:@"upload" forState:UIControlStateNormal];
        
    }
    urlLable.text = file.path;
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

- (void)saveEntityWithName:(NSString *)path
{
    
//    id<IDataStore> dataStore = [backendless.persistenceService of:[BEFile class]];
//    BackendlessUser *currentUser = backendless.userService.currentUser;
//    NSString *beFileUser = [NSString stringWithFormat:@"%@",currentUser.name];
//    file.user = [NSString stringWithFormat:@"%@", beFileUser];
    
    //[dataStore save: file responder:nil];
    
    @try {
        
        
        file = [BEFile new];
        file.path = path;
        
        
        
        [backendless.persistenceService save:file];
        
        //Begin Send email
        NSString *post =[[NSString alloc] initWithFormat:@"message=Pic uploaded"];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"https://speedyreference.com/newpicsubmitted.php"];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *responseURL = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&responseURL error:&error];
        
        NSLog(@"Response code: %ld", (long)[responseURL statusCode]);
        
        if ([responseURL statusCode] >= 200 && [responseURL statusCode] < 300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSLog(@"Response ==> %@", responseData);
        }
        

        
        
        
        
    }
    @catch (Fault *fault)
    {
        NSLog(@"ImageViewController -> saveEntityWithIndex: FAULT = %@", fault);
        [self showAlert:fault.message];
    }
    @finally {
        
    }
}

- (void)upload:(id)sender
{
    @try {
        
        NSLog(@"ImageViewController -> upload: ");
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        if (isUpload)
        {
//            [backendless.fileService remove:[NSString stringWithFormat:@"img/%@", [[file.path pathComponents] lastObject]]];
//            [backendless.persistenceService remove:[BEFile class] sid:file.objectId];
//            file = nil;
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image has been deleted" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
//            [alert show];
            
            //Begin Send email
            NSString * badPic = [NSString stringWithFormat:@"img/%@", [[file.path pathComponents] lastObject]];
            
            NSString *post =[[NSString alloc] initWithFormat:@"message= The following pic is objectionable: %@",badPic];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"https://speedyreference.com/objectionablereportsubmitted.php"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            //[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Pic Reported" message:@"Image has been reported" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
                alertView.tag = 1;
                            [alertView show];
            }
            
            //End send email

            
        }
        else
        {
            
            
            
#if 1 // image file
            NSString *fileName = [NSString stringWithFormat:@"img/%0.0f.jpeg",[[NSDate date] timeIntervalSince1970] ];
#if IS_INDEPENDENCE_VERSION // use saveFile method
            BackendlessFile *uploadFile = [backendless.fileService saveFile:fileName content:UIImageJPEGRepresentation(mainImage, 0.1)];
#else // use upload method
            BackendlessFile *uploadFile = [backendless.fileService upload:fileName content:UIImageJPEGRepresentation(mainImage, 0.1)];
#endif
#else // binary array file (test)
            const char myByteArray[] = {0x12,0x23,0x34,0x45,0x56,0x67,0x78,0x89,0x12,0x23,0x34,0x45,0x56,0x67,0x78,0x89};
            NSData *data = [NSData dataWithBytes:myByteArray length:sizeof(myByteArray)];
            BackendlessFile *uploadFile = [backendless.fileService saveFile:@"binary101.bin" content:data overwriteIfExist:YES];
#endif
            [self saveEntityWithName:uploadFile.fileURL];
        }
        isUpload = !isUpload;
    }
    @catch (Fault *fault)
    {
        NSLog(@"ImageViewController -> upload: FAULT = %@", fault);
        [self showAlert:fault.message];
    }
    @finally {
        
        [self prepareView];
        if (isUpload)
        {
            NSURL *fileURL = [NSURL URLWithString:@"/System/Library/Audio/UISounds/Modern/sms_alert_bamboo.caf"]; // see list below
            SystemSoundID soundID;
            AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)fileURL,&soundID);
            AudioServicesPlaySystemSound(soundID);
            
            NSString *message = @"All photos and comments will be reviewed before being posted to the gallery. Any photos with potential indecency issues will not be posted and your user account will be terminated.";
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notification"
                                                               message:message
                                                              delegate:self
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles:nil,nil];
            [alertView show];

            
            SuccessViewController *success = (SuccessViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SuccessViewController"];
            success.url = file.path;
            [self presentViewController:success animated:YES completion:^{}];
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)backBtnClick
{
    //write your code to prepare popview
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //u need to change 0 to other value(,1,2,3) if u have more buttons.then u can check which button was pressed.
    if (alertView.tag ==1) {
        
        if (buttonIndex == 0) {
            
            //[self backBtnClick];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    
    
}

@end
