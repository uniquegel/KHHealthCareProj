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
#import <Firebase/Firebase.h>

@interface KHRiskFactorModel ()
@property NSDictionary *dict;
@end
@implementation KHRiskFactorModel


- (instancetype)init {
    NSLog(@"shared RFModel in INIT");
    self = [super init];
    
    if (self) {
        
        // initialize riskFactorList by pulling from server
        
        Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://pocdoc.firebaseio.com"];
        [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            
            
            //        NSLog(@" json: %@", snapshot.value);
            _dict =[[NSDictionary alloc] initWithDictionary: snapshot.value];
            
            _AllRFListForVaccine = [[NSMutableArray alloc] init];
            
            
            //Vaccine Risk factors
            //Getting categories
            NSMutableDictionary *dictForCateKeys = [[NSMutableDictionary alloc] init];
            dictForCateKeys = _dict[@"RiskFactors"][@"RiskFactors"];
            NSArray *arrayForAllCateKeys = [[NSArray alloc] initWithArray:dictForCateKeys.allKeys];
            
            
            NSLog(@"Getting categories!");
            
            for (int k = 0; k< arrayForAllCateKeys.count; k++) {
                //getting all risk factors under this category
                //                NSLog(@"Getting all rf under cate 1!");
                
                NSMutableDictionary *dictForAllRFUnderOneCategory = [[NSMutableDictionary alloc] init];
                dictForAllRFUnderOneCategory = _dict[@"RiskFactors"][@"RiskFactors"][arrayForAllCateKeys[k]];
                NSArray *RFKeysForOneCategoryArray = [[NSArray alloc] init];
                RFKeysForOneCategoryArray = dictForAllRFUnderOneCategory.allKeys;
                
                //                NSLog(@"Getting all rf under cate 2!");
                for (int i =0; i<RFKeysForOneCategoryArray.count; i++) {
                    //instantiate risk factor then add to list
                    //                    NSLog(@"instantiate a risk factor 1!");
                    KHVaccineRiskFactor *rf= [[KHVaccineRiskFactor alloc] initWithName:RFKeysForOneCategoryArray[i] andType:arrayForAllCateKeys[k]];
                    rf.vaccineList = [[NSMutableArray alloc] init];
                    
                    //                    NSLog(@"instantiate a risk factor 2!");
                    
                    //add per risk factor list of vaccines
                    NSDictionary *perRFVaccinesDict = [[NSDictionary alloc] init];
                    perRFVaccinesDict = _dict[@"RiskFactors"][@"RiskFactors"][arrayForAllCateKeys[k]][RFKeysForOneCategoryArray[i]][@"Vaccines"];
                    NSArray *perRFAllValuesArray = [perRFVaccinesDict allKeys];
                    //                    NSLog(@"just got all vaccines under risk factor!");
                    
                    for (int l = 0; l<perRFAllValuesArray.count; l++) {
                        //getting all vaccines under risk factor
                        //                        NSLog(@"getting all vaccines and status!! %@", [perRFVaccinesDict[perRFAllValuesArray[l]] objectForKey:@"Value"]);
                        
                        if ([[perRFVaccinesDict[perRFAllValuesArray[l]] objectForKey:@"Value"] isEqualToString:@"N"]) {
                            KHVaccine *vaccine = [[KHVaccine alloc] initWithName:perRFAllValuesArray[l] andStatus:Nothing];
                            //                            NSLog(@"ABOUT TO add to array! %@", vaccine.name);
                            [rf.vaccineList addObject:vaccine];
                        }
                        else if([[perRFVaccinesDict[perRFAllValuesArray[l]] objectForKey:@"Value"] isEqualToString:@"Y"]){
                            KHVaccine *vaccine = [[KHVaccine alloc] initWithName:perRFAllValuesArray[l] andStatus:Indicated];
                            //                            NSLog(@"ABOUT TO add to array! %@", vaccine.name);
                            [rf.vaccineList addObject:vaccine];
                        }
                        else if([[perRFVaccinesDict[perRFAllValuesArray[l]] objectForKey:@"Value"] isEqualToString:@"G"]){
                            KHVaccine *vaccine = [[KHVaccine alloc] initWithName:perRFAllValuesArray[l] andStatus:Recommended];
                            //                            NSLog(@"ABOUT TO add to array! %@", vaccine.name);
                            [rf.vaccineList addObject:vaccine];
                        }
                        else if([[perRFVaccinesDict[perRFAllValuesArray[l]] objectForKey:@"Value"] isEqualToString:@"R"]){
                            KHVaccine *vaccine = [[KHVaccine alloc] initWithName:perRFAllValuesArray[l] andStatus:Contraindicated];
                            //                            NSLog(@"ABOUT TO add to array! %@", vaccine.name);
                            [rf.vaccineList addObject:vaccine];
                        }
                        
                        
                        
                    }
                    
                    
                    [_AllRFListForVaccine addObject:rf];
                    NSLog(@"done adding rf to list!");
                    
                }
                
                
            }
            
            
            
            //CANCER
        
            //Getting categories
            NSMutableDictionary *dictForCancerCateKeys = [[NSMutableDictionary alloc] init];
            dictForCancerCateKeys = _dict[@"Cancer"][@"RiskFactors"];
            NSArray *arrayForAllCancerCateKeys = [[NSArray alloc] initWithArray:dictForCateKeys.allKeys];
            
            
            NSLog(@"Getting categories!");
            
            for (int k = 0; k< arrayForAllCancerCateKeys.count; k++) {
                //getting all risk factors under this category
                //                NSLog(@"Getting all rf under cate 1!");
                
                NSMutableDictionary *dictForAllCancerRFUnderOneCategory = [[NSMutableDictionary alloc] init];
                dictForAllCancerRFUnderOneCategory = _dict[@"RiskFactors"][@"RiskFactors"][arrayForAllCancerCateKeys[k]];
                NSArray *CancerRFKeysForOneCategoryArray = [[NSArray alloc] init];
                CancerRFKeysForOneCategoryArray = dictForAllCancerRFUnderOneCategory.allKeys;
                
                //                NSLog(@"Getting all rf under cate 2!");
                for (int i =0; i<CancerRFKeysForOneCategoryArray.count; i++) {
                    //instantiate risk factor then add to list
                    //                    NSLog(@"instantiate a risk factor 1!");
                    KHCancerRiskFactor *rf= [[KHCancerRiskFactor alloc] initWithName:CancerRFKeysForOneCategoryArray[i] andType:arrayForAllCancerCateKeys[k]];


                    //TODO
                    rf.cancerList = [[NSMutableArray alloc] init];
                    
                    //                    NSLog(@"instantiate a risk factor 2!");
                    //add per risk factor list of vaccines
                    NSDictionary *perRFCancerDict = [[NSDictionary alloc] init];
                    perRFCancerDict = _dict[@"Cancer"][@"RiskFactors"][arrayForAllCancerCateKeys[k]][CancerRFKeysForOneCategoryArray[i]];
                    NSArray *perCancerRFAllKeyArray = [perRFCancerDict allKeys];
                    //                    NSLog(@"just got all vaccines under risk factor!");
                    
                    for (int l = 0; l<perRFCancerDict.count; l++) {
                        //getting all vaccines under risk factor
                        //                        NSLog(@"getting all vaccines and status!! %@", [perRFVaccinesDict[perRFAllValuesArray[l]] objectForKey:@"Value"]);
                        
                        if ([[perRFCancerDict[perCancerRFAllKeyArray[l]] objectForKey:@"Value"] isEqualToString:@"N"]) {
                            KHCancer *cancer = [[KHCancer alloc] initWithName:perCancerRFAllKeyArray[l] andStatus:Nothing];
                            //                            NSLog(@"ABOUT TO add to array! %@", vaccine.name);
                            [rf.cancerList addObject:cancer];
                        }
                        else if([[perRFCancerDict[perCancerRFAllKeyArray[l]] objectForKey:@"Value"] isEqualToString:@"Y"]){
                            KHCancer *cancer = [[KHCancer alloc] initWithName:perCancerRFAllKeyArray[l] andStatus:Indicated];
                            //                            NSLog(@"ABOUT TO add to array! %@", vaccine.name);
                            [rf.cancerList addObject:cancer];
                        }
                        else if([[perRFCancerDict[perCancerRFAllKeyArray[l]] objectForKey:@"Value"] isEqualToString:@"G"]){
                            KHCancer *cancer = [[KHCancer alloc] initWithName:perCancerRFAllKeyArray[l] andStatus:Recommended];
                            //                            NSLog(@"ABOUT TO add to array! %@", vaccine.name);
                            [rf.cancerList addObject:cancer];
                        }
                        else if([[perRFCancerDict[perCancerRFAllKeyArray[l]] objectForKey:@"Value"] isEqualToString:@"R"]){
                            KHCancer *cancer = [[KHCancer alloc] initWithName:perCancerRFAllKeyArray[l] andStatus:Contraindicated];
                            //                            NSLog(@"ABOUT TO add to array! %@", vaccine.name);
                            [rf.cancerList addObject:cancer];                        }
                        
                        
                        
                    }
                    
                    
                    [_AllRFListForCancer addObject:rf];
                    NSLog(@"done adding rf to Cancer list!");
                    
                }
            }
            //        NSLog(@" NEWDICT: %@", newDict);
            
            
            //            NSLog(@" test alkeys 1: %@", _vaccineAgeRiskFactorList);
            //            newDict = _dict[@"RiskFactors"][@"RiskFactors"][@"Occupational slush Lifestyle"];
            //            _vaccineOccuRiskFactorList = newDict.allKeys;
            ////            NSLog(@" test alkeys 2: %@", _vaccineOccuRiskFactorList);
            //            newDict = _dict[@"RiskFactors"][@"RiskFactors"][@"Medical Condition"];
            //            _vaccineMedRiskFactorList = newDict.allKeys;
            ////            NSLog(@" test alkeys 3: %@", _vaccineMedRiskFactorList);
            
            
            
            NSLog(@"ALL risk factors: %@", _AllRFListForVaccine);
            NSLog(@"Got dict from FIREBASE!");
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
