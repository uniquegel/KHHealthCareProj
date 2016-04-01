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
    
    [self UISetup];
    
}

- (void)UISetup {
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:gestureRecognizer];

    _checkBoxArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_riskFactors.vaccineRiskFactorList count] ; i++) {
        
        CGFloat width = self.view.frame.size.width;
        
        UIView *newSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 200 + i*50, width, 50)];
        UILabel *riskFactorTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, width - 80, 20)];
        KHVaccineRiskFactor *vaccineRiskFactor=_riskFactors.vaccineRiskFactorList[i];
        riskFactorTitleLable.text = vaccineRiskFactor.name;
        UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(width - 80, 15, 30,30 )];
        
        [newSubView addSubview:mySwitch];
        [newSubView addSubview:riskFactorTitleLable];
        [_checkBoxArray addObject:mySwitch];
        
        [self.scrollView addSubview:newSubView];
        
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
