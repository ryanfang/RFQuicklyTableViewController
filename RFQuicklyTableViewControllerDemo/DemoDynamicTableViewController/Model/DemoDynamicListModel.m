//
//  DemoDynamicListModel.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/16.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "DemoDynamicListModel.h"
#import "DemoDynamicCellModel.h"
#import "DemoDynamicTableViewCell.h"

@interface DemoDynamicListModel ()

@end

@implementation DemoDynamicListModel

- (id)init {
    self = [super init];
    if (self) {
        self.cellModelClass = [DemoDynamicCellModel class];
        self.cellViewClass = [DemoDynamicTableViewCell class];
        self.cellHeight = k_RF_BaseTableViewCell_Height;
        
        self.noDataAlertString = NSLocalizedString(@"NO_DATA", nil); // 设置无数据时的显示内容
        
        __weak __typeof(&*self)weakSelf = self;
        // 设置刷新操作请求网络数据的回调方法
        self.refreshBlock = ^ (RFCompletionBlock completion) {
            [weakSelf reqDataListWithPageIndex:weakSelf.pageIndex
                                   pageSize:K_SGLIST_PAGE_SIZE
                                 completion:^(id data, NSError *error)
             {
                 if (completion) {
                     completion(data, error);
                 }
             }];
        };
        
        // 设置拉取更多操作请求网络数据的回调方法
        self.loadMoreBlock = ^ (RFCompletionBlock completion) {
            [weakSelf reqDataListWithPageIndex:weakSelf.pageIndex
                                   pageSize:K_SGLIST_PAGE_SIZE
                                 completion:^(id data, NSError *error)
             {
                 if (completion) {
                     completion(data, error);
                 }
             }];
        };
    }
    return self;
}

- (void)dealloc {

}

#pragma mark - 网络数据请求接口

/**
 *  获取列表数据
 *
 *  @param pageIndex  当前请求分页索引
 *  @param pageSize   当前分页请求的记录最大个数
 *  @param completion 回调Block
 *
 */
- (void)reqDataListWithPageIndex:(NSUInteger)pageIndex
                        pageSize:(NSUInteger)pageSize
                      completion:(RFCompletionBlock)completion {
    
    __weak __typeof(&*self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        [self reqDataListHttpWithPageIndex:pageIndex pageSize:pageSize completion:^(id data, NSError *error) {
            if (!error) {
                // 解析数据
                [weakSelf parseWithResValue:data listKey:@"list"];
                
                // 回调
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(data, nil);
                    });
                }
                
            } else {
                [weakSelf onFailureWithError:error];
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(nil, error);
                    });
                }
            }
        }];

    });
}

/**
 *  模拟网络请求数据
 *
 *  @param pageIndex  当前请求分页索引
 *  @param pageSize   当前分页请求的记录最大个数
 *  @param completion 回调Block
 *
 */
- (void)reqDataListHttpWithPageIndex:(NSUInteger)pageIndex pageSize:(NSUInteger)pageSize completion:(RFCompletionBlock)completion {
    __weak __typeof(&*self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *list = [NSMutableArray array];
        NSUInteger total = 50;
        NSUInteger startIndex = ((int)pageIndex - weakSelf.firstPageIndex) * (int)pageSize;
        NSUInteger endIndex = MIN((startIndex + (int)pageSize), total);
        for (NSUInteger i = startIndex; i < endIndex; i++) {
            [list addObject:@{@"title": [NSString stringWithFormat:@"cell index %@", @(i)]}];
        }
        NSDictionary *resDataDic = @{@"total": @(total),
                                     @"count": @(endIndex + 1),
                                     @"index": @(pageIndex),
                                     @"list": list};
        completion(resDataDic, nil);
    });
}

@end
