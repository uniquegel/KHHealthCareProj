//
//  Vaccine.m
//  KHHealthCareProj
//
//  Created by Ke Luo on 3/1/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHVaccine.h"
#import "KHRiskFactorManager.h"

@implementation KHVaccine

-(instancetype)initWithName:(NSString *)newName {
    
    self = [super init];
    
    if (self) {
        
        self.name = newName;
        
        self->status = White;

    }
    
    return self;
    
}

-(instancetype)initWithName:(NSString *)newName andStatus:(Status)newStatus {
    
    self = [super init];
    
    if (self) {
        
        self.name = newName;
        self->status = newStatus;
        
    }
    
    return self;
    
}

@end
