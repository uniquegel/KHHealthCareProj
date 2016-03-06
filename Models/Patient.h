//
//  Patient.h
//  KHHealthCareProj
//
//  Created by Ke Luo on 3/1/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vaccine.h"

@interface Patient : NSObject

// info
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSNumber *heightInch;
@property (nonatomic, strong) NSNumber *heightFeet;
@property (nonatomic, strong) NSNumber *weight;

// lists
@property (nonatomic, strong) NSArray *vaccineList;
@property (nonatomic, strong) NSArray *cancerList;

// singleton
+(instancetype)sharedModel;

@end
