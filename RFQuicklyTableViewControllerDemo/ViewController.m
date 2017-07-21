//
//  ViewController.m
//  RFQuicklyTableViewControllerDemo
//
//  Created by Ryan Fang on 2017/5/11.
//  Copyright © 2017年 Ryan Fang. All rights reserved.
//

#import "ViewController.h"
#import "DemoDynamicTableViewController.h"
#import "DemoStaticTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)staticListButton:(id)sender {
    DemoStaticTableViewController *vc = [[DemoStaticTableViewController alloc] init];
    UINavigationController *nav = self.navigationController;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)dynamicListButton:(id)sender {
    DemoDynamicTableViewController *vc = [[DemoDynamicTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
