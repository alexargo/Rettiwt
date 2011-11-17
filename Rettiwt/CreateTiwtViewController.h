//
//  CreateTiwtViewController.h
//  Rettiwt
//
//  Created by Alex Argo on 11/16/11.
//  Copyright (c) 2011 A-Star Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateTiwtViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)close:(id)sender;
- (IBAction)send:(id)sender;
@end
