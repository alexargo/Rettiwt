//
//  TiwtListViewController.m
//  Rettiwt
//
//  Created by Alex Argo on 11/17/11.
//  Copyright (c) 2011 A-Star Software. All rights reserved.
//

#import "TiwtListViewController.h"
#import "CreateTiwtViewController.h"
#import "Parse/Parse.h"

@interface TiwtListViewController()

- (void) logout;
- (void) post;
- (void) refreshTiwts;

@end

@implementation TiwtListViewController

@synthesize tiwts = _tiwts;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {        
        //Show username
        self.title = @"Rettiwt";
        PFUser *currentUser = [PFUser currentUser];
        self.title = currentUser.username;        
        
        //Create post and logout buttons
        UIBarButtonItem *postButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(post)];
        self.navigationItem.rightBarButtonItem = postButton;        
        UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
        self.navigationItem.leftBarButtonItem = logoutButton;
        
        [self refreshTiwts];

    }
    return self;
}

- (void) post {
    CreateTiwtViewController* createViewController =  [[CreateTiwtViewController alloc] initWithNibName:@"CreateTiwtViewController" bundle:nil];
    [self.navigationController presentModalViewController:createViewController animated:YES];    
}

- (void) logout {    
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];    
}

- (void) refreshTiwts {
//    self.tiwts = [NSArray arrayWithObjects:@"Test",@"Test",@"Test", nil];
    PFQuery *tiwtQuery = [PFQuery queryWithClassName:@"Tiwt"];
//    [tiwtQuery whereKey:@"user" equalTo:[PFUser currentUser]];
    [tiwtQuery orderByDescending:@"createdAt"];
    [tiwtQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.tiwts = [NSArray arrayWithArray:objects];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tiwts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = @"Test tiwt";
    cell.detailTextLabel.text = @"username - MM/dd/yyyy HH:mm:ss";
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterShortStyle];
    [dateFormat setTimeStyle:NSDateFormatterMediumStyle];
    
    PFObject *tiwt = [self.tiwts objectAtIndex:indexPath.row];
    PFUser *user = [tiwt objectForKey:@"user"];
    cell.textLabel.text = [tiwt objectForKey:@"message"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",user.username,[dateFormat stringFromDate:tiwt.createdAt]]; 
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
