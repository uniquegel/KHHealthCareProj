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

- (instancetype)initWithName:(NSString *)newName andType:(NSString *)newType
{
    
    self = [super init];
    
    if (self) {
        
        self.name = newName;
        self.type = newType;
        self.isActive = true;
        
        // instantiate array
        VaccineListModel *vaccineModel = [VaccineListModel sharedModel];
        self.vaccineList = [NSArray arrayWithArray:vaccineModel.vaccineList];
        
    }
    
    return self;
}

@end
