//
//  ResultsPageViewController.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "ResultsPageViewController.h"
#import "Patient.h"

@interface ResultsPageViewController()

@property (nonatomic, strong) Patient *patient;

@end

@implementation ResultsPageViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.patient = [Patient sharedModel];
    
    [self calculateResults];
    
}

-(void)calculateResults {
    
    
    
    
}

@end
