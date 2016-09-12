//
//  KHCardiometabolicScreeningResultsTableViewController.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 6/6/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHGeneralScreeningResultsTableViewController.h"
#import "KHPatient.h"
#import "KHHealthCareProj-Swift.h"

#import "KHRiskFactorModel.h"
#import "KHRiskFactorManager.h"
#import "KHRiskFactor.h"
#import "KHGeneralScreening.h"

@interface KHCardiometabolicScreeningResultsTableViewController ()
@property KHPatient *patient;
@property KHRiskFactorManager *rfManager;
@property (nonnull) NSArray  *allRiskFactors;
@property (nonnull) NSArray  *generalRiskFactors;
@property NSMutableArray *indicatedArray;
@property NSMutableArray *contraindicatedArray;
@property NSMutableArray *askArray;
- (IBAction)onBackBtnTap:(id)sender;
@end

@implementation KHCardiometabolicScreeningResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _patient = [KHPatient sharedModel];
//    _rfModel = [KHRiskFactorModel sharedModel];
    self.rfManager = [KHRiskFactorManager sharedManager];
    self.allRiskFactors = self.rfManager.allRiskFactors;
    self.generalRiskFactors = self.rfManager.generalRiskFactors;
    
    
//    _patient.completedGeneralFlow = NO;
    if (!_patient.completedGeneralFlow) {
        [self.view setHidden:YES];
    }
    else {
        for (KHRiskFactor *rf in self.allRiskFactors) {
            if (rf.isActive == YES) {
                NSLog(@"AAA: active rf: %@", rf.name);
            }
            else if (rf.isActive == NO) {
                NSLog(@"III: Inavtive rf: %@", rf.name);
            }
        }
    }
    
    self.indicatedArray = [[NSMutableArray alloc] init];
    self.contraindicatedArray = [[NSMutableArray alloc] init];
    self.askArray = [[NSMutableArray alloc] init];
    
    
    NSLog(@"ABOUT TO DIVIDE INTO CATE");
    NSLog(@"patient vac count: %lu", [_patient.generalList count]);
    
    
    for (id key in self.patient.generalList) {
        NSDictionary *dict = [self.patient.generalList objectForKey:key];
        NSString *statusString = dict[@"value"];
        NSLog(@"general screening name: %@, status: %@", dict[@"name"], dict[@"value"]);

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
            NSLog(@"General Screening status invalid: %@", statusString);
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 3;
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
            label.text = @"Indicated General Screening";
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
            label.text = @"ContraIndicated General Screening";
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
            label.text = @"Ask your physician General Screening";
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


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onBackBtnTap:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:@"generalResultsToHomeSegue" sender:self];
    
}
@end
