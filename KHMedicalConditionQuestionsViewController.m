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
#import "KHTabBarViewController.h"

@interface KHMedicalConditionQuestionsViewController()
@property (nonatomic, strong) KHPatient *patient;
@property (nonatomic, strong) NSArray *vaccineRiskFactorList;
@property (nonatomic, strong) NSArray *cancerRiskFactorList;
@property KHRiskFactorModel *riskFactors;
@property NSMutableArray *checkBoxArray;

@property NSMutableArray *medRiskFactorArray;
- (IBAction)backButtonAction:(id)sender;

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
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    NSLog(@"vacctineRiskFactor list: %@", _riskFactors.AllRFListForVaccine);
    _medRiskFactorArray = [[NSMutableArray alloc] init];
    //get Occu risk factors only
    for (KHVaccineRiskFactor *rf in _riskFactors.AllRFListForVaccine) {
        if ([rf.type isEqualToString:@"Medical Condition"] ) {
            [_medRiskFactorArray addObject:rf];
        }
    }
    
    _checkBoxArray = [[NSMutableArray alloc] init];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _medRiskFactorArray.count*60)];
    
    for (int i = 0; i < [_medRiskFactorArray count] ; i++) {
        
        CGFloat width = self.view.frame.size.width;
        
        
        
        UIView *newSubView = [[UIView alloc] initWithFrame:CGRectMake(0, i*60, width, 60)];
        UILabel *riskFactorTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, width - 80, 50)];
        riskFactorTitleLable.numberOfLines = 2;
        
//        newSubView.backgroundColor = [UIColor redColor];
//        newSubView.layer.borderColor = [UIColor redColor].CGColor;
//        newSubView.layer.borderWidth = 3.0f;
//        riskFactorTitleLable.backgroundColor = [UIColor blueColor];
        
        riskFactorTitleLable.numberOfLines = 2;
        riskFactorTitleLable.lineBreakMode = NSLineBreakByWordWrapping;
        riskFactorTitleLable.textColor = [UIColor whiteColor];
        KHVaccineRiskFactor *vaccineRiskFactor=_medRiskFactorArray[i];
        NSLog(@"got vaccine!");
        NSLog(@"name of riskfa: %@", vaccineRiskFactor.name);
        riskFactorTitleLable.text = vaccineRiskFactor.name;
        
        //        riskFactorTitleLable.text = @"NEW RISK FACTOR";
        UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(width - 60, 15, 30,30 )];
        
        
        [newSubView addSubview:mySwitch];
        [newSubView addSubview:riskFactorTitleLable];
        [_checkBoxArray addObject:mySwitch];
        [contentView addSubview:newSubView];
        
        
    }
    _scrollView.layer.masksToBounds=YES;
    _scrollView.layer.borderColor=[[UIColor whiteColor]CGColor];
    _scrollView.layer.borderWidth= 1.0f;
    [_scrollView addSubview:contentView];
    _scrollView.contentSize = contentView.frame.size;
    
}


-(void)initializing {
    
    self.patient = [KHPatient sharedModel];
    
//    KHRiskFactorModel *riskFactorModel = [KHRiskFactorModel sharedModel];
    
//    self.vaccineRiskFactorList = riskFactorModel.vaccineMedRiskFactorList;
    //self.cancerRiskFactorList = riskFactorModel.cancerRiskFactorList;
    
}



-(void)calculateResults {
    
    
//    NSInteger numVaccineRiskFactors = [self.vaccineRiskFactorList count];
//    NSLog(@"Num risk factors = %ld\n", (long)numVaccineRiskFactors);
    NSLog(@"patien current info");
    NSLog(@"num risk factors: %ld", (long)self.patient->numRiskFactors);
    NSLog(@"age %ld", (long)self.patient.age);
    NSLog(@"first, last name: %@ %@", _patient.firstName, _patient.lastName);
    
    
    KHVaccineRiskFactor *firstRF = [self.riskFactors.AllRFListForVaccine objectAtIndex:0];
    
    self.patient.vaccineList = firstRF.vaccineList;
    for (KHVaccine *vac in self.patient.vaccineList) {
        vac->status = Nothing;
//        NSLog(@"vac stat: %u", vac->status);
    }
    
    // For each risk factor
    for(int i = 0; i < _riskFactors.AllRFListForVaccine.count; i++) {
        
        // get current vaccine risk factor
        KHVaccineRiskFactor *vaccineRiskFactor = [self.riskFactors.AllRFListForVaccine objectAtIndex:i];
        
//        NSLog(@"Risk factor name = %@\n", accineRiskFactor.name);
        
        // if vaccine risk factor is active, check it against  patient's current vaccine list
        // if not active, patient's current vaccien list remains the same
        if(vaccineRiskFactor.isActive) {
            NSLog(@"inside isAvtive!");
            
            
            // increment numRiskFactors
            self.patient->numRiskFactors++;
            
            NSLog(@"A");
            NSArray *checkVaccineList = vaccineRiskFactor.vaccineList;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //     Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"cancerMedQuestionToResults"])
    {
        // Get reference to the destination view controller
        KHTabBarViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.showTabNumber = 0;
        
    }
    
    
}




- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)nextPageButton:(id)sender {
    for(int i=0; i<_checkBoxArray.count ; i++)
    {
        if ([_checkBoxArray[i] isOn]) {
            //update riskfactor status
            KHVaccineRiskFactor *riskFactor = _medRiskFactorArray[i];
            riskFactor.isActive = YES;
            NSUInteger index = [_riskFactors.AllRFListForVaccine indexOfObject:riskFactor];
            [_riskFactors.AllRFListForVaccine replaceObjectAtIndex:index withObject:riskFactor];
        }
    }
    
    
    
    // begin calculating results
    NSLog(@"about to calculate results!");
    [self calculateResults];

    _patient.completedVaccineFlow = YES;
    [self performSegueWithIdentifier:@"vaccineMedQuestionToResults" sender:self];
}
@end
