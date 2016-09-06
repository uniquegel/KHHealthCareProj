//
//  KHGeneralScreening.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 7/22/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHGeneralScreening.h"

@implementation KHGeneralScreening

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
