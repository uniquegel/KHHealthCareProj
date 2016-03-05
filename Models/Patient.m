//
//  Patient.m
//  KHHealthCareProj
//
//  Created by Ke Luo on 3/1/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "Patient.h"
#import "VaccineListModel.h"
#import "CancerListModel.h"

@implementation Patient

// singleton
+(instancetype) sharedModel{
    static Patient *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        // instantiate vaccine array
        VaccineListModel *vaccineModel = [VaccineListModel sharedModel];
        self.vaccineList = [NSArray arrayWithArray:vaccineModel.vaccineList];
        
        // instantiate cancer array
        CancerListModel *cancerModel = [CancerListModel sharedModel];
        self.cancerList = [NSArray arrayWithArray:cancerModel.cancerList];
        
        // instantiate risk factor arrays
        self.cancerRiskFactorList = [[NSMutableArray alloc] init];
        self.vaccineRiskFactorList = [[NSMutableArray alloc] init];
        
        
    }
    
    return self;
}

@end
