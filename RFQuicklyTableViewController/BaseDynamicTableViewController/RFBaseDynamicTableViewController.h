//
//  RFBaseDynamicTableViewController.h
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/22.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseStaticTableViewController.h"
#import "RFBaseDynamicTableViewModel.h"
#import "SGActivityView.h"

#define K_SGLIST_PAGE_SIZE (20)

@interface RFBaseDynamicTableViewController : RFBaseStaticTableViewController

@property (nonatomic, strong) SGActivityView *noListTip;
@property (nonatomic, assign) BOOL isNeedFooterView;

- (void)__refresh;
- (void)__loadMore;

@end
