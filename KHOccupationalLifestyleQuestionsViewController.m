//
//  KHOccupationalLifestyleQuestionsViewController.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHOccupationalLifestyleQuestionsViewController.h"
#import "KHPatient.h"
#import "KHRiskFactorModel.h"
#import "KHVaccineRiskFactor.h"
@interface KHOccupationalLifestyleQuestionsViewController()
@property KHPatient *patient;
@property KHRiskFactorModel *riskFactors;
@property NSMutableArray *checkBoxArray;
@end

@implementation KHOccupationalLifestyleQuestionsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _patient = [KHPatient sharedModel];
    _riskFactors = [KHRiskFactorModel sharedModel];
    
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    _checkBoxArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_riskFactors.vaccineRiskFactorList count] ; i++) {
        UIView *newSubView = [[UIView alloc] initWithFrame:CGRectMake(0, i*50, 200, 50)];
        UILabel *riskFactorTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 100, 20)];
        KHVaccineRiskFactor *vaccineRiskFactor=_riskFactors.vaccineRiskFactorList[i];
        riskFactorTitleLable = vaccineRiskFactor.name;
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    //check if all fields full, in not alert view

    
    
    
    
    
    
    //if yes set data to patient, then segue
}
@end
