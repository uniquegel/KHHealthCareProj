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
#import "KHGeneralScreening.h"
#import "KHRiskFactorManager.h"

@interface KHGeneralMedQuestionViewController ()
@property KHPatient *patient;
//@property KHRiskFactorModel *riskFactors;

@property (nonnull) NSArray  *allRiskFactors;
@property (nonnull) NSArray  *generalRiskFactors;
@property NSMutableArray *checkBoxArray;
@property NSMutableArray *EFLRiskFactorArray;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)backButtonAction:(id)sender;
- (IBAction)nextButton:(id)sender;


-(Status)getStatusWithCheckGeneralScreening:(KHGeneralScreening *)checkCancer andPatientGeneralScreening:(KHGeneralScreening *)patientCancer;

@end

@implementation KHGeneralMedQuestionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _patient = [KHPatient sharedModel];
    //    _riskFactors = [KHRiskFactorModel sharedModel];
    KHRiskFactorManager *manager = [KHRiskFactorManager sharedManager];
    _allRiskFactors = manager.allRiskFactors;
    _generalRiskFactors = manager.generalRiskFactors;
    
    
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
    for (KHRiskFactor *rf in self.generalRiskFactors) {
        if ([rf.category isEqualToString:@"Ethnicity, Family, Lifestyle"]) {
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
    NSLog(@"num risk factors: %ld", (long)self.patient.numRiskFactors);
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
    for (id key in self.patient.generalList) {
        
        
        
        KHGeneralScreening *gen = [self.patient.generalList objectForKey:key];
        gen->status = White;
        [self.patient.generalList setObject:gen forKey:key];
    }
    
    
    
    /* DEV COMMENT:
        the following chunk of code seek out each RF as long as it has GeneralScreening as its category.
        Then if this RF is active, we use the general_list that it carries to check against the patient's current list of general_list (general_list is a list of general screenings with status (Blue, Green, Yellow, Red, White))
     
     */
    
    // For each general risk factor
    for (KHRiskFactor *rf in _generalRiskFactors) {
        if (rf.isActive) {
            self.patient.numRiskFactors++;
            
            NSArray *checkGeneralScreeningsList = rf.generalList;
            NSArray *patientGeneralScreeningsList = self.patient.generalList;
            
            
            for (id key in rf.generalList) {
                KHGeneralScreening *checkGS = [rf.generalList objectForKey:key];
                KHGeneralScreening *patientGS = [self.patient.generalList objectForKey:key];
                Status newStatus = [self getStatusWithCheckGeneralScreening:checkGS  andPatientGeneralScreening:patientGS];
                patientGS->status = newStatus;
                [self.patient.generalList setObject:patientGS forKey:key];
                
            }
        }
    }
    
    NSLog(@"done calculating results!");
    
}




-(Status)getStatusWithCheckGeneralScreening:(KHGeneralScreening *)checkGS andPatientGeneralScreening:(KHGeneralScreening *)patientGS {
    
    Status newStatus = White;
    
    Status checkStatus = checkGS->status;
    Status patientStatus = patientGS->status;
    
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
    NSLog(@"about to calculate results!");
    [self calculateResults];
    
        _patient.completedGeneralFlow = YES;
    NSLog(@"about to perform segue");
    //segue
        [self performSegueWithIdentifier:@"GeneralMedicalToResultsSegue" sender:self];
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

- (IBAction)backButtonAction:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end



