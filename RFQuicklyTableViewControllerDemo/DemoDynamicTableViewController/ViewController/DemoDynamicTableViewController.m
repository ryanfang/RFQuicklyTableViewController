//
//  DemoDynamicTableViewController.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/12.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "DemoDynamicTableViewController.h"
#import "DemoDynamicTableViewCell.h"
#import "DemoDynamicListModel.h"

@interface DemoDynamicTableViewController () <UITableViewDelegate, UITableViewDataSource>


@end

@implementation DemoDynamicTableViewController

- (id)init {
    self = [super init];
    if (self) {
        [self __setupModel];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

}

#pragma mark - Private method

- (void)__setupModel {
    
    __typeof__ (self) __weak weakSelf = self;
    
    self.model = [[DemoDynamicListModel alloc] init];
    __block DemoDynamicListModel *model = (DemoDynamicListModel *)self.model;
    model.noDataAlertString = NSLocalizedString(@"NO_DATA", nil); // 设置无数据时的显示内容
    
    // 设置刷新操作请求网络数据的回调方法
    model.refreshBlock = ^ (RFCompletionBlock completion) {
        DemoDynamicListModel *model = (DemoDynamicListModel *)weakSelf.model;
        [model reqDataListWithPageIndex:model.pageIndex
                               pageSize:K_SGLIST_PAGE_SIZE
                             completion:^(id data, NSError *error)
         {
             if (completion) {
                 completion(data, error);
             }
         }];
    };
    
    // 设置拉取更多操作请求网络数据的回调方法
    model.loadMoreBlock = ^ (RFCompletionBlock completion) {
        DemoDynamicListModel *model = (DemoDynamicListModel *)weakSelf.model;
        [model reqDataListWithPageIndex:model.pageIndex
                                  pageSize:K_SGLIST_PAGE_SIZE
                                completion:^(id data, NSError *error)
         {
             if (completion) {
                 completion(data, error);
             }
         }];
    };
    
    // cell的点击操作回调
    model.didSelectRowAtIndexPathBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        DemoDynamicListModel *model = (DemoDynamicListModel *)weakSelf.model;
        if (indexPath.row < model.dataList.count) {
            NSDictionary *cellDic = model.dataList[indexPath.row];
            DemoDynamicListModel *cellModel = cellDic[@"cell_model"];
            DemoDynamicTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            // Your code here
            
        }
    };
    
    // cell内容设置
    model.cellForRowAtIndexPathBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        DemoDynamicListModel *model = (DemoDynamicListModel *)weakSelf.model;
        static NSString* identifier = @"Cell";
        DemoDynamicTableViewCell *cell = (DemoDynamicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[DemoDynamicTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: identifier];
        }
        
        if (indexPath.row < model.dataList.count) {
            NSDictionary *itemDic = [model.dataList objectAtIndex:indexPath.row];
            [cell setCellModel:[itemDic objectForKey:@"cell_model"]];
        }
        return cell;
    };
}

- (void)__setupNavigation {
    [super __setupNavigation];
    self.title = @"动态列表";
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
