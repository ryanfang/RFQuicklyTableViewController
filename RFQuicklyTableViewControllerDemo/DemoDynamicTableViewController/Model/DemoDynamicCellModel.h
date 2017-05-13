//
//  DemoDynamicCellModel.h
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/16.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoDynamicListModel.h"

@interface DemoDynamicCellModel : NSObject

@property (nonatomic, copy) NSString *title;

- (id)initWithData:(NSDictionary *)data;

@end
