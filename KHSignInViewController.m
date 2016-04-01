//
//  KHSignInViewController.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHSignInViewController.h"
#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>

@interface KHSignInViewController ()
@property NSDictionary *dict;
@end

@implementation KHSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://pocdoc.firebaseio.com"];
    [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        
        
//        NSLog(@" json: %@", snapshot.value);
        _dict =[[NSDictionary alloc] initWithDictionary: snapshot.value];
        NSLog(@" haha: %@", _dict);
//        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];


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

- (IBAction)signupButton:(id)sender {
    
}

- (IBAction)loginButton:(id)sender {
    
}

- (IBAction)skipSigninButton:(id)sender {
    [self performSegueWithIdentifier:@"signInToHomePage" sender:self];
    
}
@end
