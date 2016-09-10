//
//  Patient.m
//  KHHealthCareProj
//
//  Created by Ke Luo on 3/1/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHPatient.h"
#import "KHVaccineListModel.h"
#import "KHCancerListModel.h"

@implementation KHPatient


- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        _collectedBasicInfo = NO;
        _completedCancerFlow = NO;
        _completedVaccineFlow = NO;
        _completedGeneralFlow = NO;
        // instantiate vaccine array
//        KHVaccineListModel *vaccineModel = [KHVaccineListModel sharedModel];
//        self.vaccineList = [NSMutableArray arrayWithArray:vaccineModel.vaccineList];
//        
//        // instantiate cancer array
//        KHCancerListModel *cancerModel = [KHCancerListModel sharedModel];
//        self.cancerList = [NSArray arrayWithArray:cancerModel.cancerList];
//        
//        //
        
                
    }
    
    return self;
}


// singleton
+(instancetype) sharedModel{
    static KHPatient *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

@end
