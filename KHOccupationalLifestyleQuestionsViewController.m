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
#import <QuartzCore/QuartzCore.h>

@interface KHOccupationalLifestyleQuestionsViewController()
@property KHPatient *patient;
@property KHRiskFactorModel *riskFactors;

@property NSMutableArray *checkBoxArray;
@property NSMutableArray *occuRiskFactorArray;
- (IBAction)BackButtonAction:(id)sender;

- (IBAction)nextButtonAction:(id)sender;
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

    NSLog(@"vacctineRiskFactor list: %@", _riskFactors.AllRFListForVaccine);
    _occuRiskFactorArray = [[NSMutableArray alloc] init];
    //get Occu risk factors only
    for (KHVaccineRiskFactor *rf in _riskFactors.AllRFListForVaccine) {
        if ([rf.type isEqualToString:@"Occupational slush Lifestyle"] ) {
            [_occuRiskFactorArray addObject:rf];
        }
    }
    
    _checkBoxArray = [[NSMutableArray alloc] init];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _occuRiskFactorArray.count*50)];
    
    for (int i = 0; i < [_occuRiskFactorArray count] ; i++) {
        
        CGFloat width = self.view.frame.size.width;
        
        
        
        UIView *newSubView = [[UIView alloc] initWithFrame:CGRectMake(0, i*60, width, 60)];
        UILabel *riskFactorTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, width - 80, 50)];
        riskFactorTitleLable.numberOfLines = 2;
        
        riskFactorTitleLable.textColor = [UIColor whiteColor];
        KHVaccineRiskFactor *vaccineRiskFactor=_occuRiskFactorArray[i];
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
//    _scrollView.layer.cornerRadius=8.0f;
    _scrollView.layer.masksToBounds=YES;
    _scrollView.layer.borderColor=[[UIColor whiteColor]CGColor];
    _scrollView.layer.borderWidth= 1.0f;
    [_scrollView addSubview:contentView];
    _scrollView.contentSize = contentView.frame.size;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    
    //check if all fields full, in not alert view

    
    //if yes set data to patient, then segue
    
}


- (IBAction)BackButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButtonAction:(id)sender {
    //check which switch is on
    for(int i=0; i<_checkBoxArray.count ; i++)
    {
        if ([_checkBoxArray[i] isOn]) {
            //update riskfactor status
            
//            NSMutableArray *tempMutableArray = [_riskFactors. mutableCopy];
            KHVaccineRiskFactor *riskFactor = _occuRiskFactorArray[i];
            riskFactor.isActive = YES;
            NSUInteger index = [_riskFactors.AllRFListForVaccine indexOfObject:riskFactor];
            
            [_riskFactors.AllRFListForVaccine replaceObjectAtIndex:index withObject:riskFactor];
        }
    }
    
    for (int i = 0; i<_riskFactors.AllRFListForVaccine.count; i++) {
        KHVaccineRiskFactor *rf =_riskFactors.AllRFListForVaccine[i];
        if (rf.isActive == YES) {
            NSLog(@"active occu rf: %@", rf.name);
        }
    }
    
    
    //segue
    [self performSegueWithIdentifier:@"LifeStyleRFToMedicalCondRFSegue" sender:self];
    
}


@end