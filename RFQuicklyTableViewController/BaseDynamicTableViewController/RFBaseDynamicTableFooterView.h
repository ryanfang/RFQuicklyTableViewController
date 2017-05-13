//
//  RFBaseDynamicTableFooterView.h
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/6/24.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RFTableFooterViewType) {
    RFTableFooterViewType_LoadFailed,
    RFTableFooterViewType_NoMore,
    RFTableFooterViewType_None
};

#define k_RF_BaseTableFooterView_Heigh (64.0f)

@protocol RFBaseDynamicTableFooterViewDelegate <NSObject>

- (void)baseDynamicTableFooterView:(UIView *)tableFooterView tableFooterButtonClick:(id)sender;

@end

@interface RFBaseDynamicTableFooterView : UIView

@property (nonatomic, assign) RFTableFooterViewType type;
@property (nonatomic, weak) id<RFBaseDynamicTableFooterViewDelegate> delegate;


@end
