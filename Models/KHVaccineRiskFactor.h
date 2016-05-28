//
//  RiskFactor.h
//  KHHealthCareProj
//
//  Created by Ke Luo on 3/1/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHVaccineRiskFactor : NSObject

// risk factor info
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;

// risk factor status
@property (nonatomic, assign) BOOL isActive;

// vaccine list
@property (nonatomic, strong) NSMutableArray *vaccineList;

// methods
-(instancetype)initWithName:(NSString *)newName andType:(NSString *)newType;

@end
	