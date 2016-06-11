//
//  MaterialView.m
//  KHHealthCareProj
//
//  Created by Tyler Lu on 6/7/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "MaterialView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MaterialView

-(void)awakeFromNib {
	[super awakeFromNib];
	[self setupView];
}

- (void)prepareForInterfaceBuilder {
	[super prepareForInterfaceBuilder];
	[self setupView];

}

- (void)setupView {
	self.layer.cornerRadius = 4.0;
	self.clipsToBounds = YES;
	self.layer.masksToBounds = NO;
	self.layer.shadowColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:0.8].CGColor;
	self.layer.shadowOpacity = 0.8;
	self.layer.shadowRadius = 5.0;
	self.layer.shadowOffset = CGSizeMake(0.0, 4.0);
}

@end
