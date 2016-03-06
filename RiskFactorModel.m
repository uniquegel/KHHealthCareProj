//
//  RiskFactorModel.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "RiskFactorModel.h"

@implementation RiskFactorModel


-(instancetype)init {
    
    self = [super init];
    
    if (self) {
    
        // initialize riskFactorList by pulling from server
        
        
    }
    
    return self;
    
}

+(instancetype)sharedModel {
    
    static RiskFactorModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
    
}

@end
