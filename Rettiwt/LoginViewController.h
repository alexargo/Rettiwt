//
//  LoginViewController.h
//  Rettiwt
//
//  Created by Alex Argo on 11/17/11.
//  Copyright (c) 2011 A-Star Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textFieldUsername;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
- (IBAction)login:(id)sender;
- (IBAction)create:(id)sender;
- (IBAction)forgotPassword:(id)sender;
@end
