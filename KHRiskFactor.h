//
//  KHRiskFactor.h
//  KHHealthCareProj
//
//  Created by Tyler Lu on 8/25/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHRiskFactor : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* category;
@property (nonatomic, strong) NSString* ID;
@property (nonatomic, strong) NSString* subCategory;

@property (nonatomic, strong) NSDictionary* generalList;
@property (nonatomic, strong) NSDictionary* cancerList;
@property (nonatomic, strong) NSDictionary* vaccineList;

@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL isInVaccine;
@property (nonatomic) BOOL isInCancer;
@property (nonatomic) BOOL isInGeneral;

- (instancetype)initWithName:(NSString *)name category:(NSString *)category ID:(NSString *)ID subCategory:(NSString *)subcate generalList:(NSDictionary *)generalList vaccineList:(NSDictionary *)vaccineList cancerList:(NSDictionary *)cancerList;

@end


