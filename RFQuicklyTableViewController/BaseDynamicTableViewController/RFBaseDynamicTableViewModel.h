//
//  RFBaseDynamicTableViewModel.h
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/28.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseStaticTableViewModel.h"
#import "RFBaseDynamicTableFooterView.h"

#define k_RF_FirstPageIndex (1) // 列表拉取首页的页面索引号

@interface RFBaseDynamicTableViewModel : RFBaseStaticTableViewModel

@property (nonatomic, assign) NSUInteger cellHeight; // 每个Cell高度
@property (nonatomic, copy) NSMutableArray *dataList; // 解析之后的显示数据列表

@property (nonatomic, assign) NSUInteger total;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSUInteger pageIndex;

@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic, assign) NSUInteger itemsCount;
@property (nonatomic, copy) NSString *noDataAlertString;

@property (nonatomic, unsafe_unretained) Class cellModelClass;
@property (nonatomic, unsafe_unretained) Class cellViewClass;

/**
 *  基础Block类型，都会包含一个NSError过来，以便回Call
 */
typedef void (^RFCompletionBlock)(id data, NSError *error);

/** 重新加载并刷新列表的回调方法 */
@property (nonatomic, strong) void (^refreshBlock)(RFCompletionBlock completion);

/** 读取分页数据，加载更多列表的回调方法 */
@property (nonatomic, strong) void (^loadMoreBlock)(RFCompletionBlock completion);

/** 加载失败的时候Block回调方法 */
@property (nonatomic, strong) RFCompletionBlock failuredBlock;

/** 获取自定义的FooterView的Block回调方法，不定义则使用默认的风格 */
@property (nonatomic, strong) UIView* (^getFooterViewBlock)(RFTableFooterViewType type);

/**
 *  解析网络请求的列表数据
 *
 *  @param resValue 请求返回的数据
 *  @param listKey 解析列表数据的key值
 */
- (void)parseWithResValue:(id)resValue listKey:(NSString *)listKey;

/**
 *  网络请求错误时的统一处理
 *
 *  @param error 请求返回的错误信息
 */
- (void)onFailureWithError:(NSError *)error;

@end
