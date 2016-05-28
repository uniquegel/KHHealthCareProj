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

@interface KHSignInViewController ()
@property NSDictionary *dict;
@property NSArray *occuRiskFactors;
@property NSArray *medicalRiskFactors;
@property NSArray *ageRangeRiskFactors;
@property KHRiskFactorModel *rfModel;
@end

@implementation KHSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ageRangeRiskFactors = [[NSArray alloc] init];
    _medicalRiskFactors = [[NSArray alloc] init];
    _occuRiskFactors = [[NSArray alloc] init];
    
//    _rfModel = [KHRiskFactorModel sharedModel];
    
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://pocdoc.firebaseio.com"];
    [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        
//        NSLog(@" json: %@", snapshot.value);
        _dict =[[NSDictionary alloc] initWithDictionary: snapshot.value];
        NSLog(@" haha: %@", _dict);
        NSLog(@" dict count: %lu", (unsigned long)_dict.count);
//        
//        newDict = _dict[@"RiskFactors"][@"RiskFactors"];
//        NSArray *testArray = [[NSArray alloc] init];
//        testArray = newDict.allValues;
//        NSLog(@" test Allvalue: %@", testArray);
//        testArray = newDict.allKeys;
//        NSLog(@" test alkeys: %@", testArray);
        
        
       
        
        
//        [[KHRiskFactorModel alloc] initWithDict:_dict];

        
        
//        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];
    


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
