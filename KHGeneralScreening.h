//
//  KHGeneralScreening.h
//  KHHealthCareProj
//
//  Created by Ryan Lu on 7/22/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHRiskFactorManager.h"

@interface KHGeneralScreening : NSObject{
    @public Status status;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic, strong) NSString *frequency;

// methods
-(instancetype)initWithName:(NSString *)newName;
-(instancetype)initWithName:(NSString *)newName andStatus:(Status)newStatus;

@end
