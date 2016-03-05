//
//  CancerListModel.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "CancerListModel.h"

@implementation CancerListModel


+(instancetype)sharedModel {
    
    static CancerListModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        
        // initialize cancer array by pulling from server
        
        
        
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
    
}


@end
