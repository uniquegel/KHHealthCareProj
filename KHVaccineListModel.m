//
//  VaccineListModel.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHVaccineListModel.h"
#import "KHVaccine.h"

@implementation KHVaccineListModel


-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        // initialize vaccine array by pulling from server
        
        // TEMPORARY - initialize with dummy data
        NSMutableArray *tempList = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < 5; i++) {
            KHVaccine *vaccine = [[KHVaccine alloc] initWithName:@"New Vaccine" andStatus:Yellow];
            [tempList addObject:vaccine];
        }
        self.vaccineList = tempList;
    }
    
    return self;
    
}

+(instancetype)sharedModel {
    
    static KHVaccineListModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{        
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
    
}

@end
