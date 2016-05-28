//
//  RiskFactorModel.h
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHRiskFactorModel : NSObject

@property (nonatomic, strong) NSMutableArray *vaccineAgeRiskFactorList;
@property (nonatomic, strong) NSMutableArray *vaccineMedRiskFactorList;
@property (nonatomic, strong) NSMutableArray *vaccineOccuRiskFactorList;

@property (nonatomic, strong) NSMutableArray *AllRFListForVaccine;
@property (nonatomic, strong) NSMutableArray *AllRFListForCancer;

@property (nonatomic, strong) NSArray *perRiskFactorVaccineList;
@property (nonatomic, strong) NSArray *cancerRiskFactorList;

- (instancetype) init;
- (void) initWithDict;

+(instancetype) sharedModel;

@end
