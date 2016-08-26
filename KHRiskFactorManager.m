//
//  KHRiskFactorManager.m
//  KHHealthCareProj
//
//  Created by Tyler Lu on 7/22/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHRiskFactorManager.h"
#import "KHHealthCareProj-Swift.h"
#import "KHRiskFactor.h"

@implementation KHRiskFactorManager

+ (id)sharedManager {
	static KHRiskFactorManager *sharedMyManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedMyManager = [[self alloc] init];
	});
	return sharedMyManager;
}

- (void)downloadAllRiskFactors {
	
	//declare the mutable copies of the risk factors
	NSMutableArray *allRiskFactorsCopy = [[NSMutableArray alloc] init];
	NSMutableArray *ageRiskFactorsCopy = [[NSMutableArray alloc] init];
	NSMutableArray *EFLRiskFactorsCopy = [[NSMutableArray alloc] init];
	NSMutableArray *MCRiskFactorsCopy = [[NSMutableArray alloc] init];
	
	NSMutableArray *generalRiskFactorsCopy = [[NSMutableArray alloc] init];
	NSMutableArray *cancerRiskFactorsCopy = [[NSMutableArray alloc] init];
	NSMutableArray *vaccineRiskFactorsCopy = [[NSMutableArray alloc] init];
	
	FIRDatabaseReference *ref = [[FIRDatabase database] reference];
	
	
	[ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
		NSDictionary *base = snapshot.value;

		NSDictionary *rfDict = [base objectForKey: @"riskfactors-general"];
		NSDictionary *cateDict = [base objectForKey:@"rf-categories"];
		NSDictionary *subCateDict = [base objectForKey:@"rf-sub-categories"];
		NSDictionary *gsDict = [base objectForKey:@"general screening"];
		NSDictionary *gsCateDict = [base objectForKey:@"general screening-categories"];
		
//		NSLog(@"%@", rfDict);
//		NSLog(@"%@", cateDict);
//		NSLog(@"%@", subCateDict);
//		NSLog(@"%@", gsDict);
		
		//Parse the risk factors 
		[rfDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
			NSDictionary *rfValueDict = [rfDict objectForKey:key];
//			NSLog(@"%@", rfValueDict);
			
			NSString *name = [rfValueDict objectForKey:@"name"];
			NSString *ID = [rfValueDict objectForKey:@"id"];
			NSString *categoryIndex = rfValueDict[@"category"];
			
			__block NSMutableString *category;
			
			//Find the category names for this risk factor
			[cateDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
				if ([categoryIndex isEqualToString: (NSString *)key]) {
					category = [NSMutableString stringWithString: cateDict[key]] ;
					
				}
			}];
			
			
			//Find the sub-category name
			NSString *subcatIndex = rfValueDict[@"sub-category"];
			__block NSMutableString *subCate;
			
			[subCateDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
				if ([subcatIndex isEqualToString:(NSString *)key]) {
					NSDictionary *subCateValueDict = subCateDict[key];
					subCate = subCateValueDict[@"name"];
				}
			}];
			
//			NSLog(@"%@   %@", category, subCate);
			
			//general list
			NSDictionary *general_list = [NSDictionary dictionary];
			if (rfValueDict[@"general_list"] != nil) {
				NSDictionary *list = rfValueDict[@"general-list"];
				
				general_list = [NSDictionary dictionaryWithDictionary:[self parseListDictWithDict:list  andListDefDict:gsDict]];
			}
//			NSLog(@"general list for rf: %@ list: %@", name, general_list);
			
			//vaccine list
			NSDictionary *vaccine_list;
			NSDictionary *list = rfValueDict[@"vaccine-list"];
			
			if (list != nil) {
				vaccine_list = [self parseListDictWithDict:list andListDefDict:gsDict];
			}
			
			//cancer list
			NSDictionary *cancer_list;
			list = rfValueDict[@"cancer-list"];
			if (list != nil) {
				cancer_list = [self parseListDictWithDict:list andListDefDict:gsDict];
			}
			
			//init risk factor object
			KHRiskFactor* riskfactor = [[KHRiskFactor alloc] initWithName:name category:category ID:ID subCategory:subCate generalList:general_list vaccineList:vaccine_list cancerList:cancer_list];
			
			//All Riskfactors mutable copy
			[allRiskFactorsCopy addObject:riskfactor];
			
			if ([category isEqualToString:@"Age"])										//Age riskfactor mutable copy
				[ageRiskFactorsCopy addObject:riskfactor];
			else if ([category isEqualToString:@"Medical Condition"])					//MD riskfactor mutable copy
				[MCRiskFactorsCopy addObject:riskfactor];
			else if ([category isEqualToString:@"Ethnicity, Family, Lifestyle"])		//EFL risk factor mutable copy
				[EFLRiskFactorsCopy addObject:riskfactor];
			
			if (riskfactor.generalList != nil)
				[generalRiskFactorsCopy addObject:riskfactor];
			if (riskfactor.vaccineList != nil)
				[vaccineRiskFactorsCopy addObject:riskfactor];
			if (riskfactor.cancerList != nil)
				[cancerRiskFactorsCopy addObject:riskfactor];
			
//			NSLog(@"%@", riskfactor.name);
//			NSLog(@"%lu %lu", allRiskFactorsCopy.count, rfDict.count);
			
			//after all the risk factors are parsed save them into riskfactors
			if (allRiskFactorsCopy.count >= rfDict.count) {
				self.allRiskFactors = [NSArray arrayWithArray:allRiskFactorsCopy];
				self.EFLRiskFactors = [NSArray arrayWithArray:EFLRiskFactorsCopy];
				self.MedicalCondRiskFactors = [NSArray arrayWithArray:MCRiskFactorsCopy];
				
				self.generalRiskFactors = [NSArray arrayWithArray:generalRiskFactorsCopy];
				self.vaccineRiskFactors = [NSArray arrayWithArray:vaccineRiskFactorsCopy];
				self.cancerRiskFactors = [NSArray arrayWithArray:cancerRiskFactorsCopy];
				
//				NSLog(@"%lu", self.EFLRiskFactors.count);
			}
		}];
	}];
	
}

- (NSDictionary*) parseListDictWithDict:(NSDictionary*)valueDict andListDefDict:(NSDictionary *)listDefDict {
	NSMutableDictionary *listDict = [NSMutableDictionary dictionary];
	for (NSString *key in valueDict) {
		NSDictionary *dict = valueDict[key];
		if (dict == nil || dict[@"value"] == nil) {
			continue;
		}
		
		listDict[key] = dict[key];
	}
	
	return listDict;
}



@end
