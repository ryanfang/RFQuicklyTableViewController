//
//  RFBaseStaticTableViewModel.h
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/12.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define k_CellForRowAtIndexPath_selector_key @"cellForRowAtIndexPath_selector"
#define k_DidSelectRowAtIndexPath_selector_key @"didSelectRowAtIndexPath_selector"

@protocol RFBaseStaticTableViewModelDelegate <NSObject>

@end

@interface RFBaseStaticTableViewModel : NSObject

@property (nonatomic, weak) id<RFBaseStaticTableViewModelDelegate> delegate;
/** 数据结构 */
@property (nonatomic, strong) NSArray *sections;

/** cellForRowAtIndexPath的回调方法 */
@property (nonatomic, strong) UITableViewCell* (^cellForRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);

/** didSelectRowAtIndexPath的回调方法 */
@property (nonatomic, strong) void (^didSelectRowAtIndexPathBlock)(UITableView *tableView, NSIndexPath *indexPath);

/** 获取自定义的UITableView */
@property (nonatomic, strong) UITableView* (^getCustomTableViewBlock)();

@end
