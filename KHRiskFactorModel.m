//
//  RiskFactorModel.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHRiskFactorModel.h"
#import "KHVaccineRiskFactor.h"
#import "KHCancerRiskFactor.h"
#import "KHvaccine.h"
#import "KHCancer.h"
#import "KHRiskFactorManager.h"
#import <Firebase/Firebase.h>
@import Firebase;

@interface KHRiskFactorModel ()
@property NSDictionary *dict;
@property NSMutableArray *cancerAgeRFKeyArray;
@property NSMutableArray *vaccineAgeRFKeyArray;
@property(strong, nonatomic) FIRDatabaseReference *ref;

@end
@implementation KHRiskFactorModel



- (instancetype)init {
    NSLog(@"shared RFModel in INIT");
    self = [super init];
    
    if (self) {
        
        // initialize riskFactorList by pulling from server
        
        
        self.ref = [[FIRDatabase database] reference];
        
        
        [_ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
            
            
//            NSLog(@" json: %@", snapshot.value);
            _dict =[[NSDictionary alloc] initWithDictionary: snapshot.value];
            
            _AllRFListForVaccine = [[NSMutableArray alloc] init];
            _AllRFListForCancer = [[NSMutableArray alloc] init];
            _vaccineAgeRFKeyArray = [[NSMutableArray alloc] init];
            _cancerAgeRFKeyArray = [[NSMutableArray alloc] init];
            
            
            
            
            //Vaccine Risk factors
            //Getting categories
            NSMutableDictionary *dictForCateKeys = [[NSMutableDictionary alloc] init];
            dictForCateKeys = _dict[@"Vaccine"][@"RiskFactors"];
            NSArray *arrayForAllCateKeys = [[NSArray alloc] initWithArray:dictForCateKeys.allKeys];
            
            
//            NSLog(@"Getting vaccine categories!: %@", dictForCateKeys);
            
            //For Each Catagory:
            for (int k = 0; k< arrayForAllCateKeys.count; k++) {
                
                //getting all risk factors under this category
                //                NSLog(@"Getting all rf under cate 1!");
                
                NSMutableDictionary *dictForAllRFUnderOneCategory = [[NSMutableDictionary alloc] init];
                dictForAllRFUnderOneCategory = _dict[@"Vaccine"][@"RiskFactors"][arrayForAllCateKeys[k]];
                
                //FIXIT: added this
//                NSLog(@"dict for all vaccine rf under one cate: %@", dictForAllRFUnderOneCategory);
                
                NSArray *RFKeysForOneCategoryArray = [[NSArray alloc] init];
                RFKeysForOneCategoryArray = dictForAllRFUnderOneCategory.allKeys;
                
                //For each Risk Factor under this category
                for (int i =0; i<RFKeysForOneCategoryArray.count; i++) {
                    if ([arrayForAllCateKeys[k] isEqualToString:@"Age"]) {
                        _vaccineAgeRFKeyArray = [RFKeysForOneCategoryArray mutableCopy];
                    }
                    //instantiate risk factor then add to list
                    //                    NSLog(@"instantiate a risk factor 1!");
                    KHVaccineRiskFactor *rf= [[KHVaccineRiskFactor alloc] initWithName:RFKeysForOneCategoryArray[i] andType:arrayForAllCateKeys[k]];
                    rf.vaccineList = [[NSMutableArray alloc] init];
                    
                    //                    NSLog(@"instantiate a risk factor 2!");
                    
                    //add per risk factor list of vaccines
                    NSDictionary *perRFVaccinesDict = [[NSDictionary alloc] init];
                    perRFVaccinesDict = _dict[@"Vaccine"][@"RiskFactors"][arrayForAllCateKeys[k]][RFKeysForOneCategoryArray[i]][@"Vaccines"];
                    NSArray *perRFAllValuesArray = [perRFVaccinesDict allKeys];
                    //                    NSLog(@"just got all vaccines under risk factor!");
                    
                    for (int l = 0; l<perRFAllValuesArray.count; l++) {
                        //getting all vaccines under risk factor
//                        NSLog(@"getting all vaccines and status!! %@", [perRFVaccinesDict[perRFAllValuesArray[l]] objectForKey:@"Value"]);
                        
                        if ([[perRFVaccinesDict[perRFAllValuesArray[l]] objectForKey:@"Value"] isEqualToString:@"N"]) {
                            KHVaccine *vaccine = [[KHVaccine alloc] initWithName:perRFAllValuesArray[l] andStatus:White];
                            //                            NSLog(@"ABOUT TO add to array! %@", vaccine.name);
                            [rf.vaccineList addObject:vaccine];
                        }
                        else if([[perRFVaccinesDict[perRFAllValuesArray[l]] objectForKey:@"Value"] isEqualToString:@"Y"]){
                            KHVaccine *vaccine = [[KHVaccine alloc] initWithName:perRFAllValuesArray[l] andStatus:Yellow];
                            //                            NSLog(@"ABOUT TO add to array! %@", vaccine.name);
                            [rf.vaccineList addObject:vaccine];
                        }
                        else if([[perRFVaccinesDict[perRFAllValuesArray[l]] objectForKey:@"Value"] isEqualToString:@"G"]){
                            KHVaccine *vaccine = [[KHVaccine alloc] initWithName:perRFAllValuesArray[l] andStatus:Green];
                            //                            NSLog(@"ABOUT TO add to array! %@", vaccine.name);
                            [rf.vaccineList addObject:vaccine];
                        }
                        else if([[perRFVaccinesDict[perRFAllValuesArray[l]] objectForKey:@"Value"] isEqualToString:@"R"]){
                            KHVaccine *vaccine = [[KHVaccine alloc] initWithName:perRFAllValuesArray[l] andStatus:Red];
                            //                            NSLog(@"ABOUT TO add to array! %@", vaccine.name);
                            [rf.vaccineList addObject:vaccine];
                        }
                        else if([[perRFVaccinesDict[perRFAllValuesArray[l]] objectForKey:@"Value"] isEqualToString:@"B"]){
                            KHVaccine *vaccine = [[KHVaccine alloc] initWithName:perRFAllValuesArray[l] andStatus:Blue];
                            //                            NSLog(@"ABOUT TO add to array! %@", vaccine.name);
                            [rf.vaccineList addObject:vaccine];
                        }
                        
                        
                        
                        
                    }
                    
                    
                    [_AllRFListForVaccine addObject:rf];
//                    NSLog(@"done adding rf to RF list for vaccine!");
                    
                }
                
                
            }
            
            
            
            //CANCER
            
            //Getting categories
            NSMutableDictionary *dictForCancerCateKeys = [[NSMutableDictionary alloc] init];
            dictForCancerCateKeys = _dict[@"Cancer"][@"RiskFactors"];
            NSArray *arrayForAllCancerCateKeys = [[NSArray alloc] initWithArray:dictForCancerCateKeys.allKeys];
            
            
//            NSLog(@"all cate keys: %@", arrayForAllCancerCateKeys);
//            NSLog(@"trial print 1: %@", _dict[@"Cancer"][@"RiskFactors"][arrayForAllCancerCateKeys[1]]);
//            NSLog(@"trial print 2: %@", _dict[@"Cancer"][@"RiskFactors"][arrayForAllCancerCateKeys[2]]);
//            NSLog(@"Getting Cancer RF categories!: %@", dictForCancerCateKeys);
            
            for (int k = 0; k< arrayForAllCancerCateKeys.count; k++) {
                //getting all risk factors under this category
                //                NSLog(@"Getting all rf under cate 1!");
                
                NSMutableDictionary *dictForAllCancerRFUnderOneCategory = [[NSMutableDictionary alloc] init];
                dictForAllCancerRFUnderOneCategory = _dict[@"Cancer"][@"RiskFactors"][arrayForAllCancerCateKeys[k]];
                
                // !!!: added
//                NSLog(@"dict for all can under one cate: %@", dictForAllCancerRFUnderOneCategory);
                
                NSArray *CancerRFKeysForOneCategoryArray = [[NSArray alloc] init];
                CancerRFKeysForOneCategoryArray = dictForAllCancerRFUnderOneCategory.allKeys;
                
                //                NSLog(@"Getting all rf under cate 2!");
                for (int i =0; i<CancerRFKeysForOneCategoryArray.count; i++) {
                    
                    if ([arrayForAllCateKeys[k] isEqualToString:@"Age"]) {
                        _cancerAgeRFKeyArray = [CancerRFKeysForOneCategoryArray mutableCopy];
                    }
                    
                    //instantiate risk factor then add to list
//                    NSLog(@"instantiate a risk factor 1!");
                    KHCancerRiskFactor *rf= [[KHCancerRiskFactor alloc] initWithName:CancerRFKeysForOneCategoryArray[i] andType:arrayForAllCancerCateKeys[k]];
                    
                    
                    //TODO
                    rf.cancerList = [[NSMutableArray alloc] init];
                    
                    //                    NSLog(@"instantiate a risk factor 2!");
                    //add per risk factor list of vaccines
                    NSDictionary *perRFCancerDict = [[NSDictionary alloc] init];
                    perRFCancerDict = _dict[@"Cancer"][@"RiskFactors"][arrayForAllCancerCateKeys[k]][CancerRFKeysForOneCategoryArray[i]][@"Cancers"];
//                    NSLog(@"perRFCAncerDict: %@", perRFCancerDict);
//                    NSLog(@"perRFCAncerDict count: %lu", (unsigned long)perRFCancerDict.count);
                    NSArray *perCancerRFAllKeyArray = [perRFCancerDict allKeys];
//                                        NSLog(@"just got all vaccines under risk factor!");
                    
                    for (int l = 0; l<perRFCancerDict.count; l++) {
//                        getting all vaccines under risk factor
//                        NSLog(@"getting all vaccines and status!! For: %@, with value: %@",perCancerRFAllKeyArray[l] , [perRFCancerDict[perCancerRFAllKeyArray[l]] objectForKey:@"Value"]);
                        
                        if ([[perRFCancerDict[perCancerRFAllKeyArray[l]] objectForKey:@"Value"] isEqualToString:@"N"]) {
                            KHCancer *cancer = [[KHCancer alloc] initWithName:perCancerRFAllKeyArray[l] andStatus:White];
//                            NSLog(@"ABOUT TO add to array! %@", cancer.name);
                            [rf.cancerList addObject:cancer];
                        }
                        else if([[perRFCancerDict[perCancerRFAllKeyArray[l]] objectForKey:@"Value"] isEqualToString:@"Y"]){
                            KHCancer *cancer = [[KHCancer alloc] initWithName:perCancerRFAllKeyArray[l] andStatus:Yellow];
//                            NSLog(@"ABOUT TO add to array! %@", cancer.name);
                            [rf.cancerList addObject:cancer];
                        }
                        else if([[perRFCancerDict[perCancerRFAllKeyArray[l]] objectForKey:@"Value"] isEqualToString:@"G"]){
                            KHCancer *cancer = [[KHCancer alloc] initWithName:perCancerRFAllKeyArray[l] andStatus:Green];
//                            NSLog(@"ABOUT TO add to array! %@", cancer.name);
                            [rf.cancerList addObject:cancer];
                        }
                        else if([[perRFCancerDict[perCancerRFAllKeyArray[l]] objectForKey:@"Value"] isEqualToString:@"R"]){
                            KHCancer *cancer = [[KHCancer alloc] initWithName:perCancerRFAllKeyArray[l] andStatus:Red];
//                            NSLog(@"ABOUT TO add to array! %@", cancer.name);
                            [rf.cancerList addObject:cancer];
                        }
                        else if([[perRFCancerDict[perCancerRFAllKeyArray[l]] objectForKey:@"Value"] isEqualToString:@"B"]){
                            KHCancer *cancer = [[KHCancer alloc] initWithName:perCancerRFAllKeyArray[l] andStatus:Blue];
//                            NSLog(@"ABOUT TO add to array! %@", cancer.name);
                            [rf.cancerList addObject:cancer];
                        }
                        
                        
                        
                    }
                    
                    
                    [_AllRFListForCancer addObject:rf];
//                    NSLog(@"done adding rf to RF list for cancer!");
                    
                }
            }
        
        }];
        
    }
    
    return self;
    
}



+(instancetype)sharedModel {
    
    static KHRiskFactorModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
    
}

@end
