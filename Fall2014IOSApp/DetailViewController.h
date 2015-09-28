//
//  DetailViewController.h
//  Fall2015IOSApp
//
//  Created by Barry on 4/30/15.
//  Copyright (c) 2015 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end