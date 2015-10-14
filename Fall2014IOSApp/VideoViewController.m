//
//  VideoViewController.m
//  Winter2016IOSApp
//
//  Created by Barry on 10/14/15.
//  Copyright © 2015 BICSI. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.playerView loadWithVideoId:@"L3EO0qmfKtI"];
    
    
    NSString * stream = @"https://www.youtube.com/watch?v=L3EO0qmfKtI";
    //NSString * stream = @"http://www.bicsi.org/directory/uplink/default.aspx?id=8027";
    NSURL * url = [NSURL URLWithString:stream];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest: request];
    
    _webView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)playVideo:(id)sender {
//    
//    //NSString * stream = @"https://youtu.be/L3EO0qmfKtI";
//    NSString * stream = @"http://www.bicsi.org/directory/uplink/default.aspx?id=8027";
//    NSURL * url = [NSURL URLWithString:stream];
//    NSURLRequest * request = [NSURLRequest requestWithURL:url];
//    [_webView loadRequest: request];
//}


@end
