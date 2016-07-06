//
//  KHBasicQuestionViewController.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHBasicQuestionViewController.h"
#import "KHPatient.h"
#import "KHRiskFactorModel.h"
#import "KHHealthCareProj-Swift.h"

@import FirebaseAnalytics;

@interface KHBasicQuestionViewController ()
@property KHPatient *patient;
@property NSArray *pickerData;
- (IBAction)bgButtonAction:(id)sender;
- (IBAction)backButton:(id)sender;

@end

@implementation KHBasicQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _patient = [KHPatient sharedModel];
    
    KHRiskFactorModel *rfModel = [KHRiskFactorModel sharedModel];
    
//    NSLog(@"got vaccine rf in homepage view: %@", rfModel.vaccineMedRiskFactorList);
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:gestureRecognizer];
     _pickerData = @[@"Select", @"Caucasian", @"Hispanic", @"Asian", @"African American", @"Other"];
    self.ethnicityPicker.dataSource = self;
    self.ethnicityPicker.delegate = self;
    self.birthdayTF.enabled=NO;
    
    
    //initialize based on patient info
    if (_patient.collectedBasicInfo) {
        _firstNameTF.text = _patient.firstName;
        _lastNameTF.text = _patient.lastName;
        if ([_patient.gender isEqualToString:@"female"]) {
            [_femaleButtonOutlet setSelected:YES];
        }
        else if ([_patient.gender isEqualToString:@"male"]){
            [_maleButtonOutlet setSelected:YES];
        }
        
        _datePicker.date = _patient.birthday;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:_patient.birthday];
        _birthdayTF.text = strDate;
        [_ethnicityPicker selectRow:[_pickerData indexOfObject:_patient.ethnicty ]  inComponent:0 animated:YES];
    }
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
//    check if all fields full, in not alert view
//    bool allFieldsFilled = true;
//    if ([self.firstNameTF.text isEqualToString:@""]) {
//        allFieldsFilled = false;
//    }
//    NSLog(@" firstName field: %@", self.firstNameTF.text);
//    if ([self.lastNameTF.text isEqualToString:@""]) {
//        allFieldsFilled = false;
//    }
//    if ([self.birthdayTF.text isEqualToString:@""]) {
//        allFieldsFilled = false;
//    }
//    if (self.maleButtonOutlet.selected != YES && self.femaleButtonOutlet.selected != YES) {
//        allFieldsFilled = false;
//    }
//    if ([self.ethnicityPicker selectedRowInComponent:0]==0) {
//        NSLog(@"ethnicty picker false!");
//        allFieldsFilled = false;
//    }
//    
//    if (allFieldsFilled) {
//        
//        //name
//        _patient.firstName = self.firstNameTF.text;
//        _patient.lastName = self.lastNameTF.text;
//        
//        //ethnictiy
//        _patient.ethnicty = _pickerData[[self.ethnicityPicker selectedRowInComponent:0]];
//        
//        //birthday
//        NSDate* birthday = _datePicker.date;
//        _patient.birthday = birthday;
//        
//        //calculate age
//        NSDate* now = [NSDate date];
//        NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
//                                           components:NSCalendarUnitYear
//                                           fromDate:birthday
//                                           toDate:now
//                                           options:0];
//        NSInteger age = [ageComponents year];
//        _patient.age = age;
//        
//        
//        
//        [self performSegueWithIdentifier:@"basicQuestionToOccuRiskFactors" sender:self];
//    }
//    else{
//        
//    }
//    
    


    
    
    //if yes set data to patient, then segue
}




//Pickerview components
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)isMaleButton:(id)sender {
    _maleButtonOutlet.selected = YES;
    _femaleButtonOutlet.selected = NO;
}

- (IBAction)isFemaleButton:(id)sender {
    _maleButtonOutlet.selected = NO;
    _femaleButtonOutlet.selected = YES;
}

- (IBAction)datePickerAction:(id)sender {
    NSDate* birthday = _datePicker.date;

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:birthday];
    
    _birthdayTF.text = strDate;

    
}

//Helper function to check fields
- (bool)inputIsValid {
	//check if all fields full, in not alert view
	bool allFieldsFilled = true;
	if ([self.firstNameTF.text isEqualToString:@""]) {
		allFieldsFilled = false;
	}
	//    NSLog(@" firstName field: %@", self.firstNameTF.text);
	if ([self.lastNameTF.text isEqualToString:@""]) {
		allFieldsFilled = false;
	}
	if ([self.birthdayTF.text isEqualToString:@""]) {
		allFieldsFilled = false;
	}
	if (self.maleButtonOutlet.selected != YES && self.femaleButtonOutlet.selected != YES) {
		allFieldsFilled = false;
	}
	if ([self.ethnicityPicker selectedRowInComponent:0]==0) {
		allFieldsFilled = false;
	}
	
	return allFieldsFilled;
}



- (IBAction)startQuestionButtonAction:(id)sender {
	
    if ([self inputIsValid]) {
		
        //name
        _patient.firstName = self.firstNameTF.text;
        _patient.lastName = self.lastNameTF.text;

		
        //gender
		NSString *gender = @"";
        if (_femaleButtonOutlet.selected) {
			gender = @"female";
        }
        else if (_maleButtonOutlet.selected){
			gender = @"male";
        }
		_patient.gender = gender;
        
        //ethnictiy
		NSString *ethnicity =_pickerData[[self.ethnicityPicker selectedRowInComponent:0]];
        _patient.ethnicty = _pickerData[[self.ethnicityPicker selectedRowInComponent:0]];
        
        
        //       birthday
        NSDate* birthday = _datePicker.date;
    
        //calculate age
        NSDate* now = [NSDate date];
        NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                           components:NSCalendarUnitYear
                                           fromDate:birthday
                                           toDate:now
                                           options:0];
        NSInteger age = [ageComponents year];
        
    
        _patient.age = age;
        NSLog(@"patient age: %ld", (long)_patient.age);
        _patient.birthday = birthday;
		
		//create basic info object
		KHUser *user = [[KHUser alloc] initWithFirstName:self.firstNameTF.text lastName:self.lastNameTF.text gender:gender birthday:birthday eth:ethnicity age:age];
		
		[KHUserManager sharedManager].patient = user;
		[[KHUserManager sharedManager] uploadPatientInfo];
		


        NSLog(@"SCRTYPE: %lu", (unsigned long)_screeningType);
        
        _patient.collectedBasicInfo = YES;
		
		
		
        switch (_screeningType) {
            case kScreenTypeVaccine:
            {
                [self performSegueWithIdentifier:@"basicQuestionToVacccineOccuRiskFactors" sender:self];
                break;
            }
            case kScreenTypeCancer:
            {
				
                [self performSegueWithIdentifier:@"basicQuestionToCancerEFLQuestions" sender:self];
				
                break;
            }
            case kScreenTypeGeneral:{
                [self performSegueWithIdentifier:@"basicQuestionToGeneralEFLSegue" sender:self];
                
                
                break;
            }
            default:
                break;
        }
    }
    else{

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops"
                                                                                 message:@"Please fill out all the blanks!"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (IBAction)bgButtonAction:(id)sender {
//    [self.view endEditing:YES];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end


