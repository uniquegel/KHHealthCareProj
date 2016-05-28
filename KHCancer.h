//
//  Cancer.h
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHVaccine.h"

@interface KHCancer : NSObject{
@public Status status;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic, strong) NSString *frequency;

// methods
-(instancetype)initWithName:(NSString *)newName;
-(instancetype)initWithName:(NSString *)newName andStatus:(Status)newStatus;

@end
