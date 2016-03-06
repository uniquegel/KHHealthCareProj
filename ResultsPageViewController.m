//
//  ResultsPageViewController.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "ResultsPageViewController.h"
#import "Patient.h"
#import "RiskFactorModel.h"
#import "VaccineRiskFactor.h"
#import "Vaccine.h"

@interface ResultsPageViewController()

@property (nonatomic, strong) Patient *patient;
@property (nonatomic, strong) NSArray *vaccineRiskFactorList;
@property (nonatomic, strong) NSArray *cancerRiskFactorList;

@end

@implementation ResultsPageViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initializing];
    
    [self calculateResults];
    
}

-(void)initializing {
    
    self.patient = [Patient sharedModel];

    RiskFactorModel *riskFactorModel = [RiskFactorModel sharedModel];
    
    self.vaccineRiskFactorList = riskFactorModel.vaccineRiskFactorList;
    self.cancerRiskFactorList = riskFactorModel.cancerRiskFactorList;
    
}

// matrix algorithm
-(void)calculateResults {
    
    NSInteger numVaccineRiskFactors = [self.vaccineRiskFactorList count];
    
    // vaccine risk factor list
    for(int i = 0; i < numVaccineRiskFactors; i++) {
        
        // current vaccine risk factor
        VaccineRiskFactor *vaccineRiskFactor = [self.vaccineRiskFactorList objectAtIndex:i];
        
        // if vaccine risk factor is active, compare with patient's vaccine list
        if(vaccineRiskFactor.isActive) {
            
            NSArray *checkVaccineList = vaccineRiskFactor.vaccineList;
            NSArray *patientVaccineList = self.patient.vaccineList;
            
            NSInteger numVaccines = [checkVaccineList count];
            
            // iterate over vaccine lists
            for(int j = 0; j < numVaccines; j++) {
                
                Vaccine *checkVaccine = [checkVaccineList objectAtIndex:j];
                Vaccine *patientVaccine = [patientVaccineList objectAtIndex:j];
                
                // compare vaccine values
                Status newStatus = [self getStatusWithCheckVaccine:checkVaccine
                                                 andPatientVaccine:patientVaccine];
                
                // update patient vaccine value
                patientVaccine->status = newStatus;
            }
            

            
        }
        
    }

}

-(Status)getStatusWithCheckVaccine:(Vaccine *)checkVaccine andPatientVaccine:(Vaccine *)patientVaccine {
    
    Status newStatus;
    
    Status checkStatus = checkVaccine->status;
    Status patientStatus = patientVaccine->status;
    
    // return max priority status
    if(checkStatus == Recommended || patientStatus == Recommended) {
        newStatus = Recommended;
    }
    if(checkStatus == Indicated || patientStatus == Indicated) {
        checkStatus = Indicated;
    }
    if(checkStatus == Ask || patientStatus == Ask) {
        checkStatus = Ask;
    }
    if(checkStatus == Contraindicated || patientStatus == Contraindicated) {
        checkStatus = Contraindicated;
    }

    return newStatus;
}














@end
