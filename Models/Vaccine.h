//
//  Vaccine.h
//  KHHealthCareProj
//
//  Created by Ke Luo on 3/1/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum status {
    Indicated,
    Recommended,
    Contraindicated,
    Ask
} Status;

@interface Vaccine : NSObject

@property (nonatomic, strong) NSString *name;



@end
