//
//  KHCancerEFLQuestionViewController.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 5/27/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHCancerEFLQuestionViewController.h"
#import "KHPatient.h"
#import "KHRiskFactorModel.h"
#import "KHCancerListModel.h"
#import "KHCancerRiskFactor.h"
@interface KHCancerEFLQuestionViewController ()
@property KHPatient *patient;
@property KHRiskFactorModel *riskFactors;

@property NSMutableArray *checkBoxArray;
@property NSMutableArray *EFLRiskFactorArray;
- (IBAction)backButtonAction:(id)sender;

@end



@implementation KHCancerEFLQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _patient = [KHPatient sharedModel];
    _riskFactors = [KHRiskFactorModel sharedModel];
    
    [self UISetup];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    NSLog(@"view will appear!");
    [self adjustCheckboxToggle];
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
    _EFLRiskFactorArray = [[NSMutableArray alloc] init];
    //get Occu risk factors only
    for (KHCancerRiskFactor *rf in _riskFactors.AllRFListForCancer) {
        if ([rf.type isEqualToString:@"Ethnicity Family Lifestyle"] ) {
            [_EFLRiskFactorArray addObject:rf];
        }
    }
    
    _checkBoxArray = [[NSMutableArray alloc] init];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _EFLRiskFactorArray.count*60)];
    
    for (int i = 0; i < [_EFLRiskFactorArray count] ; i++) {
        
        CGFloat width = self.view.frame.size.width;
        
        UIView *newSubView = [[UIView alloc] initWithFrame:CGRectMake(0, i*60, width, 60)];
        UILabel *riskFactorTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, width - 80, 50)];
        riskFactorTitleLable.numberOfLines = 2;
        riskFactorTitleLable.lineBreakMode = NSLineBreakByWordWrapping;
        riskFactorTitleLable.textColor = [UIColor whiteColor];
        KHCancerRiskFactor *cancerRiskFactor=_EFLRiskFactorArray[i];
        NSLog(@"got vaccine!");
        NSLog(@"name of riskfa: %@", cancerRiskFactor.name);
        riskFactorTitleLable.text = cancerRiskFactor.name;
        
        //        riskFactorTitleLable.text = @"NEW RISK FACTOR";
        UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(width - 60, 10, 30,30 )];
        
        
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
        KHCancerRiskFactor *riskFactor = _EFLRiskFactorArray[i];
        
        if (riskFactor.isActive) {
            [_checkBoxArray[i] setOn:YES];
        }
        
    }
}

/*
*/

- (IBAction)nextButton:(id)sender {
    //check which switch is on
    for(int i=0; i<_checkBoxArray.count ; i++)
    {
        if ([_checkBoxArray[i] isOn]) {
            //update riskfactor status
            
            //            NSMutableArray *tempMutableArray = [_riskFactors. mutableCopy];
            KHCancerRiskFactor *riskFactor = _EFLRiskFactorArray[i];
            riskFactor.isActive = YES;
            NSUInteger index = [_riskFactors.AllRFListForCancer indexOfObject:riskFactor];
            
            [_riskFactors.AllRFListForCancer replaceObjectAtIndex:index withObject:riskFactor];
        }
    }
    
    for (int i = 0; i<_riskFactors.AllRFListForCancer.count; i++) {
        KHCancerRiskFactor *rf =_riskFactors.AllRFListForCancer[i];
        if (rf.isActive == YES) {
            NSLog(@"active occu rf: %@", rf.name);
        }
    }
    
    
    //segue
    [self performSegueWithIdentifier:@"cancerEFLRFToMedicalCondRFSegue" sender:self];
    
}
- (IBAction)backButtonAction:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end


