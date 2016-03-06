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
    
    [self initializing];
    
    [self initializeDummyData];
    
}

-(void)initializing {
    
    // initialize vaccine array by pulling from server
    KHVaccineListModel *vaccineModel = [KHVaccineListModel sharedModel];
    
    
    // initialize cancer array by pulling from server
    KHCancerListModel *cancerModel = [KHCancerListModel sharedModel];
    
    // initialize riskFactorList by pulling from server
    KHRiskFactorModel *riskFactorModel = [KHRiskFactorModel sharedModel];
    
}

-(void)initializeDummyData {
    
    // initialize patient
    KHPatient *patient = [KHPatient sharedModel];
    

    
}


// Quick Checkup
- (IBAction)quickExamButton:(id)sender {
    
}


// Complete Exam
- (IBAction)fullExamButton:(id)sender {
    
}










@end
