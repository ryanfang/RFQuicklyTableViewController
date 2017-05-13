//
//  DemoDynamicTableViewCell.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/12.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "DemoDynamicTableViewCell.h"
#import "NSString+RichText.h"

@interface DemoDynamicTableViewCell ()

@end

@implementation DemoDynamicTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(nil != self) {
        self.frame = CGRectMake(CGRectGetMinX(self.frame),
                                CGRectGetMinY(self.frame),
                                CGRectGetWidth(self.frame),
                                k_RF_BaseTableViewCell_Height);
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    
}

#pragma mark - 控件定义

- (void)setCellModel:(id)model {
    self.model = model;
    DemoDynamicCellModel *cellModel = (DemoDynamicCellModel *)model;
    
    [self.textLabel setText:cellModel.title];
}



@end
