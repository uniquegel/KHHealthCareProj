//
//  Patient.h
//  KHHealthCareProj
//
//  Created by Ke Luo on 3/1/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHVaccine.h"

@interface KHPatient : NSObject{
    @public NSInteger numRiskFactors;
}


// info
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *gender;
@property  NSInteger age;
@property (nonatomic, strong) NSDate *birthday;
@property (nonatomic, strong) NSString *ethnicty;
@property (nonatomic, strong) NSNumber *heightInch;
@property (nonatomic, strong) NSNumber *heightFeet;
@property (nonatomic, strong) NSNumber *weight;


// lists
@property (nonatomic, strong) NSMutableArray *vaccineList;
@property (nonatomic, strong) NSMutableArray *cancerList;
@property (nonatomic, strong) NSArray *riskFactorList;


// singleton
+(instancetype)sharedModel;

@end
