//
//  DemoDynamicCellModel.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/16.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "DemoDynamicCellModel.h"

@interface DemoDynamicCellModel ()

//@property (nonatomic, assign) E_TD_LIST_TYPE type;

@end

@implementation DemoDynamicCellModel

- (id)initWithData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        _title = data[@"title"];
    }
    return self;
}

- (void)dealloc {
    
}

#pragma mark - 网络数据请求接口


@end
