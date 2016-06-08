//
//  MaterialTextField.m
//  KHHealthCareProj
//
//  Created by Tyler Lu on 6/7/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "MaterialTextField.h"
#import <QuartzCore/QuartzCore.h>

@implementation MaterialTextField

-(void)awakeFromNib {
	self.layer.cornerRadius = 3.0;
	self.clipsToBounds = YES;
	self.layer.masksToBounds = NO;
	self.layer.shadowColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:0.8].CGColor;
	self.layer.shadowOpacity = 0.6;
	self.layer.shadowRadius = 3.0;
	self.layer.shadowOffset = CGSizeMake(0.0, 1.0);
}

@end
