//
//  CancerRiskFactor.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHCancerRiskFactor.h"
#import "KHCancerListModel.h"

@implementation KHCancerRiskFactor

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        // instantiate array
        KHCancerListModel *cancerModel = [KHCancerListModel sharedModel];
        self.cancerList = [NSArray arrayWithArray:cancerModel.cancerList];
        
    }
    
    return self;
}

@end
