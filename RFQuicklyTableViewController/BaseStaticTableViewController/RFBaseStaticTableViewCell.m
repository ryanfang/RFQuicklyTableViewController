//
//  RFBaseStaticTableViewCell.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/11.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseStaticTableViewCell.h"
#import "NSString+RichText.h"

@implementation RFBaseStaticTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(nil != self) {
        
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
    
}

@end
