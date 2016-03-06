//
//  CancerListModel.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "CancerListModel.h"

@implementation CancerListModel

-(instancetype)init {
    
    self = [super init];
    
    if (self) {
        // initialize cancer array by pulling from server
        
    }
    
    return self;
    
}

+(instancetype)sharedModel {
    
    static CancerListModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
    
}


@end
