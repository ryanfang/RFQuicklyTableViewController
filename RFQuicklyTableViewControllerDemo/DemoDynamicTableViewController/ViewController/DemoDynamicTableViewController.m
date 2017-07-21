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
    // 获取自定义的FooterView的Block回调方法，不定义则使用默认的风格
//    model.getFooterViewBlock = ^UIView *(RFTableFooterViewType type) {
//        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 30)];
//        switch (type) {
//            case RFTableFooterViewType_LoadFailed:
//                footerView.backgroundColor = [UIColor lightGrayColor];
//                break;
//                
//            case RFTableFooterViewType_NoMore:
//                footerView.backgroundColor = [UIColor greenColor];
//                break;
//                
//            case RFTableFooterViewType_None:
//                footerView.backgroundColor = [UIColor clearColor];
//                break;
//                
//            default:
//                break;
//        }
//        return footerView;
//    };
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
