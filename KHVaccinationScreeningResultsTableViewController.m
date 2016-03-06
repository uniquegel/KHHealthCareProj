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
@interface KHVaccinationScreeningResultsTableViewController()
@property KHPatient *patient;
@property NSMutableArray *indicatedVacArray;
@property NSMutableArray *contraindicatedVacArray;
@property NSMutableArray *consultPhyiscianVacArray;
@property KHVaccine *vaccine;

@end



@implementation KHVaccinationScreeningResultsTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _patient = [KHPatient sharedModel];
    
    
    _indicatedVacArray = [[NSMutableArray alloc] init];
        _consultPhyiscianVacArray = [[NSMutableArray alloc] init];
        _contraindicatedVacArray = [[NSMutableArray alloc] init];
    
    
    
    NSLog(@"ABOUT TO DIVIDE INTO CATE");
    NSLog(@"patient vac count: %lu", _patient.vaccineList.count);
    for (int i  =0; i< [_patient.vaccineList count]; i++) {
        _vaccine = _patient.vaccineList[i];
        
        NSLog(@" vaccine status: %u",  _vaccine->status);
        if (_vaccine->status == 4 ) {
            [_indicatedVacArray addObject:_vaccine];
        }
        else if (_vaccine->status == Contraindicated) {
            [_contraindicatedVacArray addObject:_vaccine];
        }
        else if (_vaccine->status == Ask) {
            [_consultPhyiscianVacArray addObject:_vaccine];
        }
        
    }
    NSLog(@" ask Count: %lu /n", (unsigned long)_consultPhyiscianVacArray.count);
        NSLog(@" contra Count: %lu /n", (unsigned long)_contraindicatedVacArray.count);
        NSLog(@" indic Count: %lu /n", (unsigned long)_indicatedVacArray.count);
    
    
    
    
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 50)];
            label.text = @"Indicated Vaccine";
            [view addSubview:label];
            view.backgroundColor = [UIColor blueColor];
            return view;
            break;
        }
        case 1:
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 50)];
            label.text = @"ContraIndicated Vaccine";
            [view addSubview:label];
            view.backgroundColor = [UIColor blueColor];
            return view;
            break;
        }
        case 2:
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 50)];
            label.text = @"Ask your physician Vaccine";
            [view addSubview:label];
            view.backgroundColor = [UIColor blueColor];
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

    switch (indexPath.section) {

        case 0:
        {
            KHVaccine *vaccine = _indicatedVacArray[indexPath.row];
            
            cell.textLabel.text = vaccine.name;
            break;
        }
        case 1:
        {
            KHVaccine *vaccine = _indicatedVacArray[indexPath.row];
            cell.textLabel.text = vaccine.name;

            break;
        }
        case 2:
        {
            KHVaccine *vaccine = _indicatedVacArray[indexPath.row];
            
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



@end
