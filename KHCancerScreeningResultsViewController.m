


//  KHVaccinationScreeningResultsViewController.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHCancerScreeningResultsViewController.h"
#import "KHPatient.h"
#import "KHCancer.h"
#import "KHRiskFactorModel.h"
#import "KHCancerRiskFactor.h"
@interface KHCancerScreeningResultsViewController()
@property KHPatient *patient;
@property KHRiskFactorModel *rfModel;
@property NSMutableArray *indicatedVacArray;
@property NSMutableArray *contraindicatedVacArray;
@property NSMutableArray *consultPhyiscianVacArray;
@property KHCancer *cancer;
- (IBAction)backItemTapped:(id)sender;

@end



@implementation KHCancerScreeningResultsViewController


- (void)viewDidLoad {
    NSLog(@"cancer viewdidload");
    
    
    [super viewDidLoad];
    _patient = [KHPatient sharedModel];
//    _rfModel = [KHRiskFactorModel sharedModel];
    if (!_patient.completedCancerFlow) {
        [self.view setHidden:YES];
    }
    
    for (int i = 0; i<_rfModel.AllRFListForCancer.count; i++) {
        KHCancerRiskFactor *rf =_rfModel.AllRFListForCancer[i];
        if (rf.isActive == YES) {
            NSLog(@"AAA: active rf: %@", rf.name);
        }
        else if (rf.isActive == NO) {
            NSLog(@"III: Inavtive rf: %@", rf.name);
        }
    }
    
    
    _indicatedVacArray = [[NSMutableArray alloc] init];
    _consultPhyiscianVacArray = [[NSMutableArray alloc] init];
    _contraindicatedVacArray = [[NSMutableArray alloc] init];
    
    
    NSLog(@"ABOUT TO DIVIDE INTO CATE");
    NSLog(@"patient cancer count: %lu", _patient.cancerListArray.count);
    
    
    for (int i  =0; i< [_patient.cancerListArray count]; i++) {
        
        _cancer = _patient.cancerListArray[i];
        
        NSLog(@" cancer status: %u",  _cancer->status);
        //indicated
        if (_cancer->status == 2) {
            [_indicatedVacArray addObject:_cancer];
        }
        //contra indicated
        else if (_cancer->status == 0) {
            [_contraindicatedVacArray addObject:_cancer];
        }
        //consult
        else if (_cancer->status == 1) {
            [_consultPhyiscianVacArray addObject:_cancer];
        }
        
    }
    
    
    NSLog(@" ask Count: %lu ", (unsigned long)_consultPhyiscianVacArray.count);
    NSLog(@" contra Count: %lu /n", (unsigned long)_contraindicatedVacArray.count);
    NSLog(@" indic Count: %lu /n", (unsigned long)_indicatedVacArray.count);
}


- (void)viewDidAppear:(BOOL)animated {
 
    NSLog(@"cancer viewdidappear!");
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return _indicatedVacArray.count;
            break;
        }
        case 1:
            return _contraindicatedVacArray.count;
            break;
        case 2:
            return _consultPhyiscianVacArray.count;
            break;
        default:
            return 0;
            break;
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSLog(@"about to get header");
    switch (section) {
        case 0:
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            label.text = @"Indicated Cancer";
            label.textColor = [UIColor whiteColor];
            [view addSubview:label];
            view.backgroundColor = [UIColor colorWithRed:52.0f/255.0f green:219.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
            return view;
            break;
        }
        case 1:
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            label.text = @"ContraIndicated Cancer";
            label.textColor = [UIColor whiteColor];
            [view addSubview:label];
            view.backgroundColor = [UIColor colorWithRed:52.0f/255.0f green:219.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
            return view;
            break;
        }
        case 2:
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
            label.text = @"Ask your physician Cancer";
            label.textColor = [UIColor whiteColor];
            [view addSubview:label];
            view.backgroundColor = [UIColor colorWithRed:52.0f/255.0f green:219.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
            return view;
            break;
        }
        default:
            return nil;
            break;
    }
}


-(NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CancerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    
    NSLog(@"about to configure cells!");
    switch (indexPath.section) {
            
        case 0:
        {
            KHCancer *cancer = _indicatedVacArray[indexPath.row];
            
            cell.textLabel.text = cancer.name;
            break;
        }
        case 1:
        {
            KHCancer *cancer = _contraindicatedVacArray[indexPath.row];
            cell.textLabel.text = cancer.name;
            
            break;
        }
        case 2:
        {
            KHCancer *cancer= _consultPhyiscianVacArray[indexPath.row];
            
            cell.textLabel.text = cancer.name;
            break;
        }
            
            
        default:
        {
            cell.textLabel.text = @"nil";
            break;
        }
            
    }
    
    return cell;
}



- (IBAction)backItemTapped:(id)sender {
    NSLog(@"button tapped!");
//    NSLog(@"")
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:@"cancerResultToHomePageSegue" sender:self];
    
    
    
    
}
@end
