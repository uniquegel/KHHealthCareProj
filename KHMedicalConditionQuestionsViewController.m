//
//  KHMedicalConditionQuestionsViewController.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHMedicalConditionQuestionsViewController.h"
#import "KHResultsPageViewController.h"
#import "KHPatient.h"
#import "KHRiskFactorModel.h"
#import "KHVaccineRiskFactor.h"
#import "KHVaccine.h"

@interface KHMedicalConditionQuestionsViewController()
@property (nonatomic, strong) KHPatient *patient;
@property (nonatomic, strong) NSArray *vaccineRiskFactorList;
@property (nonatomic, strong) NSArray *cancerRiskFactorList;
@property KHRiskFactorModel *riskFactors;
@property NSMutableArray *checkBoxArray;

-(void)calculateResults;
-(Status)getStatusWithCheckVaccine:(KHVaccine *)checkVaccine andPatientVaccine:(KHVaccine *)patientVaccine;

@end


@implementation KHMedicalConditionQuestionsViewController



-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    _patient = [KHPatient sharedModel];
    _riskFactors = [KHRiskFactorModel sharedModel];
    
    [self UISetup];

    
}

- (void)UISetup {
    
    _checkBoxArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_riskFactors.vaccineRiskFactorList count] ; i++) {
        
        CGFloat width = self.view.frame.size.width;
        
        UIView *newSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 200 + i*50, width, 50)];
        UILabel *riskFactorTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, width - 80, 20)];
        KHVaccineRiskFactor *vaccineRiskFactor=_riskFactors.vaccineRiskFactorList[i];
        riskFactorTitleLable.text = vaccineRiskFactor.name;
        UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(width - 80, 15, 30,30 )];
        
        [newSubView addSubview:mySwitch];
        [newSubView addSubview:riskFactorTitleLable];
        [_checkBoxArray addObject:mySwitch];
        
        [self.scrollView addSubview:newSubView];
        
    }
}

-(void)initializing {
    
    self.patient = [KHPatient sharedModel];
    
    KHRiskFactorModel *riskFactorModel = [KHRiskFactorModel sharedModel];
    
    self.vaccineRiskFactorList = riskFactorModel.vaccineRiskFactorList;
    //self.cancerRiskFactorList = riskFactorModel.cancerRiskFactorList;
    
}

-(void)calculateResults {
    
    
    NSInteger numVaccineRiskFactors = [self.vaccineRiskFactorList count];
    NSLog(@"Num risk factors = %ld\n", (long)numVaccineRiskFactors);
    
    // vaccine risk factor list
    for(int i = 0; i < numVaccineRiskFactors; i++) {
        
        // current vaccine risk factor
        KHVaccineRiskFactor *vaccineRiskFactor = [self.vaccineRiskFactorList objectAtIndex:i];
        
        NSLog(@"Risk factor name = %@\n", vaccineRiskFactor.name);
        
        // if vaccine risk factor is active, compare with patient's vaccine list
        if(vaccineRiskFactor.isActive) {
            
            // increment numRiskFactors
            self.patient->numRiskFactors++;
            
            NSArray *checkVaccineList = vaccineRiskFactor.vaccineList;
            NSArray *patientVaccineList = self.patient.vaccineList;
            
            NSInteger numVaccines = [checkVaccineList count];
            
            // iterate over vaccine lists
            for(int j = 0; j < numVaccines; j++) {
                
                KHVaccine *checkVaccine = [checkVaccineList objectAtIndex:j];
                KHVaccine *patientVaccine = [patientVaccineList objectAtIndex:j];
                
                
                // compare vaccine values
                Status newStatus = [self getStatusWithCheckVaccine:checkVaccine
                                                 andPatientVaccine:patientVaccine];
                
                // update patient vaccine value
                patientVaccine->status = newStatus;
                
                NSLog(@"Vaccine status = %u\n", patientVaccine->status);
            }
            
            
            
        }
        
    }
    
}

-(Status)getStatusWithCheckVaccine:(KHVaccine *)checkVaccine andPatientVaccine:(KHVaccine *)patientVaccine {
    
    Status newStatus = Nothing;
    
    Status checkStatus = checkVaccine->status;
    Status patientStatus = patientVaccine->status;
    
    // return max priority status
    if(checkStatus == Recommended || patientStatus == Recommended) {
        // check if recommended should become indicated
        if(self.patient->numRiskFactors > 1)
            newStatus = Indicated;
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



- (IBAction)nextPageButton:(id)sender {
    
    
    [self initializing];
    
    // begin calculating results
    [self calculateResults];
    
    
    [self performSegueWithIdentifier:@"medQuestionToResults" sender:self];
    
}




















@end
