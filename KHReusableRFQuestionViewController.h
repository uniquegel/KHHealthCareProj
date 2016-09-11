//
//  KHReusableRFQuestionViewController.h
//  KHHealthCareProj
//
//  Created by Ryan Lu on 9/10/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHPatient.h"

@interface KHReusableRFQuestionViewController :  UIViewController <UITableViewDelegate, UITableViewDataSource>
@property ScreeningType currentScreeningType;


- (instancetype)initControllerForScreeningType:(ScreeningType)type andScreeningStep:(NSInteger)step;
@end
