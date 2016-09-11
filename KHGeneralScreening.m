//
//  KHGeneralScreening.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 7/22/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHGeneralScreening.h"

@implementation KHGeneralScreening

- (instancetype)initWithName:(NSString *)name andValue:(NSString *)value andID:(NSString *)ID andInfo:(NSString *)info andCategory:(NSString *)cate {
	self = [super init];
	
	if (self) {
		
		self.name = name;
		self.ID = ID;
		self.info = info;
		self.category = cate;
		self.value = value;
		
	}
	return self;
}


-(instancetype)initWithName:(NSString *)newName andStatus:(Status)newStatus {
    
    self = [super init];
    
    if (self) {
        
        self.name = newName;
        self->status = newStatus;
        
    }
    
    return self;
    
}

@end
