//
//  KHBasicQuestionViewController.h
//  KHHealthCareProj
//
//  Created by Ryan Lu on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHHomePageViewController.h"

@interface KHBasicQuestionViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTF;
@property (weak, nonatomic) IBOutlet UIPickerView *ethnicityPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *maleButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *femaleButtonOutlet;
@property ScreeningType screeningType;

- (IBAction)isMaleButton:(id)sender;
- (IBAction)isFemaleButton:(id)sender;
- (IBAction)datePickerAction:(id)sender;
- (IBAction)startQuestionButtonAction:(id)sender;


@end
