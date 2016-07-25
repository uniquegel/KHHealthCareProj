//
//  KHGeneralEFLQuestionViewController.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 6/22/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHGeneralEFLQuestionViewController.h"
#import "KHPatient.h"
#import "KHHealthcareProj-Swift.h"
#import "KHRiskFactorManager.h"

@interface KHGeneralEFLQuestionViewController ()
@property KHPatient *patient;
//@property KHRiskFactorModel *riskFactors;

@property (nonnull) NSArray  *allRiskFactors;
@property NSMutableArray *checkBoxArray;
@property NSMutableArray *EFLRiskFactorArray;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)backButtonAction:(id)sender;
- (IBAction)nextButton:(id)sender;

@end



@implementation KHGeneralEFLQuestionViewController

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
            
            NSString *rfID = rf.id;
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
/*
 */

- (void) switchSelector: (UISwitch*)sender {
    
    
    for (KHRiskFactor *rf in _allRiskFactors) {
        NSString *rfID = [NSString stringWithFormat:@"rf%ld", (long)sender.tag];
        if ([rfID isEqualToString:rf.id]) {
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


