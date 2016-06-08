//
//  KHVaccinationScreeningResultsViewController.m
//  KHHealthCareProj
//
//  Created by David Richardson on 3/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHVaccinationScreeningResultsTableViewController.h"
#import "KHPatient.h"
#import "KHVaccine.h"
#import "KHRiskFactorModel.h"
#import "KHVaccineRiskFactor.h"
@interface KHVaccinationScreeningResultsTableViewController()
@property KHPatient *patient;
@property KHRiskFactorModel *rfModel;
@property NSMutableArray *indicatedVacArray;
@property NSMutableArray *contraindicatedVacArray;
@property NSMutableArray *consultPhyiscianVacArray;
@property KHVaccine *vaccine;
- (IBAction)barButtonTapped:(id)sender;

@end



@implementation KHVaccinationScreeningResultsTableViewController


- (void)viewDidLoad {
    _patient = [KHPatient sharedModel];
    _rfModel = [KHRiskFactorModel sharedModel];
    NSLog(@"vaccine viewdidload");
    if (!_patient.completedVaccineFlow) {
//        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 800, 800)];
//        coverView.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:coverView];
//        [self.view bringSubviewToFront:coverView];
        [self.view setHidden:YES];
        
    }
//    [self.tableView setHidden:YES];
    [super viewDidLoad];
    
    
    for (int i = 0; i<_rfModel.AllRFListForVaccine.count; i++) {
        KHVaccineRiskFactor *rf =_rfModel.AllRFListForVaccine[i];
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
    NSLog(@"patient vac count: %lu", _patient.vaccineList.count);
    
    
    for (int i  =0; i< [_patient.vaccineList count]; i++) {
        
        _vaccine = _patient.vaccineList[i];
        
        NSLog(@" vaccine status: %u",  _vaccine->status);
        //indicated
        if (_vaccine->status == 2) {
            [_indicatedVacArray addObject:_vaccine];
        }
        //contra indicated
        else if (_vaccine->status == 0) {
            [_contraindicatedVacArray addObject:_vaccine];
        }
        //consult
        else if (_vaccine->status == 1) {
            [_consultPhyiscianVacArray addObject:_vaccine];
        }
        
    }
    
    
    NSLog(@" ask Count: %lu ", (unsigned long)_consultPhyiscianVacArray.count);
    NSLog(@" contra Count: %lu /n", (unsigned long)_contraindicatedVacArray.count);
    NSLog(@" indic Count: %lu /n", (unsigned long)_indicatedVacArray.count);
}


- (void)viewDidAppear:(BOOL)animated {
    
    NSLog(@"vaccine viewdidappear!");
//    [self.view removeFromSuperview];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"about to get rows in sec!");
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
            label.text = @"Indicated Vaccine";
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
            label.text = @"ContraIndicated Vaccine";
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
            label.text = @"Ask your physician Vaccine";
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
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    
    NSLog(@"about to configure cells!");
    switch (indexPath.section) {

        case 0:
        {
            KHVaccine *vaccine = _indicatedVacArray[indexPath.row];
            
            cell.textLabel.text = vaccine.name;
            break;
        }
        case 1:
        {
            KHVaccine *vaccine = _contraindicatedVacArray[indexPath.row];
            cell.textLabel.text = vaccine.name;

            break;
        }
        case 2:
        {
            KHVaccine *vaccine = _consultPhyiscianVacArray[indexPath.row];
            
            cell.textLabel.text = vaccine.name;
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



- (IBAction)barButtonTapped:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:@"vaccineResultToHomeSegue" sender:self];
    
}
@end
