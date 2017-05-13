//
//  RFBaseDynamicTableViewCell.h
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/22.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseTableViewCell.h"

@interface RFBaseDynamicTableViewCell : RFBaseTableViewCell

@property (nonatomic, strong) id model;

- (void)setCellModel:(id)model;

@end
