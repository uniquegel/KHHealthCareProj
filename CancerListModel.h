//
//  CancerListModel.h
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CancerListModel : NSObject

@property (nonatomic, strong) NSArray *cancerList;

+(instancetype) sharedModel;

@end
