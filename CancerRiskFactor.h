//
//  CancerRiskFactor.h
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CancerRiskFactor : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *cancerList;

@end
