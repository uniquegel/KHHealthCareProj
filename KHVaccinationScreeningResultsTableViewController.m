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
#import "KHVaccineRiskFactor.h"
#import "KHRiskFactorManager.h"
@interface KHVaccinationScreeningResultsTableViewController()
@property KHPatient *patient;
@property KHRiskFactorManager *rfManager;
@property NSMutableArray *indicatedArray;
@property NSMutableArray *contraindicatedArray;
@property NSMutableArray *askArray;
@property KHVaccine *vaccine;
- (IBAction)barButtonTapped:(id)sender;

@end



@implementation KHVaccinationScreeningResultsTableViewController


- (void)viewDidLoad {
    _patient = [KHPatient sharedModel];
    
    self.rfManager = [KHRiskFactorManager sharedManager];
    NSLog(@"vaccine viewdidload");
    if (!_patient.completedVaccineFlow) {
        [self.view setHidden:YES];
        
    }
//    [self.tableView setHidden:YES];
    [super viewDidLoad];
    
    
//    for (int i = 0; i<_rfModel.AllRFListForVaccine.count; i++) {
//        KHVaccineRiskFactor *rf =_rfModel.AllRFListForVaccine[i];
//        if (rf.isActive == YES) {
//            NSLog(@"AAA: active rf: %@", rf.name);
//        }
//        else if (rf.isActive == NO) {
//            NSLog(@"III: Inavtive rf: %@", rf.name);
//        }
//    }
    
    self.indicatedArray = [[NSMutableArray alloc] init];
    self.contraindicatedArray = [[NSMutableArray alloc] init];
    self.askArray = [[NSMutableArray alloc] init];
    
    
    NSLog(@"ABOUT TO DIVIDE INTO CATE");
    NSLog(@"patient vac count: %lu", [_patient.vaccineList count]);
    
    
    for (id key in self.patient.vaccineList) {
        NSDictionary *dict = [self.patient.vaccineList objectForKey:key];
        NSString *statusString = dict[@"value"];
        NSLog(@"vaccine name: %@, status: %@", dict[@"name"], dict[@"value"]);
        
        if ([statusString isEqualToString:@"W"]) {
        }
        else if ([statusString isEqualToString:@"Y"]){
            [_indicatedArray addObject:dict];
        }
        else if ([statusString isEqualToString:@"G"]){
        }
        else if ([statusString isEqualToString:@"B"]){
            [_askArray addObject:dict];
        }
        else if ([statusString isEqualToString:@"R"]){
            [_contraindicatedArray addObject:dict];
        }
        else{
            NSLog(@"Vaccine status invalid: %@", statusString);
        }
        
        
        
        //        switch (gs->status) {
        //            case 0:{
        //                [_contraindicatedArray addObject:gs];
        //                break;
        //            }
        //            case 1:{
        //                [_askArray addObject:gs];
        //                break;
        //            }
        //            case 2:{
        //                [_indicatedArray addObject:gs];
        //                break;
        //            }
        //            default:
        //                break;
        //        }
    }
    
    NSLog(@" ask Count: %lu ", (unsigned long)_askArray.count);
    NSLog(@" contra Count: %lu /n", (unsigned long)_contraindicatedArray.count);
    NSLog(@" indic Count: %lu /n", (unsigned long)_indicatedArray.count);
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewDidAppear:(BOOL)animated {
    
    NSLog(@"vaccine viewdidappear!");
//    [self.view removeFromSuperview];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return _indicatedArray.count;
            break;
        }
        case 1:
            return _contraindicatedArray.count;
            break;
        case 2:
            return _askArray.count;
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
            //indicated
            NSDictionary *dict = self.indicatedArray[indexPath.row];
            
            cell.textLabel.text = dict[@"name"];
            break;
        }
        case 1:
        {
            //contraindicated
            NSDictionary *dict = self.contraindicatedArray[indexPath.row];
            
            cell.textLabel.text = dict[@"name"];
            
            break;
        }
        case 2:
        {
            //ask
            NSDictionary *dict = self.askArray[indexPath.row];
            
            cell.textLabel.text = dict[@"name"];
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
    NSLog(@"bar button tapped");
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:@"vaccineResultToHomeSegue" sender:self];
    
}
@end
