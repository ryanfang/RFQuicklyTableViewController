//
//  RFBaseStaticTableViewModel.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/12.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseStaticTableViewModel.h"


@interface RFBaseStaticTableViewModel ()


@end

@implementation RFBaseStaticTableViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _delegate = nil;
        _sections = nil;
        _cellForRowAtIndexPathBlock = nil;
        _didSelectRowAtIndexPathBlock = nil;
        _getCustomTableViewBlock = nil;
        
        __typeof__ (self) __weak weakSelf = self;
        self.cellForRowAtIndexPathBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
            NSDictionary *cellDic = [weakSelf callSelectorWithIndexPath:indexPath
                                                               blockKey:k_CellForRowAtIndexPath_selector_key];
            return [cellDic objectForKey:@"cell"];
        };
        self.didSelectRowAtIndexPathBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
            [weakSelf callSelectorWithIndexPath:indexPath
                                       blockKey:k_DidSelectRowAtIndexPath_selector_key];
        };
    }
    return self;
}

- (void)dealloc {
    _delegate = nil;
    _sections = nil;
}

#pragma mark - Private method

- (NSDictionary *)callSelectorWithIndexPath:(NSIndexPath *)indexPath
                               blockKey:(NSString *)blockKey
{
    NSDictionary *sectionDic = self.sections[indexPath.section];
    NSArray *items = [sectionDic objectForKey:@"array"];
    NSDictionary *cellDic = [items objectAtIndex:indexPath.row];
    SEL setCellCallback = nil;
    [(NSValue *)[cellDic objectForKey:blockKey] getValue:&setCellCallback];
    if (setCellCallback) {
        [self.delegate performSelector:setCellCallback withObject:nil];
    }
    
    return cellDic;
}

@end
