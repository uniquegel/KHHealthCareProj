//
//  RiskFactor.m
//  KHHealthCareProj
//
//  Created by Ke Luo on 3/1/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "VaccineRiskFactor.h"
#import "VaccineListModel.h"


@implementation VaccineRiskFactor

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        // instantiate array
        VaccineListModel *sharedModel = [VaccineListModel sharedModel];
        self.vaccineList = [NSArray arrayWithArray:sharedModel.vaccineList];
        
    }
    
    return self;
}

@end
