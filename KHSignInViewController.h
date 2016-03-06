//
//  KHSignInViewController.h
//  KHHealthCareProj
//
//  Created by Ryan Lu on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHSignInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
- (IBAction)signupButton:(id)sender;
- (IBAction)loginButton:(id)sender;
- (IBAction)skipSigninButton:(id)sender;

@end
