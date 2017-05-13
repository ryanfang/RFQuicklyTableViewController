//
//  DemoStaticTableViewLogoutCell.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/20.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "DemoStaticTableViewLogoutCell.h"

@implementation DemoStaticTableViewLogoutCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(nil != self) {
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc {
    _titleLabel = nil;
}

#pragma mark - 控件定义

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        CGFloat x = 15.0f;
        CGFloat y = 0.0f;
        CGFloat w = CGRectGetWidth(self.frame) - 2 * x;
        CGFloat h = k_RF_BaseTableViewCell_Height;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
    }
    return _titleLabel;
}

@end
