//
//  RFBaseDynamicTableViewModel.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/28.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseDynamicTableViewModel.h"
#import "RFBaseDynamicTableViewCell.h"

@implementation RFBaseDynamicTableViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _total = 0;
        _count = 0;
        _pageIndex = k_RF_FirstPageIndex;
        _itemsCount = 0;
        _noDataAlertString = nil;
        _cellHeight = k_RF_BaseTableViewCell_Height;
        
        _dataList = [NSMutableArray array];
        
        // 设置基本数据结构
        NSDictionary *sectionDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                    _dataList, @"array", nil];
        self.sections = [NSArray arrayWithObjects:sectionDic, nil];
        
        // 设置cell
        __typeof__ (self) __weak weakSelf = self;
        self.cellForRowAtIndexPathBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
            static NSString* identifier = @"Cell";
            RFBaseDynamicTableViewCell *cell = (RFBaseDynamicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil){
                cell = [[self.cellViewClass alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: identifier];
            }
            
            if (indexPath.row < weakSelf.dataList.count) {
                NSDictionary *itemDic = [weakSelf.dataList objectAtIndex:indexPath.row];
                [cell setCellModel:[itemDic objectForKey:@"cell_model"]];
            }
            return cell;
        };
    }
    return self;
}

- (void)dealloc {
    _total = 0;
    _count = 0;
    _pageIndex = k_RF_FirstPageIndex;
    _itemsCount = 0;
    _noDataAlertString = nil;
    
    [_dataList removeAllObjects];
    _dataList = nil;
}

#pragma mark - 控件变量定义

- (BOOL)hasMore {
    return ((NSInteger)(self.total - self.dataList.count) > 0);
}

- (NSUInteger)itemsCount {
    return self.dataList.count;
}

#pragma mark - Public method

/**
 *  解析网络请求的列表数据
 *
 *  @param resValue 请求返回的数据
 *  @param modelClass 对应实例cell的model类型
 *  @param listKey 解析列表数据的key值
 */
- (void)parseWithResValue:(id)resValue listKey:(NSString *)listKey {
    if (!resValue) {
        return;
    }
    
    NSDictionary *resValueDic = (NSDictionary *)resValue;
    self.total = [resValueDic[@"total"] integerValue];
    self.count = [resValueDic[@"count"] integerValue];
    self.pageIndex = [resValueDic[@"index"] integerValue];
    NSArray *records = resValueDic[listKey];
    if (!records || ![records isKindOfClass:[NSArray class]] || records.count == 0) {
        return;
    }
    
    NSMutableArray *newList = [NSMutableArray array];
    for (NSDictionary *itemDic in records) {
        NSObject *cellModel = [[_cellModelClass alloc] initWithData:itemDic];
        NSDictionary *itemDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 cellModel, @"cell_model",
                                 @(_cellHeight), @"height", nil];
        [newList addObject:itemDic];
    }
    @synchronized(self) {
        if (self.dataList.count > 0 && self.pageIndex <= k_RF_FirstPageIndex) {
            [self.dataList removeAllObjects];
        }
        [self.dataList addObjectsFromArray:newList];
        
        _pageIndex ++;
    };
}

- (void)onFailureWithError:(NSError *)error {
    self.failuredBlock(nil, error);
//    @synchronized(self) {
//        [self.dataList removeAllObjects];
//    };
}

@end
