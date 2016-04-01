//
//  KHSignUpViewController.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/31/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHSignUpViewController.h"

@implementation KHSignUpViewController

- (IBAction)signUpClicked:(id)sender {
    
    // validate information
    [self validate];
    
    
    // push to database
    
}


- (void)validate {
    
    // validate information
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Message"
                                message:@"User Created"
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action){
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
