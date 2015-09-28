//
//  MasterViewController.h
//  Fall2015IOSApp
//
//  Created by Barry on 4/30/15.
//  Copyright (c) 2015 BICSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
// Added this statement below
@property (strong, nonatomic) NSArray *items; // Row values for tableView

@end
