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

- (instancetype)initWithName:(NSString *)newName andType:(NSString *)newType
{
    
    self = [super init];
    
    if (self) {
        
        self.name = newName;
        self.type = newType;
        self.isActive = NO;
        
        // instantiate array
        KHCancerListModel *cancerListModel = [KHCancerListModel sharedModel];
        self.cancerList = [NSArray arrayWithArray:cancerListModel.cancerList];
        
    }
    
    return self;
}

@end
