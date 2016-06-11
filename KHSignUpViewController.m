//
//  KHSignUpViewController.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 6/7/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHSignUpViewController.h"
#import "UIViewController+Alerts.h"
@import FirebaseAuth;
@import FirebaseDatabase;

@interface KHSignUpViewController () {
	FIRDatabaseReference *_FIRRef;
}

@property (weak, nonatomic) IBOutlet UITextField *userNameOutlet;
@property (weak, nonatomic) IBOutlet UITextField *emailOutlet;
@property (weak, nonatomic) IBOutlet UITextField *passwordOutlet;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordOutlet;
- (IBAction)cancerButtonTapped:(id)sender;
- (IBAction)signupButtonTapped:(id)sender;
- (IBAction)bgButtonTapped:(id)sender;
@end

@implementation KHSignUpViewController


-(void)viewDidAppear:(BOOL)animated {
	[self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	_FIRRef = [[FIRDatabase database] reference];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancerButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signupButtonTapped:(id)sender {
    
    if (!_userNameOutlet.text.length || !_emailOutlet.text.length || !_passwordOutlet.text.length || !_confirmPasswordOutlet.text.length) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops"
                                                                                 message:@"Please fill out all the blanks!"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
								   
														 handler:^(UIAlertAction * _Nonnull action) {
															 [self dismissViewControllerAnimated:YES completion:^{
																 [self dismissViewControllerAnimated:YES completion:nil];
															 }];
															 
														 }];
		
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    
    [self showSpinner:^{
        // [START create_user]
        [[FIRAuth auth]
         createUserWithEmail:_emailOutlet.text
         password:_passwordOutlet.text
         completion:^(FIRUser *_Nullable user,NSError *_Nullable error) {
             // [START_EXCLUDE]
             [self hideSpinner:^{
                 if (error) {
                     [self showMessagePrompt: error.localizedDescription];
                     return;
                 }
                 NSString *msg = [NSString stringWithFormat:@"%@ created", user.email];
				 //create usernode
				 [self createUserNode:user];
                 [self showMessagePrompt:msg];
             }];
             // [END_EXCLUDE]
         }];
        // [END create_user]
    }];
    
}

- (void)createUserNode:(FIRUser *)user {
	[[[[_FIRRef child:@"users"] child:user.uid] child:@"userid"] setValue:user.uid withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
		if (error) {
			NSLog(@"Error creating user node: %@", error.localizedDescription);
		} else {
			NSLog(@"Successfully created user node: %@", ref);
			[[[[_FIRRef child:@"users"] child:user.uid] child:@"username"] setValue:_userNameOutlet.text];
			[[[[_FIRRef child:@"users"] child:user.uid] child:@"email"] setValue:user.email];
		}
	}];
}

- (IBAction)bgButtonTapped:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}
@end
