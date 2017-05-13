//
//  DemoDynamicListModel.h
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/16.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseDynamicTableViewModel.h"

@interface DemoDynamicListModel : RFBaseDynamicTableViewModel

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
                      completion:(RFCompletionBlock)completion;


@end
