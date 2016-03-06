//
//  KHBasicQuestionViewController.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHBasicQuestionViewController.h"
#import "KHPatient.h"

@interface KHBasicQuestionViewController ()
@property KHPatient *patient;
@property NSArray *pickerData;
@end

@implementation KHBasicQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _patient = [KHPatient sharedModel];
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:gestureRecognizer];
     _pickerData = @[@"Select", @"Caucasian", @"Hispanic", @"Asian", @"African American", @"Other"];
    self.ethnicityPicker.dataSource = self;
    self.ethnicityPicker.delegate = self;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    //check if all fields full, in not alert view
    bool allFieldsFilled = true;
    if ([self.firstNameTF.text isEqualToString:@""]) {
        allFieldsFilled = false;
    }
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
        NSLog(@"ethnicty picker false!");
        allFieldsFilled = false;
    }
    
    if (allFieldsFilled) {
        _patient.firstName = self.firstNameTF.text;
        _patient.lastName = self.lastNameTF.text;
        
        
        
        _patient.ethnicty = _pickerData[[self.ethnicityPicker selectedRowInComponent:0]];
        
        
        
        [self performSegueWithIdentifier:@"basicQuestionToOccuRiskFactors" sender:self];
    }
    else{
        
    }
    
    


    
    
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
}

- (IBAction)isFemaleButton:(id)sender {
}
@end


