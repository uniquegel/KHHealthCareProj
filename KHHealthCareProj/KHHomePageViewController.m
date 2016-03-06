//
//  KHHomePageViewController.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHHomePageViewController.h"
#import "VaccineListModel.h"
#import "CancerListModel.h"
#import "RiskFactorModel.h"
#import "Patient.h"

@implementation KHHomePageViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initializing];
    
    [self initializeDummyData];
    
}

-(void)initializing {
    
    // initialize vaccine array by pulling from server
    VaccineListModel *vaccineModel = [VaccineListModel sharedModel];
    
    
    // initialize cancer array by pulling from server
    CancerListModel *cancerModel = [CancerListModel sharedModel];
    
    // initialize riskFactorList by pulling from server
    RiskFactorModel *riskFactorModel = [RiskFactorModel sharedModel];
    
}

-(void)initializeDummyData {
    
    // initialize patient
    Patient *patient = [Patient sharedModel];
    

    
}

- (IBAction)fullExamButton:(id)sender {
}
@end
