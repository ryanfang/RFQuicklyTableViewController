//
//  RFBaseStaticTableViewController.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/8.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseStaticTableViewController.h"
#import "RFBaseTableViewCell.h"
#import "UIColor+HJMHexString.h"

@interface RFBaseStaticTableViewController ()

@property (nonatomic, assign) UITableViewStyle style;

@end

@implementation RFBaseStaticTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _style = UITableViewStyleGrouped;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        _style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RFBaseStaticTableViewModel *model = (RFBaseStaticTableViewModel *)self.model;
    model.delegate = self;
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _model = nil;
    _tableView = nil;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - 控件定义

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat w = CGRectGetWidth(self.view.frame);
        CGFloat h = CGRectGetHeight(self.view.frame);
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, w, h) style:_style];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = [UIColor colorWithHexString:@"e1e1e1"];
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 80, 0, 0);
        _tableView.scrollsToTop = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
        _tableView.tableHeaderView = [UIView new];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    RFBaseStaticTableViewModel *model = self.model;
    NSDictionary *sectionDic = model.sections[section];
    return [sectionDic objectForKey:@"header_view"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    RFBaseStaticTableViewModel *model = self.model;
    NSDictionary *sectionDic = model.sections[section];
    UIView *view = [sectionDic objectForKey:@"header_view"];
    view.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    return CGRectGetHeight(view.frame);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RFBaseStaticTableViewModel *model = self.model;
    NSDictionary *sectionDic = model.sections[indexPath.section];
    NSArray *items = [sectionDic objectForKey:@"array"];
    CGFloat height = k_RF_BaseTableViewCell_Height;
    if (indexPath.row < items.count) {
        NSDictionary *cellDic = [items objectAtIndex:indexPath.row];
        height = [cellDic[@"height"] integerValue];
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RFBaseStaticTableViewModel *model = self.model;
    if (model.didSelectRowAtIndexPathBlock) {
        model.didSelectRowAtIndexPathBlock(tableView, indexPath);
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    RFBaseStaticTableViewModel *model = self.model;
    return model.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    RFBaseStaticTableViewModel *model = self.model;
    NSDictionary *sectionDic = model.sections[section];
    NSArray *items = [sectionDic objectForKey:@"array"];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RFBaseStaticTableViewModel *model = self.model;
    return model.cellForRowAtIndexPathBlock(tableView, indexPath);
}

@end
