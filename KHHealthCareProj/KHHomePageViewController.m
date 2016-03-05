//
//  KHHomePageViewController.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHHomePageViewController.h"
#import "VaccineListModel.h"
#import "CancerListModel.h"

@implementation KHHomePageViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initializeArray];
    
}

-(void)initializeArray {
    
    
    // initialize vaccine array by pulling from server
    VaccineListModel *vaccineModel = [VaccineListModel sharedModel];
    
    
    // initialize cancer array by pulling from server
    CancerListModel *cancerModel = [CancerListModel sharedModel];
    
    
}

@end
