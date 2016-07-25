//
//  KHRiskFactorManager.m
//  KHHealthCareProj
//
//  Created by Tyler Lu on 7/22/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHRiskFactorManager.h"
#import "KHHealthCareProj-Swift.h"
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
		
		[rfDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
			NSDictionary *rfValueDict = [rfDict objectForKey:key];
			NSLog(@"%@", rfValueDict);
			
			NSString *name = [rfValueDict objectForKey:@"name"];
			NSString *ID = [rfValueDict objectForKey:@"id"];
			NSString *categoryIndex = rfValueDict[@"category"];
			__block NSMutableString *category;
			
			[cateDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
				if ([categoryIndex isEqualToString: (NSString *)key]) {
					category = [NSMutableString stringWithString: cateDict[@"key"]] ;
					
				}
			}];
			
			NSString *subcatIndex = rfValueDict[@"sub-category"];
			__block NSMutableString *subCate;
			
			[subCateDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
				if ([subcatIndex isEqualToString:(NSString *)key]) {
					NSDictionary *subCateValueDict = subCateDict[key];
					subCate = subCateValueDict[@"name"];
				}
			}];
			
			//general list
			NSDictionary *general_list = [NSDictionary dictionary];
			if (rfValueDict[@"general_list"] != nil) {
				NSDictionary *list = rfValueDict[@"general-list"];
				
				general_list = [NSDictionary dictionaryWithDictionary:[self parseListDictWithDict:list  andListDefDict:gsDict]];
			}
			NSLog(@"general list for rf: %@ list: %@", name, general_list);
			
			//vaccine list
			NSDictionary *vaccine_list;
			NSDictionary *list = rfValueDict[@"vaccine-list"];
			
			if (list != nil) {
				vaccine_list = [self parseListDictWithDict:list andListDefDict:gsDict];
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