//
//  KHRiskFactor.m
//  KHHealthCareProj
//
//  Created by Tyler Lu on 8/25/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHRiskFactor.h"

@implementation KHRiskFactor

- (instancetype)initWithName:(NSString *)name category:(NSString *)category ID:(NSString *)ID subCategory:(NSString *)subcate generalList:(NSDictionary *)generalList vaccineList:(NSDictionary *)vaccineList cancerList:(NSDictionary *)cancerList {
	
	self = [super init];
	if (self) {
		self.name = name;
		self.category = category;
		self.ID = ID;
		self.subCategory = subcate;
		self.generalList = generalList;
		self.vaccineList = vaccineList;
		self.cancerList = cancerList;
		
		if (vaccineList != nil)
			self.isInVaccine = YES;
		if (generalList != nil)
			self.isInGeneral = YES;
		if (cancerList != nil)
			self.isInCancer = YES;
		self.isActive = NO;
	}
	return self;
}

@end


