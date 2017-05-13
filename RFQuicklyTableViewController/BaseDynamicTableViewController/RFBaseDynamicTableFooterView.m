//
//  RFBaseDynamicTableFooterView.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/6/24.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseDynamicTableFooterView.h"

@interface RFBaseDynamicTableFooterView ()

@property (nonatomic, strong) UIImageView *tableFooterImageView;
@property (nonatomic, strong) UIButton *tableFooterButton;

@end

@implementation RFBaseDynamicTableFooterView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.tableFooterButton];
    [self addSubview:self.tableFooterImageView];
}

- (void)dealloc {
    _tableFooterButton = nil;
}

#pragma mark - Widget define

- (UIButton *)tableFooterButton {
    if (!_tableFooterButton) {
        _tableFooterButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        CGRectGetWidth(self.frame),
                                                                        CGRectGetHeight(self.frame))];
        _tableFooterButton.backgroundColor = [UIColor clearColor];
        _tableFooterButton.hidden = YES;
        [_tableFooterButton addTarget:self action:@selector(tableFooterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *contentStr = @"加载失败，请|重试|";
        NSString *dispContentStr = [contentStr stringByReplacingOccurrencesOfString:@"|" withString:@""];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:dispContentStr];
        
        NSArray *contentArray = [contentStr componentsSeparatedByString:@"|"];
        if (contentArray && contentArray.count == 3) {
            //设置：在0-3个单位长度内的内容显示成红色
            NSString *lightString = [NSString stringWithFormat:@"%@", contentArray[1]];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, dispContentStr.length)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(0, dispContentStr.length)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0510 green:0.5176 blue:0.9882 alpha:1] range:[dispContentStr rangeOfString:lightString]];
            [_tableFooterButton setAttributedTitle:str forState:UIControlStateNormal];
        }
    }
    return _tableFooterButton;
}

- (UIImageView *)tableFooterImageView {
    if (!_tableFooterImageView) {
        CGFloat w = 204.0f;
        CGFloat h = 20.0f;
        CGFloat x = (CGRectGetWidth(self.frame) - w)/2.0f;
        CGFloat y = 20.0f;
        _tableFooterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _tableFooterImageView.backgroundColor = [UIColor clearColor];
        _tableFooterImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_tableFooterImageView setImage:[UIImage imageNamed:@"ic_no_more"]];
        _tableFooterImageView.hidden = NO;
    }
    return _tableFooterImageView;
}

- (void)setType:(RFTableFooterViewType)type {
    _type = type;
    
    switch (type) {
        case RFTableFooterViewType_LoadFailed:
        {
            self.tableFooterButton.hidden = NO;
            self.tableFooterImageView.hidden = YES;
        }
            break;
            
        case RFTableFooterViewType_NoMore:
        {
            self.tableFooterButton.hidden = YES;
            self.tableFooterImageView.hidden = NO;
        }
            break;
            
        default:
        {
            self.tableFooterButton.hidden = YES;
            self.tableFooterImageView.hidden = YES;
        }
            break;
    }
}

#pragma mark - Click callback

- (void)tableFooterButtonClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(baseDynamicTableFooterView:tableFooterButtonClick:)]) {
        [self.delegate baseDynamicTableFooterView:self tableFooterButtonClick:sender];
    }
}

@end
