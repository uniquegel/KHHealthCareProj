//
//  RiskFactor.m
//  KHHealthCareProj
//
//  Created by Ke Luo on 3/1/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHVaccineRiskFactor.h"
#import "KHVaccineListModel.h"


@implementation KHVaccineRiskFactor

- (instancetype)initWithName:(NSString *)newName andType:(NSString *)newType
{
    
    self = [super init];
    
    if (self) {
        
        self.name = newName;
        self.type = newType;
        self.isActive = NO;
        
        // instantiate array
        KHVaccineListModel *vaccineModel = [KHVaccineListModel sharedModel];
        self.vaccineList = [NSArray arrayWithArray:vaccineModel.vaccineList];
        
    }
    
    return self;
}

@end
