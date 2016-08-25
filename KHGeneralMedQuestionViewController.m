//
//  KHGeneralMedQuestionViewController.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 6/22/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHGeneralMedQuestionViewController.h"
#import "KHPatient.h"
#import "KHHealthcareProj-Swift.h"
#import "KHTabBarViewController.h"
#import "KHRiskFactorManager.h"
#import "KHRiskFactor.h"

@interface KHGeneralMedQuestionViewController ()
@property KHPatient *patient;
//@property KHRiskFactorModel *riskFactors;

@property (nonnull) NSArray  *allRiskFactors;
@property NSMutableArray *checkBoxArray;
@property NSMutableArray *EFLRiskFactorArray;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)backButtonAction:(id)sender;
- (IBAction)nextButton:(id)sender;

@end

@implementation KHGeneralMedQuestionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _patient = [KHPatient sharedModel];
    //    _riskFactors = [KHRiskFactorModel sharedModel];
//    _allRiskFactors = [KHRiskFactorManager sharedManager].allRiskFactors;
	
    
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
    
    
    _checkBoxArray = [[NSMutableArray alloc] init];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 600)];
    
    
    CGFloat width = self.view.frame.size.width;
    NSInteger i = 0;
    for (KHRiskFactor *rf in _allRiskFactors) {
        if (rf.isInGeneral && [rf.category isEqualToString:@"Ethnicity, Family, Lifestyle"]) {
            UIView *newSubView = [[UIView alloc] initWithFrame:CGRectMake(0, i*60, width, 60)];
            
            UILabel *riskFactorTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, width - 80, 50)];
            riskFactorTitleLable.numberOfLines = 2;
            riskFactorTitleLable.lineBreakMode = NSLineBreakByWordWrapping;
            riskFactorTitleLable.textColor = [UIColor whiteColor];
            riskFactorTitleLable.text = rf.name;
            
            NSLog(@"rf name: %@,  cate: %@", rf.name, rf.category);
            UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(width - 60, 10, 30,30 )];
            
            NSString *rfID = rf.ID;
            NSString *rfTag = [rfID substringFromIndex:2];
            mySwitch.tag = rfTag.integerValue;
            
            
            [mySwitch addTarget:self action:@selector(switchSelector:) forControlEvents:UIControlEventValueChanged];
            
            [newSubView addSubview:mySwitch];
            [newSubView addSubview:riskFactorTitleLable];
            //            [_checkBoxArray addObject:mySwitch];
            [contentView addSubview:newSubView];
            i++;
        }
        
        
    }
    contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, i*60);
    
    
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
    
    if ([[segue identifier] isEqualToString:@"GeneralMedicalToResultsSegue"])
    {
        // Get reference to the destination view controller
        KHTabBarViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.showTabNumber = 2;
        
    }
    
    
}


-(void)calculateResults {
    NSLog(@"patien current info");
    NSLog(@"num risk factors: %ld", (long)self.patient->numRiskFactors);
    NSLog(@"age %ld", (long)self.patient.age);
    NSLog(@"first, last name: %@ %@", _patient.firstName, _patient.lastName);
    
    
    // FIXME: feed the list of cancers to Patient, and initialize them with NOTHING as stat, Ideally change this to Homepage when pull info from user
    KHRiskFactor *firstRF;
    for (KHRiskFactor *rf in _allRiskFactors) {
        // traverse tje list of allRFs, and find the first RF that is a general screening riskfactor
        if (rf.isInGeneral ) {
            firstRF = rf;
        }
    }
    
    
    // set the status of all general rfs for the patient to be WHITE
    NSLog(@"firstRF info: %@", firstRF.name);
    self.patient.generalList = [firstRF.generalList mutableCopy];
    // each user carry an array of KHGeneralScreening objects, seek out each one of the KHGeneralScreening objects and set its 'status' to White
    /* for (id key in self.patient.generalList) {
        can->status = White;
        NSLog(@"can under patient: %@", can.name);
        //        NSLog(@"vac stat: %u", vac->status);
    } */
    
    
    
    /* DEV COMMENT:
        the following chunk of code seek out each RF as long as it has GeneralScreening as its category.
        Then if this RF is active, we use the general_list that it carries to check against the patient's current list of general_list (general_list is a list of general screenings with status (Blue, Green, Yellow, Red, White))
     
     */
    
    // For each risk factor
    /*
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
            self.patient->numRiskFactors++;
            
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
        
    } */
    NSLog(@"done calculating results!");
    
    
//    for (KHCancer *can in self.patient.cancerList) {
//        NSLog(@"Final patient cancer status: %u", can->status);
//    }
    
}




/* -(Status)getStatusWithCheckCancer:(KHCancer *)checkCancer andPatientCancer:(KHCancer *)patientCancer {
    
    Status newStatus = Nothing;
    
    Status checkStatus = checkCancer->status;
    Status patientStatus = patientCancer->status;
    
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
    if(checkStatus == Contraindicated || patientStatus == Contraindicated)
    {
        newStatus = Contraindicated;
    }
    NSLog(@"got new stat!: %u", newStatus);
    return newStatus;
} */





- (IBAction)nextPageButton:(id)sender {
    for(int i=0; i<_checkBoxArray.count ; i++)
    {
        if ([_checkBoxArray[i] isOn]) {
            //update risnexkfactor status
//            KHCancerRiskFactor *riskFactor = _MedRiskFactorArray[i];
//            riskFactor.isActive = YES;
//            NSUInteger index = [_riskFactors.AllRFListForCancer indexOfObject:riskFactor];
//            [_riskFactors.AllRFListForCancer replaceObjectAtIndex:index withObject:riskFactor];
        }
    }
    
    
    
    // begin calculating results
    NSLog(@"about to calculate results!");
    [self calculateResults];
    
    _patient.completedCancerFlow = YES;
    [self performSegueWithIdentifier:@"cancerMedQuestionToResults" sender:self];
}




- (void) switchSelector: (UISwitch*)sender {
    
    
    for (KHRiskFactor *rf in _allRiskFactors) {
        NSString *rfID = [NSString stringWithFormat:@"rf%ld", (long)sender.tag];
        if ([rfID isEqualToString:rf.ID]) {
            rf.isActive = [sender isOn];
        }
        
    }
    NSLog(@"switch selector triggered");
    for (KHRiskFactor *rf in _allRiskFactors) {
        NSLog(@" rf active status: %@,  %d", rf.name, rf.isActive);
        
    }
    
}


- (IBAction)nextButton:(id)sender {
    //check which switch is on
    //    for(int i=0; i<_checkBoxArray.count ; i++)
    //    {
    //        if ([_checkBoxArray[i] isOn]) {
    //            //update riskfactor status
    //
    //            //            NSMutableArray *tempMutableArray = [_riskFactors. mutableCopy];
    //            KHCancerRiskFactor *riskFactor = _EFLRiskFactorArray[i];
    //            riskFactor.isActive = YES;
    //            NSUInteger index = [_riskFactors.AllRFListForCancer indexOfObject:riskFactor];
    //
    //            [_riskFactors.AllRFListForCancer replaceObjectAtIndex:index withObject:riskFactor];
    //        }
    //    }
    //
    //    for (int i = 0; i<_riskFactors.AllRFListForCancer.count; i++) {
    //        KHCancerRiskFactor *rf =_riskFactors.AllRFListForCancer[i];
    //        if (rf.isActive == YES) {
    //            NSLog(@"active occu rf: %@", rf.name);
    //        }
    //    }
    for (KHRiskFactor *rf in _allRiskFactors) {
        NSLog(@"checking rf value: %@", rf.isActive);
        
    }
    
    
    //segue
    [self performSegueWithIdentifier:@"cancerEFLRFToMedicalCondRFSegue" sender:self];
    
}
- (IBAction)backButtonAction:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end



