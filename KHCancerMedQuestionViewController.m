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

@interface KHCancerMedQuestionViewController ()
@property KHPatient *patient;
@property KHRiskFactorModel *riskFactors;


@property NSMutableArray *checkBoxArray;
@property NSMutableArray *MedRiskFactorArray;
- (IBAction)backButtonAction:(id)sender;

-(void)calculateResults;
- (void) adjustAgeRiskFactorsActiveness;
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

- (void) viewWillAppear:(BOOL)animated{
    NSLog(@"view will appear!");
    [self adjustCheckboxToggle];
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
    _scrollView.layer.masksToBounds=YES;
    _scrollView.layer.borderColor=[[UIColor whiteColor]CGColor];
    _scrollView.layer.borderWidth= 1.0f;
    [_scrollView addSubview:contentView];
    _scrollView.contentSize = contentView.frame.size;
    
}

- (void) adjustCheckboxToggle{
    for(int i=0; i<_checkBoxArray.count ; i++)
    {
        KHCancerRiskFactor *riskFactor = _MedRiskFactorArray[i];
        
        if (riskFactor.isActive) {
            [_checkBoxArray[i] setOn:YES];
        }
        
    }
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
 
    self.patient->numOfActiveRiskFactors = 0;
    
    // FIXME: feed the list of cancers to Patient, and initialize them with NOTHING as stat
    // Ideally change this to Homepage when pull info from user
    KHCancerRiskFactor *firstRF = [self.riskFactors.AllRFListForCancer objectAtIndex:0];
    
    NSLog(@"firstRF info: %@", firstRF.name);
    self.patient.cancerList = firstRF.cancerList;
    for (KHCancer *can in self.patient.cancerList) {
        can->status = Nothing;
        NSLog(@"can under patient: %@", can.name);
        //        NSLog(@"vac stat: %u", vac->status);
    }
    
    for (KHCancerRiskFactor *crf in _riskFactors.AllRFListForCancer) {
        if (crf.isActive) {
            // increment numRiskFactors
            self.patient->numOfActiveRiskFactors++;
            NSArray *checkCancerList= crf.cancerList;
            NSArray *patientCancerList = self.patient.cancerList;
            
            // for each cancer under this risk factor
            for(int j = 0; j < checkCancerList.count; j++) {
                //get this risk factor cancer
                // and its counterpart in patient
                KHCancer *checkCancer = [checkCancerList objectAtIndex:j];
                KHCancer *patientCancer = [patientCancerList objectAtIndex:j];
                
                // compare cancer values
                Status newStatus = [self getStatusWithCheckCancer:checkCancer
                                                 andPatientCancer:patientCancer];
                
                // update patient cancer list
                patientCancer->status = newStatus;
                NSMutableArray *array = [self.patient.cancerList copy];
                patientCancer = array[j];
                [self.patient.cancerList replaceObjectAtIndex:j withObject:patientCancer];
            }
        }
    }
    
}

- (void) adjustAgeRiskFactorsActiveness {
    //set age risktor to active
    for (KHCancerRiskFactor *crf in _riskFactors.AllRFListForCancer) {
        if ([crf.type isEqualToString:@"Age"]) {
            //parse key name
            NSString *nameString = crf.name;
            if ([nameString containsString:@"-"]) {
                NSString *lowerboundString;
                NSString *upperboundString;
                lowerboundString = [[nameString componentsSeparatedByString:@"-"] objectAtIndex:0];
                upperboundString = [[nameString componentsSeparatedByString:@"-"] objectAtIndex:1];
                if (self.patient.age>lowerboundString.integerValue && self.patient.age<upperboundString.integerValue) {
                    crf.isActive = YES;
                }
            }
            else{
                NSString *ageString = [nameString substringFromIndex:2];
                if (self.patient.age>ageString.integerValue) {
                    crf.isActive = YES;
                }
            }
        }
    }

}
-(Status)getStatusWithCheckCancer:(KHCancer *)checkCancer andPatientCancer:(KHCancer *)patientCancer {
    
    Status newStatus = Nothing;
    
    Status checkStatus = checkCancer->status;
    Status patientStatus = patientCancer->status;
    
    NSLog(@"gettin new stat!");
    NSLog(@" check old vac stat: %u", checkStatus);
    NSLog(@" patient old vac stat: %u", patientStatus);
    // Scenatio 1: recommended + recommended + numRF>1 = indicated
    if(checkStatus == Recommended || patientStatus == Recommended) {
        // check if recommended should become indicated
        if(self.patient->numOfActiveRiskFactors > 1)
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
    if(checkStatus == Contraindicated || patientStatus == Contraindicated)
    {
        newStatus = Contraindicated;
    }
    NSLog(@"got new stat!: %u", newStatus);
    return newStatus;
}

- (IBAction)nextPageButton:(id)sender {
    for(int i=0; i<_checkBoxArray.count ; i++)
    {
        KHCancerRiskFactor *riskFactor = _MedRiskFactorArray[i];
        if ([_checkBoxArray[i] isOn]) {
            //update risnexkfactor status
            
            riskFactor.isActive = YES;
            NSUInteger index = [_riskFactors.AllRFListForCancer indexOfObject:riskFactor];
            [_riskFactors.AllRFListForCancer replaceObjectAtIndex:index withObject:riskFactor];
        }
        else{
            riskFactor.isActive = NO;
            NSUInteger index = [_riskFactors.AllRFListForCancer indexOfObject:riskFactor];
            [_riskFactors.AllRFListForCancer replaceObjectAtIndex:index withObject:riskFactor];
        }
    }
    
    
    [self adjustAgeRiskFactorsActiveness];
    [self calculateResults];
    
    _patient.completedCancerFlow = YES;
    [self performSegueWithIdentifier:@"cancerMedQuestionToResults" sender:self];
}
- (IBAction)backButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end


