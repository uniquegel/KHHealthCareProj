//
//  RiskFactorModel.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHRiskFactorModel.h"
#import "KHVaccineRiskFactor.h"

@implementation KHRiskFactorModel


-(instancetype)init {
    
    self = [super init];
    
    if (self) {
    
        // initialize riskFactorList by pulling from server
        
        
        // TEMPORARY - initialize with dummy data
        NSMutableArray *tempList = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < 5; i++) {
            KHVaccineRiskFactor *vaccineRiskFactor = [[KHVaccineRiskFactor alloc]
                                                    initWithName:[NSString stringWithFormat:@"%d", i]
                                                    andType:@"New Type"];
            [tempList addObject:vaccineRiskFactor];
        }
        self.vaccineRiskFactorList = tempList;
    }
    
    return self;
    
}

+(instancetype)sharedModel {
    
    static KHRiskFactorModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
    
}

@end