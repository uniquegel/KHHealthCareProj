//
//  KHTabBarViewController.m
//  KHHealthCareProj
//
//  Created by Ryan Lu on 6/5/16.
//  Copyright © 2016 Ryan Lu. All rights reserved.
//

#import "KHTabBarViewController.h"

@interface KHTabBarViewController ()

@end

@implementation KHTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.tabBar setSelectedItem:[self.tabBar.items objectAtIndex:_showTabNumber]];
    NSLog(@"IN VIEWDIDLOAD");
    self.selectedIndex = _showTabNumber;
    
//    [(UITabBarController*)self.navigationController.topViewController setSelectedIndex:1];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    // Other code...
//    NSLog(@"viewDIDAPPEAR");
    
//        [self.tabBarController setSelectedIndex:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
