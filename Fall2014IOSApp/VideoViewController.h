//
//  VideoViewController.h
//  Winter2016IOSApp
//
//  Created by Barry on 10/14/15.
//  Copyright © 2015 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface VideoViewController : UIViewController<UIWebViewDelegate>

//@property (strong, nonatomic) IBOutlet YTPlayerView *playerView;

@property (strong, nonatomic) IBOutlet UIWebView *webView;

//- (IBAction)playVideo:(id)sender;

@end
