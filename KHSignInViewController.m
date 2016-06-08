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
#import "KHRiskFactorModel.h"
#import "UIViewController+Alerts.h"
@import FirebaseAuth;

@interface KHSignInViewController ()
@property NSDictionary *dict;
@property NSArray *occuRiskFactors;
@property NSArray *medicalRiskFactors;
@property NSArray *ageRangeRiskFactors;
@property KHRiskFactorModel *rfModel;
@property(strong, nonatomic) FIRDatabaseReference *ref;
- (IBAction)signupButtonTapped:(id)sender;

@end

@implementation KHSignInViewController

FIRDatabaseHandle _refHandle;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ageRangeRiskFactors = [[NSArray alloc] init];
    _medicalRiskFactors = [[NSArray alloc] init];
    _occuRiskFactors = [[NSArray alloc] init];
    
//    _rfModel = [KHRiskFactorModel sharedModel];
    
//    self.ref = [[FIRDatabase database] reference];
//    _refHandle = [_ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
//        NSDictionary *postDict = snapshot.value;
//        NSLog(@"print snapshotvalue: %@", postDict);
//        
//        // ...
//    }];
    
    
    
    
    /* [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        
//        NSLog(@" json: %@", snapshot.value);
        _dict =[[NSDictionary alloc] initWithDictionary: snapshot.value];
//        NSLog(@" haha: %@", _dict);
//        NSLog(@" dict count: %lu", (unsigned long)_dict.count);
//
//        newDict = _dict[@"RiskFactors"][@"RiskFactors"];
//        NSArray *testArray = [[NSArray alloc] init];
//        testArray = newDict.allValues;
//        NSLog(@" test Allvalue: %@", testArray);
//        testArray = newDict.allKeys;
//        NSLog(@" test alkeys: %@", testArray);
        
        
       
        
        
//        [[KHRiskFactorModel alloc] initWithDict:_dict];

        
        
//        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }]; */
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)validateInformation {
    NSLog(@"about to siginin!");
    [self showSpinner:^{
    [[FIRAuth auth] signInWithEmail:_usernameTF.text
                           password:_passwordTF.text
                         completion:^(FIRUser *user, NSError *error) {
                             // [START_EXCLUDE]
                             [self hideSpinner:^{
                                 if (error) {
                                     [self showMessagePrompt:error.localizedDescription];
                                     return;
                                 }
                                 [self performSegueWithIdentifier:@"signInToHomePage" sender:self];
                             }];
                             // [END_EXCLUDE]
                         }];
    // [END headless_email_auth]
    }];
    
}

-(IBAction)signUpCancelUnwind:(UIStoryboardSegue *)segue {
    
}

- (IBAction)loginButton:(id)sender {
    
    // validate information
    NSLog(@"login tapped!");
    [self validateInformation];
    
}

- (IBAction)skipSigninButton:(id)sender {
    [self performSegueWithIdentifier:@"signInToHomePage" sender:self];
    
}
- (IBAction)signupButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"signIntoSignUpSegue" sender:self];
    
}
@end
