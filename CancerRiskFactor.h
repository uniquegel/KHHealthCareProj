//
//  CancerRiskFactor.h
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CancerRiskFactor : NSObject

// risk factor info
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;

// risk factor status
@property (nonatomic, assign) BOOL isActive;

// cancer list
@property (nonatomic, strong) NSArray *cancerList;

@end
