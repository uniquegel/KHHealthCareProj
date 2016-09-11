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
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *category;

// methods
-(instancetype)initWithName:(NSString *)name andValue:(NSString *)value andID:(NSString *)ID andInfo:(NSString *)info andCategory:(NSString *)cate;
-(instancetype)initWithName:(NSString *)newName andStatus:(Status)newStatus;

@end
