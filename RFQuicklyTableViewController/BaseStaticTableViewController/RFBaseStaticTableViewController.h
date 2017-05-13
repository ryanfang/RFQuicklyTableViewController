//
//  RFBaseStaticTableViewController.h
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/8.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseViewController.h"
#import "RFBaseStaticTableViewModel.h"

@interface RFBaseStaticTableViewController : RFBaseViewController <UITableViewDelegate, UITableViewDataSource, RFBaseStaticTableViewModelDelegate>

@property (nonatomic, strong) id model;
@property (nonatomic, strong) UITableView *tableView;

- (id)initWithStyle:(UITableViewStyle)style;

@end
