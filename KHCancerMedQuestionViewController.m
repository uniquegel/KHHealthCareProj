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
#import "KHCancer.h"
#import "KHTabBarViewController.h"
#import "KHRiskFactorManager.h"

@interface KHCancerMedQuestionViewController ()
@property KHPatient *patient;
@property KHRiskFactorModel *riskFactors;


@property NSMutableArray *checkBoxArray;
@property NSMutableArray *MedRiskFactorArray;
- (IBAction)backButtonAction:(id)sender;

-(void)calculateResults;
-(Status)getStatusWithCheckCancer:(KHCancer *)checkCancer andPatientCancer:(KHCancer *)patientCancer;
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
        UILabel *riskFactorTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, width - 80, 50)];
        riskFactorTitleLable.numberOfLines = 2;
        riskFactorTitleLable.lineBreakMode = NSLineBreakByWordWrapping;
        riskFactorTitleLable.textColor = [UIColor blackColor];
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
    _scrollView.layer.masksToBounds=YES;
    _scrollView.layer.borderColor=[[UIColor whiteColor]CGColor];
    _scrollView.layer.borderWidth= 1.0f;
    [_scrollView addSubview:contentView];
    _scrollView.contentSize = contentView.frame.size;
    
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
        vc.showTabNumber = 1;
        
    }
    
    
}



-(void)calculateResults {
    
    
    //    NSInteger numVaccineRiskFactors = [self.vaccineRiskFactorList count];
    //    NSLog(@"Num risk factors = %ld\n", (long)numVaccineRiskFactors);
    NSLog(@"patien current info");
    NSLog(@"num risk factors: %ld", (long)self.patient.numRiskFactors);
    NSLog(@"age %ld", (long)self.patient.age);
    NSLog(@"first, last name: %@ %@", _patient.firstName, _patient.lastName);
    
    
    // FIXME: feed the list of cancers to Patient, and initialize them with NOTHING as stat
    // Ideally change this to Homepage when pull info from user
    KHCancerRiskFactor *firstRF = [self.riskFactors.AllRFListForCancer objectAtIndex:0];
    /* for (KHCancerRiskFactor *crf in self.riskFactors.AllRFListForCancer) {
        NSLog(@"risk factor name: %@", crf.name);
        for (KHCancer *can in crf.cancerList) {
            
            NSLog(@"inside loop: %@", can.name);
            //        NSLog(@"vac stat: %u", vac->status);
        }
        NSLog(@"----------------");
    } */
    NSLog(@"firstRF info: %@", firstRF.name);
    self.patient.cancerList = firstRF.cancerList;
    for (KHCancer *can in self.patient.cancerList) {
        can->status = White;
        NSLog(@"can under patient: %@", can.name);
        //        NSLog(@"vac stat: %u", vac->status);
    }
    
    
    // For each risk factor
    NSLog(@"ALLRFLIST FOR CANCER: %lu", (unsigned long)_riskFactors.AllRFListForCancer.count);
    for(int i = 0; i < _riskFactors.AllRFListForCancer.count; i++) {
        NSLog(@"inside ALL RF for cancer!:");
        // get current vaccine risk factor
        KHCancerRiskFactor *cancerRiskFactor = [self.riskFactors.AllRFListForCancer objectAtIndex:i];
        
        //        NSLog(@"Risk factor name = %@\n", accineRiskFactor.name);
        
        // if vaccine risk factor is active, check it against  patient's current vaccine list
        // if not active, patient's current vaccien list remains the same
        if(cancerRiskFactor.isActive) {
            NSLog(@"inside isAvtive!");
            
            // increment numRiskFactors
            self.patient.numRiskFactors++;
            
            NSLog(@"A");
            NSArray *checkCancerList = cancerRiskFactor.cancerList;
            NSArray *patientCancerList = self.patient.cancerList;
            NSLog(@"B");
            
            // for each vaccine under this risk factor
            for(int j = 0; j < checkCancerList.count; j++) {
                NSLog(@"C ");
                
                NSLog(@" patient count : %lu", (unsigned long)patientCancerList.count);
                NSLog(@" check count : %lu", (unsigned long)checkCancerList.count);
                //get this risk factor vaccine
                
                // and its counterpart in patient
                KHCancer *checkCancer = [checkCancerList objectAtIndex:j];
                KHCancer *patientCancer = [patientCancerList objectAtIndex:j];
                
                NSLog(@"E");
                // compare cancer values
                Status newStatus = [self getStatusWithCheckCancer:checkCancer andPatientCancer:patientCancer];
                
                // update patient vaccine value
                patientCancer->status = newStatus;
                NSLog(@"F");
                NSMutableArray *array = [self.patient.cancerList copy];
                patientCancer = array[j];
                
                [self.patient.cancerList replaceObjectAtIndex:j withObject:patientCancer];
                
                NSLog(@"G");
                //                NSLog(@"Active Riskfactor: Vaccine new status = %u\n", patientVaccine->status);
                NSLog(@"D");
            }
        }
        
    }
    NSLog(@"done calculating results!");
    
    
    for (KHCancer *can in self.patient.cancerList) {
        NSLog(@"Final patient cancer status: %u", can->status);
    }
    
}

-(Status)getStatusWithCheckCancer:(KHCancer *)checkCancer andPatientCancer:(KHCancer *)patientCancer {
    
    Status newStatus = White;
    
    Status checkStatus = checkCancer->status;
    Status patientStatus = patientCancer->status;
    
    NSLog(@"gettin new stat!");
    NSLog(@" check old vac stat: %u", checkStatus);
    NSLog(@" patient old vac stat: %u", patientStatus);
    
    // FIXIT: Logic has problem
    // Scenario 1: numOfRF > 1 and either of the general screening status is Recommended
    if((checkStatus == Green || patientStatus == Green) && self.patient.numRiskFactors > 1) {
        newStatus = Yellow;
    }
    // Scenario 2: either of the general screening status is Indicated
    if(checkStatus == Yellow || patientStatus == Yellow) {
        newStatus = Yellow;
    }
    // Scenario 3: either is ask, overwrites Indicated
    if(checkStatus == Blue || patientStatus == Blue) {
        newStatus = Blue;
    }
    // Scenario 4: either is contra, overwrites everything else
    if(checkStatus == Red || patientStatus == Red)
    {
        newStatus = Red;
    }
    NSLog(@"got new stat!: %u", newStatus);
    return newStatus;
}

- (IBAction)nextPageButton:(id)sender {
    for(int i=0; i<_checkBoxArray.count ; i++)
    {
        if ([_checkBoxArray[i] isOn]) {
            //update risnexkfactor status
            KHCancerRiskFactor *riskFactor = _MedRiskFactorArray[i];
            riskFactor.isActive = YES;
            NSUInteger index = [_riskFactors.AllRFListForCancer indexOfObject:riskFactor];
            [_riskFactors.AllRFListForCancer replaceObjectAtIndex:index withObject:riskFactor];
        }
    }
    
    
    
    // begin calculating results
    NSLog(@"about to calculate results!");
    [self calculateResults];
    
    _patient.completedCancerFlow = YES;
    [self performSegueWithIdentifier:@"cancerMedQuestionToResults" sender:self];
}
- (IBAction)backButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end


