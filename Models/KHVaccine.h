//
//  Vaccine.h
//  KHHealthCareProj
//
//  Created by Ke Luo on 3/1/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHRiskFactorManager.h"



@interface KHVaccine : NSObject{
    @public Status status;
}

@property (nonatomic, strong) NSString *name;

// methods
-(instancetype)initWithName:(NSString *)newName;
-(instancetype)initWithName:(NSString *)newName andStatus:(Status)newStatus;


@end
