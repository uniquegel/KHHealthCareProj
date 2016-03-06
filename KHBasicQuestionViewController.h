//
//  KHBasicQuestionViewController.h
//  KHHealthCareProj
//
//  Created by Ryan Lu on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHBasicQuestionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTF;
@property (weak, nonatomic) IBOutlet UIPickerView *ethnicityPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)isMaleButton:(id)sender;
- (IBAction)isFemaleButton:(id)sender;


@end