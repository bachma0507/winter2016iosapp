//
//  BENewsAlertsTableViewController.m
//  Winter2016IOSApp
//
//  Created by Barry on 4/14/16.
//  Copyright © 2016 BICSI. All rights reserved.
//

#import "BENewsAlertsTableViewController.h"
#import "Fall2013IOSAppAppDelegate.h"
#import "AppConstant.h"
#import "Alerts.h"

extern int iNotificationCounter;

@interface BENewsAlertsTableViewController ()

//{
//    NSMutableArray *_properties;
//}

@end

@implementation BENewsAlertsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
    [self dataQuery];
    
    //_properties = [NSMutableArray arrayWithObjects: @"one", @"two", @"three", nil];
    
    /*if ([[NSUserDefaults standardUserDefaults] objectForKey:@"objectIDArray"]){
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"objectIDArray"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];*/
    
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dataQuery{
    QueryOptions *queryOptions = [QueryOptions query];
    queryOptions.relationsDepth = @1;
    BackendlessDataQuery *dataQuery = [BackendlessDataQuery query];
    dataQuery.queryOptions = queryOptions;
    [backendless.persistenceService find:[Alerts class]
                               dataQuery:[BackendlessDataQuery query]
                                response:^(BackendlessCollection *collection){
                                    NSLog(@"List of items properties in collection: %@", collection);
                                    
                                    //_properties = [NSMutableArray arrayWithArray:collection];
                                    //NSLog(@"The collection string is: %@", collection);
                                    //id object = [_object isKindOfClass:[NSArray class]]? [_object firstObject] : _object;
                                    //if (![object isKindOfClass:[NSString class]]) {
                                    _collectiondata = collection.data;
                                    
                                    //_properties = [NSMutableArray arrayWithArray:[Types propertyKeys:collectiondata[0]]];
                                    //[_properties removeObjectsInArray:@[@"__meta", @"created", @"updated", @"___class", @"objectId", @"ownerId"]];
                                    //}
                                    NSLog(@"List of items in collection.data: %@", collection.data);
                                    
                                    [self.tableView reloadData];
                                    
                                }
                                   error:^(Fault *fault) {
                                   }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //return _collectiondata.count;
    return _collectiondata.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject *prop = [_collectiondata[indexPath.row] valueForKey:@"text"];
    //NSLog(@"List of items in prop description in table: %@", [[prop description] stringByReplacingOccurrencesOfString:@"\n" withString:@" "]);
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [[prop description] stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.numberOfLines = 4;
    return cell;
    
    //NSLog(@"List of items in prop description in table in OnePropertyVC: %@", [[prop description] stringByReplacingOccurrencesOfString:@"\n" withString:@" "]);
    //return cell;
    //PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
    //    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
     //                                 reuseIdentifier:CellIdentifier];
    //}
    
    // Configure the cell to show todo item with a priority at the bottom
    //cell.textLabel.text = [_properties valueForKey:@"text"];
    //cell.textLabel.text = _object[indexPath.row];
    //cell.textLabel.text = _properties[indexPath.row];
    
    //return cell;
    
    //    NSDateFormatter *timeFormatter1 = [[NSDateFormatter alloc] init];
    //    [timeFormatter1 setDateFormat:@"MMM dd yyyy, hh:mm"][
    //    NSDate * cDate = [object objectForKey:@"createdAt"];
    //    NSString *mycDate = [timeFormatter1 stringFromDate:cDate];
    //
    //    NSLog(@"PF_ALERTS_CREATEDAT is: %@", mycDate);
    //
    //    cell.detailTextLabel.text = mycDate;
    //    cell.detailTextLabel.font = [UIFont systemFontOfSize:10.0];
    
    
    //NSLog(@"UITableView method is called");
    
    
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    if(indexPath.row % 2 == 0){
        UIColor *altCellColor = [UIColor colorWithRed:246/255.0 green:235/255.0 blue:253/255.0 alpha:1.0];
        cell.backgroundColor = altCellColor;
    }
    else{
        cell.backgroundColor = [UIColor whiteColor];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self dataQuery];
    //[self refreshTable];
    //[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(refreshTable) userInfo:nil repeats:YES];
    
    //For reseting the tabbar badge value
    //Added by Maaj
    UITabBarController *tBar = (UITabBarController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
    UITabBarItem *item=[[[tBar tabBar] items] objectAtIndex:1];
    [item setBadgeValue:nil];
    iNotificationCounter = 0;
    //----------------------------------------------//
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)refresh:(UIRefreshControl *)sender {
//    
//    [self.tableView reloadData];
//    [sender endRefreshing];
//}
@end
