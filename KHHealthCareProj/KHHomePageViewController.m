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
#import "KHPatient.h"

@implementation KHHomePageViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    //pull from database, asynchrously
    KHVaccineListModel *vaccineModel = [KHVaccineListModel sharedModel];
    KHRiskFactorModel *rfModel = [KHRiskFactorModel sharedModel];

    NSLog(@"got vaccine rf in homepage view: %@", rfModel.vaccineMedRiskFactorList);
    
    
    
//    [self initializing];
    
//    [self initializeDummyData];
    
}

-(void)initializing {
    
    // initialize vaccine array by pulling from server
    KHVaccineListModel *vaccineModel = [KHVaccineListModel sharedModel];
    
    
    // initialize cancer array by pulling from server
    KHCancerListModel *cancerModel = [KHCancerListModel sharedModel];
    
    // initialize riskFactorList by pulling from server
//    KHRiskFactorModel *riskFactorModel = [KHRiskFactorModel sharedModel];
    
}

-(void)initializeDummyData {
    
    // initialize patient
    KHPatient *patient = [KHPatient sharedModel];
    

    
}


// Quick Checkup
- (IBAction)quickExamButton:(id)sender {
    
    [self performSegueWithIdentifier:@"basicQuestionSegue" sender:self];
    
}


// Complete Exam
- (IBAction)fullExamButton:(id)sender {
    
    // have checker to see if complete exam is being taken throughout flow
        // if true, add additional questions at the end
    
    [self performSegueWithIdentifier:@"basicQuestionSegue" sender:self];
    
}










@end
