//
//  KHReusableRFQuestionViewController.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 9/10/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHReusableRFQuestionViewController.h"
#import "KHVaccine.h"
#import "KHCancer.h"
#import "KHGeneralScreening.h"

#import "KHHomePageViewController.h"
#import "KHRiskFactorManager.h"
#import "KHRiskFactor.h"

@interface KHReusableRFQuestionViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleOutlet;

@property ScreeningType curScreeningType;
@property NSInteger curScreeningStep;
@property KHPatient *patient;
@property KHRiskFactorManager *rfManager;
@property NSArray *allRiskFactorArray;
@property NSArray *vaccineRiskFactorArray;
@property NSArray *cancerRiskFactorArray;
@property NSArray *generalRiskFactorArray;
@property NSMutableArray *currentRiskFactorArray;

- (IBAction)onBackBtnTap:(id)sender;
- (IBAction)onNextBtnTap:(id)sender;


//@property (strong, nonatomic)


-(void)prepareTitleForScreeningType:(ScreeningType)type  andStep:(NSInteger)step;
-(void)prepareContentForScreeningType:(ScreeningType)type  andStep:(NSInteger)step;

- (void) switchSelector: (UISwitch*)sender;

-(void)calculateResultsForScreeningType:(ScreeningType)type;
-(Status)getNewStatusWithCheckObj:(id)checkObj andPatientObject:(id )patientObj;
-(Status)getStatusFromString:(NSString*)statusString;
-(NSString *)getStringFromStatus:(Status)status;
@end

@implementation KHReusableRFQuestionViewController


- (instancetype)initControllerForScreeningType:(ScreeningType)type andScreeningStep:(NSInteger)step {
    self.curScreeningType = type;
    self.curScreeningStep = step;
    
    
    
    self.rfManager = [KHRiskFactorManager sharedManager];
    
    self.allRiskFactorArray = self.rfManager.allRiskFactors;
    self.generalRiskFactorArray = self.rfManager.generalRiskFactors;
    self.vaccineRiskFactorArray = self.rfManager.vaccineRiskFactors;
    self.cancerRiskFactorArray = self.rfManager.cancerRiskFactors;
    
    self.currentRiskFactorArray = [[NSMutableArray alloc] init];
    
    [self prepareTitleForScreeningType:type andStep:step];
    [self prepareContentForScreeningType:type andStep:step];
    
    if (step == 2) {
        // if at last step, call calcualte results after tap on "Next"
        
    }
    return self;
}

- (void)initializeDataForScreeningType:(ScreeningType)type andScreeningStep:(NSInteger)step {
    self.curScreeningType = type;
    self.curScreeningStep = step;
    
    
    
    self.rfManager = [KHRiskFactorManager sharedManager];
    
    self.allRiskFactorArray = self.rfManager.allRiskFactors;
    self.generalRiskFactorArray = self.rfManager.generalRiskFactors;
    self.vaccineRiskFactorArray = self.rfManager.vaccineRiskFactors;
    self.cancerRiskFactorArray = self.rfManager.cancerRiskFactors;
    
    self.currentRiskFactorArray = [[NSMutableArray alloc] init];
    
    [self prepareTitleForScreeningType:type andStep:step];
    [self prepareContentForScreeningType:type andStep:step];
    
    if (step == 2) {
        // if at last step, call calcualte results after tap on "Next"
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.patient = [KHPatient sharedModel];
    
    [self initializeDataForScreeningType:self.patient.curScreeningType andScreeningStep:(self.patient.curScreeningStep+1)];
    //    self.navigationController.toolbarHidden = NO;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    // update patient screening type and step
    self.patient.curScreeningStep = self.curScreeningStep;
    self.patient.curScreeningType = self.curScreeningType;
    
    NSLog(@"patient current screee type: %lu, step:%ld", (unsigned long)self.patient.curScreeningType, (long)self.patient.curScreeningStep);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Private Methods

-(void)prepareTitleForScreeningType:(ScreeningType)type  andStep:(NSInteger)step {
    switch (step) {
        case 0:{
            break;
        }
        case 1:{
            self.titleOutlet.text = @"Ethnicity, Family, Life Style Risk Fators";
            break;
        }
        case 2:{
            self.titleOutlet.text = @"Medical Condition Risk Factors";
            break;
        }
            
            
        default:
            break;
    }
}

-(void)prepareContentForScreeningType:(ScreeningType)type  andStep:(NSInteger)step {
    
    [self.currentRiskFactorArray removeAllObjects];
    
    NSLog(@"screening type: %u, and step: %ld", type, (long)step);
    switch (type) {
        case kScreenTypeVaccine:
        {
            //            self.currentRiskFactorArray = [self.vaccineRiskFactorArray mutableCopy];
            
            switch (step) {
                case 0:{
                    
                    break;
                }
                case 1:{
                    // display EFL risk factors
                    
                    for (KHRiskFactor *rf in self.vaccineRiskFactorArray) {
                        if ([rf.category isEqualToString:@"Ethnicity, Family, Lifestyle"]) {
                            [self.currentRiskFactorArray addObject:rf];
                        }
                    }
                    break;
                }
                case 2:{
                    // display medical cond rfs
                    for (KHRiskFactor *rf in self.vaccineRiskFactorArray) {
                        if ([rf.category isEqualToString:@"Medical Condition"]) {
                            [self.currentRiskFactorArray addObject:rf];
                        }
                    }
                    break;
                }
                    
                    
                default:
                    break;
            }
            break;
        }
        case kScreenTypeCancer:
        {
            //            self.currentRiskFactorArray = [self.cancerRiskFactorArray mutableCopy];
            switch (step) {
                case 0:{
                    
                    break;
                }
                case 1:{
                    // display EFL risk factors
                    
                    for (KHRiskFactor *rf in self.cancerRiskFactorArray) {
                        if ([rf.category isEqualToString:@"Ethnicity, Family, Lifestyle"]) {
                            [self.currentRiskFactorArray addObject:rf];
                        }
                    }
                    break;
                }
                case 2:{
                    // display medical cond rfs
                    for (KHRiskFactor *rf in self.cancerRiskFactorArray) {
                        if ([rf.category isEqualToString:@"Medical Condition"]) {
                            [self.currentRiskFactorArray addObject:rf];
                        }
                    }
                    break;
                }
                    
                    
                default:
                    break;
            }
            
            
            break;
        }
            
        case kScreenTypeGeneral:
        {
            //            self.currentRiskFactorArray = [self.generalRiskFactorArray mutableCopy];
            switch (step) {
                case 0:{
                    
                    break;
                }
                case 1:{
                    // display EFL risk factors
                    
                    for (KHRiskFactor *rf in self.generalRiskFactorArray) {
                        if ([rf.category isEqualToString:@"Ethnicity, Family, Lifestyle"]) {
                            [self.currentRiskFactorArray addObject:rf];
                        }
                    }
                    break;
                }
                case 2:{
                    // display medical cond rfs
                    for (KHRiskFactor *rf in self.generalRiskFactorArray) {
                        if ([rf.category isEqualToString:@"Medical Condition"]) {
                            [self.currentRiskFactorArray addObject:rf];
                        }
                    }
                    break;
                }
                    
                    
                default:
                    break;
            }
            
            
            
            break;
        }
            
            
        default:
            break;
    }
    
    NSLog(@"done preparing content with count: %lu", (unsigned long)[self.currentRiskFactorArray count]);
    for (KHRiskFactor *rf in self.currentRiskFactorArray) {
        NSLog(@"rf name: %@", rf.name);
    }
    
}


- (IBAction)onBackBtnTap:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onNextBtnTap:(id)sender {
    if (self.curScreeningStep == 2) {
        // calculate results and display
        self.patient.completedGeneralFlow = YES;
        [self calculateResultsForScreeningType:self.curScreeningType];
        [self performSegueWithIdentifier:@"RFQuestionToResultSegue" sender:self];
        
    }
    else {
        [self performSegueWithIdentifier:@"RFQuestionToRFQuestionSegue" sender:self];
    }
        
    
    
    
    
}

-(void)calculateResultsForScreeningType:(ScreeningType)type {
    NSLog(@"patien current info");
    NSLog(@"num risk factors: %ld", (long)self.patient.numRiskFactors);
    NSLog(@"age %ld", (long)self.patient.age);
    NSLog(@"first, last name: %@ %@", _patient.firstName, _patient.lastName);
    
    self.patient.numRiskFactors = 0;
    
    
    switch (type) {
        case kScreenTypeVaccine:{
            // FIXME: feed the list of cancers to Patient, and initialize them with NOTHING as stat, Ideally change this to Homepage when pull info from user
            KHRiskFactor *firstRF;
            for (KHRiskFactor *rf in self.allRiskFactorArray) {
                // traverse tje list of allRFs, and find the first RF that is a general screening riskfactor
                if (rf.isInVaccine ) {
                    firstRF = rf;
                }
            }
            
            
            // set the status of all general rfs for the patient to be WHITE
            NSLog(@"firstRF info: %@", firstRF.name);
            self.patient.vaccineList = [firstRF.vaccineList mutableCopy];
            // each user carry an array of KHGeneralScreening objects, seek out each one of the KHGeneralScreening objects and set its 'status' to White
            for (id key in self.patient.vaccineList) {
                KHVaccine *vac = [self.patient.vaccineList objectForKey:key];
                vac->status = White;
                [self.patient.vaccineList setObject:vac forKey:key];
            }
            
            
            
            /* DEV COMMENT:
             the following chunk of code seek out each RF as long as it has GeneralScreening as its category.
             Then if this RF is active, we use the general_list that it carries to check against the patient's current list of general_list (general_list is a list of general screenings with status (Blue, Green, Yellow, Red, White))
             
             */
            
            // For each general risk factor
            for (KHRiskFactor *rf in self.allRiskFactorArray) {
                if (rf.isActive) {
                    NSLog(@"found one active rf: %@", rf.name);
                    self.patient.numRiskFactors++;
                    
                    NSLog(@"risk factor generallist: %@", [rf.vaccineList description]);
                    for (id key in rf.vaccineList) {
                        KHVaccine *checkObj = [rf.vaccineList objectForKey:key];
                        KHVaccine *patientObj = [self.patient.vaccineList objectForKey:key];
                        NSLog(@"checking status for GS: %@, %u", checkObj.name, checkObj->status);
                        
                        Status newStatus = [self getNewStatusWithCheckObj:checkObj andPatientObject:patientObj];
                        patientObj->status = newStatus;
                        [self.patient.vaccineList setObject:patientObj forKey:key];
                        
                    }
                }
            }
            
            break;
        }
        case kScreenTypeCancer:{
            // FIXME: feed the list of cancers to Patient, and initialize them with NOTHING as stat, Ideally change this to Homepage when pull info from user
            KHRiskFactor *firstRF;
            for (KHRiskFactor *rf in self.allRiskFactorArray) {
                // traverse tje list of allRFs, and find the first RF that is a general screening riskfactor
                if (rf.isInCancer ) {
                    firstRF = rf;
                }
            }
            
            
            // set the status of all general rfs for the patient to be WHITE
            NSLog(@"firstRF info: %@", firstRF.name);
            self.patient.cancerList = [firstRF.cancerList mutableCopy];
            // each user carry an array of KHGeneralScreening objects, seek out each one of the KHGeneralScreening objects and set its 'status' to White
            for (id key in self.patient.cancerList) {
                KHCancer *can = [self.patient.cancerList objectForKey:key];
                can->status = White;
                [self.patient.cancerList setObject:can forKey:key];
            }
            
            
            
            /* DEV COMMENT:
             the following chunk of code seek out each RF as long as it has GeneralScreening as its category.
             Then if this RF is active, we use the general_list that it carries to check against the patient's current list of general_list (general_list is a list of general screenings with status (Blue, Green, Yellow, Red, White))
             
             */
            
            // For each general risk factor
            for (KHRiskFactor *rf in self.allRiskFactorArray) {
                if (rf.isActive) {
                    NSLog(@"found one active rf: %@", rf.name);
                    self.patient.numRiskFactors++;
                    
                    NSLog(@"risk factor generallist: %@", [rf.cancerList description]);
                    for (id key in rf.cancerList) {
                        KHVaccine *checkObj = [rf.cancerList objectForKey:key];
                        KHVaccine *patientObj = [self.patient.cancerList objectForKey:key];
                        NSLog(@"checking status for GS: %@, %u", checkObj.name, checkObj->status);
                        
                        Status newStatus = [self getNewStatusWithCheckObj:checkObj andPatientObject:patientObj];
                        patientObj->status = newStatus;
                        [self.patient.cancerList setObject:patientObj forKey:key];
                        
                    }
                }
            }
            break;
        }
        case kScreenTypeGeneral:{
            
            // FIXME: feed the list of cancers to Patient, and initialize them with NOTHING as stat, Ideally change this to Homepage when pull info from user
            KHRiskFactor *firstRF;
            for (KHRiskFactor *rf in self.allRiskFactorArray) {
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
                NSMutableDictionary *dict = [self.patient.generalList objectForKey:key];
                NSLog(@"in here");
                NSLog(@"dict: %@", [dict description]);
                dict[@"value"] = @"W";
                
            }
            NSLog(@"done clearing");
            /* for (id key in self.patient.generalList) {
                KHGeneralScreening *gen = [self.patient.generalList objectForKey:key];
                gen->status = White;
                [self.patient.generalList setObject:gen forKey:key];
            }*/
            
            NSLog(@"cleared patient generallist: %@", [self.patient.generalList description]);
            
            
            
            /* DEV COMMENT:
             the following chunk of code seek out each RF as long as it has GeneralScreening as its category.
             Then if this RF is active, we use the general_list that it carries to check against the patient's current list of general_list (general_list is a list of general screenings with status (Blue, Green, Yellow, Red, White))
             
             */
            
            // For each general risk factor
            for (KHRiskFactor *rf in self.allRiskFactorArray) {
                if (rf.isActive) {
                    NSLog(@"found one active rf: %@", rf.name);
                    self.patient.numRiskFactors++;
                    
                    NSLog(@"risk factor generallist: %@", [rf.generalList description]);
                    for (id key in rf.generalList) {
                        NSMutableDictionary *checkDict = [rf.generalList objectForKey:key];
                        NSMutableDictionary *patientDict = [self.patient.generalList objectForKey:key];
                        
                        KHGeneralScreening *checkObj = [[KHGeneralScreening alloc] initWithName:checkDict[@"name"] andStatus: [self getStatusFromString:checkDict[@"value"]]];
                        KHGeneralScreening *patientObj = [[KHGeneralScreening alloc] initWithName:patientDict[@"name"] andStatus: [self getStatusFromString:patientDict[@"value"]]];
                        
                        NSLog(@"checkObj status: ");
                    
                        Status newStatus = [self getNewStatusWithCheckObj:checkObj andPatientObject:patientObj];
                        
                        patientObj->status = newStatus;
                        
                        patientDict[@"value"] = [self getStringFromStatus:patientObj->status];
                        [self.patient.generalList setObject:patientDict forKey:key];
                        
                        /* KHGeneralScreening *checkGS = [rf.generalList objectForKey:key];
                        KHGeneralScreening *patientGS = [self.patient.generalList objectForKey:key];
                        NSLog(@"checking status for GS: %@, %u", checkGS.name, checkGS->status);
                        
                        Status newStatus = [self getNewStatusWithCheckObj:checkGS andPatientObject:patientGS];
                        
                        patientGS->status = newStatus;
                        [self.patient.generalList setObject:patientGS forKey:key]; */
                        
                    }
                }
            }

            break;
        }
            
            
        default:
            break;
    }
    
    
    NSLog(@"done calculating results!");
    NSLog(@"%@", [self.patient.generalList description]);
    
}

-(Status)getStatusFromString:(NSString*)statusString {
    Status status;
    if ([statusString isEqualToString:@"W"]) {
        status = White;
    }
    else if ([statusString isEqualToString:@"Y"]){
        status = Yellow;
    }
    else if ([statusString isEqualToString:@"G"]){
        status = Green;
    }
    else if ([statusString isEqualToString:@"B"]){
        status = Blue;
    }
    else if ([statusString isEqualToString:@"R"]){
        status = Red;
    }
    else{
        NSLog(@"Status String invalid: %@", statusString);
        return nil;
    }
    return status;
}

-(NSString *)getStringFromStatus:(Status)status {
    NSString *statusString;
    switch (status) {
        case White:
        {
            statusString = @"W";
            break;
        }
        case Red:
        {
            statusString = @"R";
            break;
        }
        case Blue:
        {
            statusString = @"B";
            break;
        }
        case Green:
        {
            statusString = @"G";
            break;
        }
        case Yellow:
        {
            statusString = @"Y";
            break;
        }
        default:
            return nil;
            break;
    }
    return statusString;

}



-(Status)getNewStatusWithCheckObj:(id)checkObj andPatientObject:(id )patientObj {
    
    Status newStatus = White;
    
    Status checkStatus;
    Status patientStatus;
    switch (self.curScreeningType) {
        case kScreenTypeVaccine:{
            
            KHVaccine *checkVac = checkObj;
            KHVaccine *patientVac = patientObj;
            checkStatus = checkVac->status;
            patientStatus = patientVac->status;
            
            break;
        }
        case kScreenTypeCancer:{
            KHCancer *checkCan = checkObj;
            KHCancer *patientCan = patientObj;
            checkStatus = checkCan->status;
            patientStatus = patientCan->status;
            break;
        }
        case kScreenTypeGeneral:{
            KHGeneralScreening *checkGen = checkObj;
            KHGeneralScreening *patientGen = patientObj;
            checkStatus = checkGen->status;
            patientStatus = patientGen->status;
            break;
        }
            
        default:
            break;
    }
    
    
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




#pragma mark - Selectors
- (void) switchSelector: (UISwitch*)sender {
    
    for (KHRiskFactor *rf in self.allRiskFactorArray) {
        
        NSString *rfID = [NSString stringWithFormat:@"rf%li", (long)sender.tag];
        if ([rf.ID isEqualToString:rfID]) {
            NSLog(@"switch selector triggered: %@, name: %@", rfID, rf.name);
            rf.isActive = [sender isOn];
            _rfManager.allRiskFactors = self.allRiskFactorArray;
            
        }
    }
    
    
    for (KHRiskFactor *rf in _rfManager.allRiskFactors) {
        NSLog(@" rf active status:%@, %@,  %d", rf.ID, rf.name, rf.isActive);
        
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentRiskFactorArray.count;
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"Cell";
    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] ;
    KHRiskFactor *cellRF;
    cellRF = [self.currentRiskFactorArray objectAtIndex:indexPath.row];
    cell.textLabel.text = cellRF.name;
    //add a switch
    UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
    
    NSString *rfID = cellRF.ID;
    NSString *rfTag = [rfID substringFromIndex:2];
    switchview.tag = rfTag.integerValue;
    [switchview setOn:cellRF.isActive];
    [switchview addTarget:self action:@selector(switchSelector:) forControlEvents:UIControlEventValueChanged];
    
    cell.accessoryView = switchview;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
