//
//  KHHomePageViewController.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHHomePageViewController.h"
#import "KHVaccineListModel.h"
#import "KHCancerListModel.h"
#import "KHRiskFactorModel.h"
#import "KHBasicQuestionViewController.h"
#import "KHHealthCareProj-Swift.h"
#import "KHRiskFactorManager.h"

@import FirebaseAuth;
@interface KHHomePageViewController ()
@property KHPatient *patient;
@property ScreeningType scrType;

- (IBAction)vacScreenButtonAction:(id)sender;
- (IBAction)genScreenBtnTapped:(id)sender;
- (IBAction)cancerScreenButtonAction:(id)sender;


@end

@implementation KHHomePageViewController


-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.patient = [KHPatient sharedModel];
    
    //pull from database, asynchrously
    
    
	
    
}

-(void) viewDidAppear:(BOOL)animated {
//	[[KHRiskFactorManager sharedManager] downloadAllRiskFactors:^(BOOL completed) {
//		if (completed) {
//			KHRiskFactorManager *manager = [KHRiskFactorManager sharedManager];
//			
//		}
//	}];
    
    
	[[KHRiskFactorManager sharedManager] downloadAllRiskFactors];
}


-(void)initializing {
    
    // initialize vaccine array by pulling from server
    KHVaccineListModel *vaccineModel = [KHVaccineListModel sharedModel];
    
    
    // initialize cancer array by pulling from server
    KHCancerListModel *cancerModel = [KHCancerListModel sharedModel];
    
    // initialize riskFactorList by pulling from server
//    KHRiskFactorModel *riskFactorModel = [KHRiskFactorModel sharedModel];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"basicQuestionSegue"])
    {
        // Get reference to the destination view controller
         KHBasicQuestionViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.screeningType = _scrType;
        
    }
}


- (IBAction)vacScreenButtonAction:(id)sender {
    _scrType = kScreenTypeVaccine;
    
    self.patient.curScreeningType = kScreenTypeVaccine;
    
    NSLog(@"Screen type: %lu", (unsigned long)_scrType);
    [self performSegueWithIdentifier:@"basicQuestionSegue" sender:self];
}

- (IBAction)cancerScreenButtonAction:(id)sender {
    _scrType = kScreenTypeCancer;
    
    self.patient.curScreeningType = kScreenTypeCancer;
    
    NSLog(@"Screen type: %lu", (unsigned long)_scrType);
    [self performSegueWithIdentifier:@"basicQuestionSegue" sender:self];
}

- (IBAction)genScreenBtnTapped:(id)sender {
    _scrType = kScreenTypeGeneral;
    
    self.patient.curScreeningType = kScreenTypeGeneral;
    NSLog(@"Screen type: %lu", (unsigned long)_scrType);
        [self performSegueWithIdentifier:@"basicQuestionSegue" sender:self];
}


- (IBAction)logoutButtonPressed:(id)sender {
    return ;
    
	NSError *error;
	[[FIRAuth auth] signOut:&error];
	if (!error) {
		NSLog(@"Log out success!");
		[self dismissViewControllerAnimated:YES completion:nil];
	}
	
}

@end
