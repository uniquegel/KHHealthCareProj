//
//  KHRiskFactorManager.h
//  KHHealthCareProj
//
//  Created by Tyler Lu on 7/22/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import FirebaseDatabase;

@interface KHRiskFactorManager : NSObject

@property (strong, nonatomic) NSArray *allRiskFactors;
@property (strong, nonatomic) NSArray *ageRiskFactors;
@property (strong, nonatomic) NSArray *MDRiskFactors;
@property (strong, nonatomic) NSArray *EFLRiskFactors;

@property (strong, nonatomic) NSDictionary *RFCategories;
@property (strong, nonatomic) NSDictionary *RFSubCategor;


+ (id) sharedManager;
- (void) downloadAllRiskFactors;

@end