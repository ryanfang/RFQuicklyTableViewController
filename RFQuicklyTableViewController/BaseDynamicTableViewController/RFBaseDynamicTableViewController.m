//
//  RFBaseDynamicTableViewController.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/22.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseDynamicTableViewController.h"
#import "RFBaseDynamicTableViewCell.h"
#import "SVPullToRefresh.h"
#import "RFBaseDynamicTableFooterView.h"

@interface RFBaseDynamicTableViewController () <RFBaseDynamicTableFooterViewDelegate>

@property (nonatomic, strong) RFBaseDynamicTableFooterView *tableFooterView;

@end

@implementation RFBaseDynamicTableViewController

- (id)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _isNeedFooterView = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableView];
    
    [self.tableView.pullToRefreshView startAnimating];
    [self __refresh];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _noListTip = nil;
    _tableFooterView = nil;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Private method

- (void)__refresh {
    __typeof__ (self) __weak weakSelf = self;
    __block RFBaseDynamicTableViewModel *model = (RFBaseDynamicTableViewModel *)weakSelf.model;
    void (^completionBlock)(id data, NSError *error) = ^(id data, NSError *error)
    {
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
        [weakSelf.tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:0.3];
        
        if (!error) {
            // 处理数据加载是否结束
            [weakSelf __updateFooterView:NO];
            // 如果没有人则显示提示背影
            [weakSelf.noListTip setShowsButton:NO];
            
        } else {
            [weakSelf __updateFooterView:YES];
            [weakSelf.noListTip setShowsButton:YES];
        }
        
        // 没有数据则显示默认图片和提示文字在背景上，tableview不允许上下拉动
        if (model.dataList.count == 0) {
            weakSelf.tableView.scrollEnabled = NO;
            if (!error) {
                [weakSelf.noListTip showInView:self.view withStatus:model.noDataAlertString];
            } else {
                [weakSelf.noListTip showInView:self.view withStatus:@"网络不稳定，请稍后再试"];
            }
            weakSelf.noListTip.hidden = NO;
        } else {
            weakSelf.tableView.scrollEnabled = YES;
            weakSelf.noListTip.hidden = YES;
        }
        
        // 刷新数据
        [weakSelf.tableView reloadData];
    };
    
    model.pageIndex = k_RF_FirstPageIndex;
    if (model.refreshBlock) {
        [self.tableView.pullToRefreshView startAnimating];
        [model.dataList removeAllObjects];
        model.refreshBlock(completionBlock);
    }
}

- (void)__loadMore {
    __block RFBaseDynamicTableViewModel *model = (RFBaseDynamicTableViewModel *)self.model;
    
    if (![model hasMore]) {
        return;
    }
    
    __typeof__ (self) __weak weakSelf = self;
    void (^completionBlock)(id data, NSError *error) = ^(id data, NSError *error)
    {
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
        
        if (!error) {
            // 处理数据加载是否结束
            [weakSelf __updateFooterView:NO];
        } else {
            [weakSelf __updateFooterView:YES];
        }
        
        // 刷新数据
        [weakSelf.tableView reloadData];
    };
    
    if (model.loadMoreBlock) {
        [self.tableView.infiniteScrollingView startAnimating];
        model.loadMoreBlock(completionBlock);
    }
}

// 刷新Footer View内容
- (void)__updateFooterView:(BOOL)isLoadFailed {
    __block RFBaseDynamicTableViewModel *model = (RFBaseDynamicTableViewModel *)self.model;
    
    if (!_isNeedFooterView) {
        self.tableView.tableFooterView = nil;
        return;
    }
    
    if (isLoadFailed) {
        // 请求失败，则不显示上拉加载分页的动画
        self.tableView.showsInfiniteScrolling = NO;
        
        if (model.dataList.count == 0) {
            self.tableView.tableFooterView = nil;
        } else {
            if (model.getFooterViewBlock && model.getFooterViewBlock(RFTableFooterViewType_LoadFailed)) {
                
            } else {
//                [self.tableFooterView setType:RFTableFooterViewType_LoadFailed];
//                self.tableView.tableFooterView = self.tableFooterView;
                [self __setFooterViewWithType:RFTableFooterViewType_LoadFailed];
            }
        }
        
    } else {
        // 如果还有数据则显示上拉加载动画，如果没有数据则不显示上拉加载动画
        self.tableView.showsInfiniteScrolling = model.hasMore;
        
        if (model.hasMore) {
            self.tableView.tableFooterView = nil;
        } else {
            if (model.dataList.count == 0) {
//                [self.tableFooterView setType:RFTableFooterViewType_None];
//                self.tableView.tableFooterView = nil;
                [self __setFooterViewWithType:RFTableFooterViewType_None];
            } else {
//                [self.tableFooterView setType:RFTableFooterViewType_NoMore];
//                self.tableView.tableFooterView = self.tableFooterView;
                [self __setFooterViewWithType:RFTableFooterViewType_NoMore];
            }
        }
    }
}

- (void)__setFooterViewWithType:(RFTableFooterViewType)type {
    RFBaseDynamicTableViewModel *model = (RFBaseDynamicTableViewModel *)self.model;
    UIView *footerView = nil;
    
    if (model.getFooterViewBlock
        && (footerView = model.getFooterViewBlock(type))
        ) {
        self.tableView.tableFooterView = footerView;
        
    } else {
        [self.tableFooterView setType:type];
        self.tableView.tableFooterView = self.tableFooterView;
    }
}

#pragma mark - 控件定义

- (void)setupTableView {
//    self.tableView.tableFooterView = self.tableFooterView;
    [self __setFooterViewWithType:RFTableFooterViewType_None];
    
    __typeof__ (self) __weak weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf __refresh];
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf __loadMore];
    }];
    
    [self.tableView addSubview:self.noListTip];
}

- (SGActivityView *)noListTip {
    if (!_noListTip) {
        __block RFBaseDynamicTableViewModel *model = (RFBaseDynamicTableViewModel *)self.model;
        
        _noListTip = [[SGActivityView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      CGRectGetWidth(self.view.frame),
                                                                      CGRectGetHeight(self.view.frame))];
        _noListTip.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_no_content_tip"]];
        _noListTip.statusLabel.font = [UIFont systemFontOfSize:13];
        _noListTip.statusLabel.textColor = [UIColor lightGrayColor];
        [_noListTip showInView:self.view withStatus:model.noDataAlertString];
        _noListTip.button.frame = CGRectMake(0, 0, 100, 40);
        [_noListTip.button setTitle:NSLocalizedString(@"REFRESH", nil) forState:UIControlStateNormal];
        [_noListTip.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_noListTip.button.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [_noListTip.button setBackgroundColor:[UIColor colorWithRed:36.0f/255.0f
                                                              green:141.0f/255.0f
                                                               blue:226.0f/255.0f
                                                              alpha:1.0f]];
        [_noListTip.button addTarget:self
                              action:@selector(noListTipClick:)
                    forControlEvents:UIControlEventTouchUpInside];
        
        [_noListTip setShowsButton:NO];
        [_noListTip setHidden:YES];
        
//        _noListTip.center = CGPointMake(self.tableView.center.x, self.tableView.center.y);
    }
    return _noListTip;
}

- (RFBaseDynamicTableFooterView *)tableFooterView {
    if (!_tableFooterView) {
        _tableFooterView = [[RFBaseDynamicTableFooterView alloc] initWithFrame:CGRectMake(0,
                                                                                   0,
                                                                                   CGRectGetWidth(self.tableView.frame),
                                                                                   k_RF_BaseTableFooterView_Heigh)];
        _tableFooterView.delegate = self;
    }
    return _tableFooterView;
}

#pragma mark - RFBaseDynamicTableFooterViewDelegate

- (void)baseDynamicTableFooterView:(UIView *)tableFooterView tableFooterButtonClick:(id)sender {
    [self.tableView.infiniteScrollingView startAnimating];
    [self __loadMore];
}

#pragma mark - Button Click

- (void)noListTipClick:(id)sender {
    [self.tableView.pullToRefreshView startAnimating];
    [self __refresh];
}

@end
