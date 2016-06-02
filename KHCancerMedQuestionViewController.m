//
//  KHCancerMedQuestionViewController.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 5/27/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHCancerMedQuestionViewController.h"
#import "KHCancerEFLQuestionViewController.h"
#import "KHPatient.h"
#import "KHRiskFactorModel.h"
#import "KHCancerListModel.h"
#import "KHCancerRiskFactor.h"

@interface KHCancerMedQuestionViewController ()
@property KHPatient *patient;
@property KHRiskFactorModel *riskFactors;


@property NSMutableArray *checkBoxArray;
@property NSMutableArray *MedRiskFactorArray;
- (IBAction)backButtonAction:(id)sender;
@end

@implementation KHCancerMedQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _patient = [KHPatient sharedModel];
    _riskFactors = [KHRiskFactorModel sharedModel];
    
    [self UISetup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)UISetup {
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    NSLog(@"cancerRF list: %@", _riskFactors.AllRFListForCancer);
    _MedRiskFactorArray = [[NSMutableArray alloc] init];
    //get med rf only
    for (KHCancerRiskFactor *rf in _riskFactors.AllRFListForCancer) {
        if ([rf.type isEqualToString:@"MedCond"] ) {
            [_MedRiskFactorArray addObject:rf];
        }
    }
    
    _checkBoxArray = [[NSMutableArray alloc] init];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _MedRiskFactorArray.count*60)];
    
    for (int i = 0; i < [_MedRiskFactorArray count] ; i++) {
        
        CGFloat width = self.view.frame.size.width;
        
        UIView *newSubView = [[UIView alloc] initWithFrame:CGRectMake(0, i*60, width, 60)];
        UILabel *riskFactorTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, width - 80, 50)];
        riskFactorTitleLable.numberOfLines = 2;
        riskFactorTitleLable.lineBreakMode = NSLineBreakByWordWrapping;
        riskFactorTitleLable.textColor = [UIColor whiteColor];
        KHCancerRiskFactor *cancerRiskFactor=_MedRiskFactorArray[i];
//        NSLog(@"got !");
        NSLog(@"name of riskfa: %@", cancerRiskFactor.name);
        riskFactorTitleLable.text = cancerRiskFactor.name;
        
        //        riskFactorTitleLable.text = @"NEW RISK FACTOR";
        UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(width - 60, 15, 30,30 )];
        
        
        [newSubView addSubview:mySwitch];
        [newSubView addSubview:riskFactorTitleLable];
        [_checkBoxArray addObject:mySwitch];
        [contentView addSubview:newSubView];
        
        
    }
    [_scrollView addSubview:contentView];
    _scrollView.contentSize = contentView.frame.size;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextButton:(id)sender {
}


-(void)calculateResults {
    
    
    //    NSInteger numVaccineRiskFactors = [self.vaccineRiskFactorList count];
    //    NSLog(@"Num risk factors = %ld\n", (long)numVaccineRiskFactors);
    NSLog(@"patien current info");
    NSLog(@"num risk factors: %ld", (long)self.patient->numRiskFactors);
    NSLog(@"age %ld", (long)self.patient.age);
    NSLog(@"first, last name: %@ %@", _patient.firstName, _patient.lastName);
    
    
    KHCancerRiskFactor *firstRF = [self.riskFactors.AllRFListForVaccine objectAtIndex:0];
    
    self.patient.vaccineList = firstRF.cancerList;
    for (KHVaccine *vac in self.patient.vaccineList) {
        vac->status = Nothing;
        //        NSLog(@"vac stat: %u", vac->status);
    }
    
    // For each risk factor
    for(int i = 0; i < _riskFactors.AllRFListForVaccine.count; i++) {
        
        // get current vaccine risk factor
        KHCancerRiskFactor *cancerRiskFactor = [self.riskFactors.AllRFListForVaccine objectAtIndex:i];
        
        //        NSLog(@"Risk factor name = %@\n", accineRiskFactor.name);
        
        // if vaccine risk factor is active, check it against  patient's current vaccine list
        // if not active, patient's current vaccien list remains the same
        if(cancerRiskFactor.isActive) {
            NSLog(@"inside isAvtive!");
            
            
            // increment numRiskFactors
            self.patient->numRiskFactors++;
            
            NSLog(@"A");
            NSArray *checkVaccineList = cancerRiskFactor.cancerList;
            NSArray *patientVaccineList = self.patient.vaccineList;
            NSLog(@"B");
            
            // for each vaccine under this risk factor
            for(int j = 0; j < checkVaccineList.count; j++) {
                NSLog(@"C ");
                
                NSLog(@" patient count : %lu", (unsigned long)patientVaccineList.count);
                NSLog(@" check count : %lu", (unsigned long)checkVaccineList.count);
                //get this risk factor vaccine
                
                // and its counterpart in patient
                KHVaccine *checkVaccine = [checkVaccineList objectAtIndex:j];
                KHVaccine *patientVaccine = [patientVaccineList objectAtIndex:j];
                
                
                NSLog(@"E");
                // compare vaccine values
                Status newStatus = [self getStatusWithCheckVaccine:checkVaccine
                                                 andPatientVaccine:patientVaccine];
                
                // update patient vaccine value
                patientVaccine->status = newStatus;
                NSLog(@"F");
                NSMutableArray *array = [self.patient.vaccineList copy];
                patientVaccine = array[j];
                
                [self.patient.vaccineList replaceObjectAtIndex:j withObject:patientVaccine];
                NSLog(@"G");
                //                NSLog(@"Active Riskfactor: Vaccine new status = %u\n", patientVaccine->status);
                NSLog(@"D");
            }
        }
        
    }
    NSLog(@"done calculating results!");
    
    
    for (KHVaccine *vc in self.patient.vaccineList) {
        NSLog(@"Final patient vaccine status: %u", vc->status);
    }
    
}

-(Status)getStatusWithCheckVaccine:(KHVaccine *)checkVaccine andPatientVaccine:(KHVaccine *)patientVaccine {
    
    Status newStatus = Nothing;
    
    Status checkStatus = checkVaccine->status;
    Status patientStatus = patientVaccine->status;
    
    NSLog(@"gettin new stat!");
    NSLog(@" check old vac stat: %u", checkStatus);
    NSLog(@" patient old vac stat: %u", patientStatus);
    // Scenatio 1: recommended + recommended + numRF>1 = indicated
    if(checkStatus == Recommended || patientStatus == Recommended) {
        // check if recommended should become indicated
        if(self.patient->numRiskFactors > 1)
            newStatus = Indicated;
    }
    // Scenatio 2: recommended + indicated = indicated
    if(checkStatus == Indicated || patientStatus == Indicated) {
        newStatus = Indicated;
    }
    // Scenatio 3: contra + recommended
    if(checkStatus == Ask || patientStatus == Ask) {
        newStatus = Ask;
    }
    if(checkStatus == Contraindicated || patientStatus == Contraindicated) {
        newStatus = Contraindicated;
    }
    NSLog(@"got new stat!: %u", newStatus);
    return newStatus;
}

- (IBAction)nextPageButton:(id)sender {
    for(int i=0; i<_checkBoxArray.count ; i++)
    {
        if ([_checkBoxArray[i] isOn]) {
            //update riskfactor status
            KHCancerRiskFactor *riskFactor = _MedRiskFactorArray[i];
            riskFactor.isActive = YES;
            NSUInteger index = [_riskFactors.AllRFListForVaccine indexOfObject:riskFactor];
            [_riskFactors.AllRFListForVaccine replaceObjectAtIndex:index withObject:riskFactor];
        }
    }
    
    
    
    // begin calculating results
    NSLog(@"about to calculate results!");
    [self calculateResults];
    
    NSLog(@"about to go get resultss!");
    //!!!: add segueid
    [self performSegueWithIdentifier:@"" sender:self];
}
- (IBAction)backButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end


