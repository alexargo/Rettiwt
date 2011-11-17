//
//  LoginViewController.m
//  Rettiwt
//
//  Created by Alex Argo on 11/17/11.
//  Copyright (c) 2011 A-Star Software. All rights reserved.
//

#import "LoginViewController.h"
#import "TiwtListViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController()
    - (void) showTiwtListAnimated:(BOOL) animated;
@end

@implementation LoginViewController
@synthesize textFieldUsername;
@synthesize textFieldPassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Rettiwt";
    }
    return self;
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
    // Do any additional setup after loading the view from its nib.
    if([PFUser currentUser]) {
        [self showTiwtListAnimated:NO];
    }
}

- (void)viewDidUnload
{
    [self setTextFieldUsername:nil];
    [self setTextFieldPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)login:(id)sender {
    [PFUser logInWithUsernameInBackground:self.textFieldUsername.text password:self.textFieldPassword.text block:^(PFUser *user, NSError *error) {
        if(!error) {
            [self showTiwtListAnimated:YES];
        }
    }];
}

- (IBAction)create:(id)sender {
    //create user
    PFUser *user = [[PFUser alloc] init];
    user.username = self.textFieldUsername.text;
    user.password = self.textFieldPassword.text;
    
    //signup
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        //error handling
        if (!error) {
            [self showTiwtListAnimated: YES];
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            // Show the errorString somewhere and let the user try again.
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil];
            [alert show];
        }
    }];        
 }

- (IBAction)forgotPassword:(id)sender {
    [PFUser requestPasswordResetForEmailInBackground:self.textFieldUsername.text];
}

- (void) showTiwtListAnimated:(BOOL) animated {
    TiwtListViewController* listViewController =  [[TiwtListViewController alloc] initWithNibName:@"TiwtListViewController" bundle:nil];
    [self.navigationController pushViewController:listViewController animated:animated];
}

@end
