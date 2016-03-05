//
//  CancerRiskFactor.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "CancerRiskFactor.h"
#import "CancerListModel.h"

@implementation CancerRiskFactor

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        // instantiate array
        CancerListModel *cancerModel = [CancerListModel sharedModel];
        self.cancerList = [NSArray arrayWithArray:cancerModel.cancerList];
        
    }
    
    return self;
}

@end
