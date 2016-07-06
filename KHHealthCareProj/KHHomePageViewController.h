//
//  KHHomePageViewController.h
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHHomePageViewController : UIViewController
typedef enum ScreeningType : NSUInteger {
    kScreenTypeVaccine,
    kScreenTypeCancer,
    kScreenTypeGeneral
} ScreeningType;

@property (nonatomic, strong) NSArray *vaccineList;
@property (nonatomic, readwrite) ScreeningType scrType;
- (IBAction)vacScreenButtonAction:(id)sender;


@end
