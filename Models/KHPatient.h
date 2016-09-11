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
    @public
}


// info
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *gender;
@property  NSInteger age;
@property NSInteger numRiskFactors;
@property (nonatomic, strong) NSDate *birthday;
@property (nonatomic, strong) NSString *ethnicty;
@property (nonatomic, strong) NSNumber *heightInch;
@property (nonatomic, strong) NSNumber *heightFeet;
@property (nonatomic, strong) NSNumber *weight;
@property bool completedVaccineFlow;
@property bool completedCancerFlow;
@property bool completedGeneralFlow;
@property bool collectedBasicInfo;


// lists
@property (nonatomic, strong) NSMutableArray *vaccineList;
@property (nonatomic, strong) NSMutableArray *cancerList;
@property (nonatomic, strong) NSMutableDictionary *generalList;
@property (nonatomic, strong) NSArray *riskFactorList;


// singleton
+(instancetype)sharedModel;

@end
