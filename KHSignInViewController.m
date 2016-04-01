//
//  KHSignInViewController.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHSignInViewController.h"

@interface KHSignInViewController ()

@end

@implementation KHSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)validateInformation {
    
    NSString *username = _usernameTF.text;
    NSString *password = _passwordTF.text;
    
    // if valid
    [self performSegueWithIdentifier:@"signInToHomePage" sender:self];
    
}

-(IBAction)signUpCancelUnwind:(UIStoryboardSegue *)segue {
    
}

- (IBAction)loginButton:(id)sender {
    
    // validate information
    [self validateInformation];
    
}

- (IBAction)skipSigninButton:(id)sender {
    [self performSegueWithIdentifier:@"signInToHomePage" sender:self];
    
}
@end
