//
//  Vaccine.h
//  KHHealthCareProj
//
//  Created by Ke Luo on 3/1/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Contraindicated,
    Ask,
    Indicated,
    Recommended
} Status;

@interface Vaccine : NSObject{
    @public Status status;
}

@property (nonatomic, strong) NSString *name;


@end
