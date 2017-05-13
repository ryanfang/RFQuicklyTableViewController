//
//  RFBaseTableViewCell.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/11.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseTableViewCell.h"
#import "UIColor+HJMHexString.h"

@interface RFBaseTableViewCell ()

@property (strong, nonatomic) CALayer *lineSeparatorLayer;

@end

@implementation RFBaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(nil != self) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectedBackgroundView = [[UIView alloc] init];
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
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

@end
