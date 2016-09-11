//
//  Cancer.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHCancer.h"

@implementation KHCancer

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
