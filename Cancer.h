//
//  Cancer.h
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum status {
    Indicated,
    Recommended,
    Contraindicated,
    Ask
} Status;

@interface Cancer : NSObject

@property (nonatomic, strong) NSString *name;

@end
