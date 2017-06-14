//
//  RFBaseDynamicTableFooterView.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/6/24.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseDynamicTableFooterView.h"

@interface RFBaseDynamicTableFooterView ()

@property (nonatomic, strong) UIView *noMoreView;
@property (nonatomic, strong) UIButton *retryButton;

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
    
    [self addSubview:self.retryButton];
    [self addSubview:self.noMoreView];
}

- (void)dealloc {
    _noMoreView = nil;
    _retryButton = nil;
}

#pragma mark - Widget define

- (UIButton *)retryButton {
    if (!_retryButton) {
        _retryButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        CGRectGetWidth(self.frame),
                                                                        CGRectGetHeight(self.frame))];
        _retryButton.backgroundColor = [UIColor clearColor];
        _retryButton.hidden = YES;
        [_retryButton addTarget:self action:@selector(tableFooterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
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
            [_retryButton setAttributedTitle:str forState:UIControlStateNormal];
        }
    }
    return _retryButton;
}

- (UIView *)noMoreView {
    if (!_noMoreView) {
        CGFloat w = CGRectGetWidth(self.frame);
        CGFloat h = 20.0f;
        CGFloat x = 0.0f;
        CGFloat y = 20.0f;
        _noMoreView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _noMoreView.backgroundColor = [UIColor clearColor];
        _noMoreView.contentMode = UIViewContentModeScaleAspectFill;
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.font = [UIFont systemFontOfSize:12.0f];
        contentLabel.text = @"没有更多";
        [_noMoreView addSubview:contentLabel];
        _noMoreView.hidden = YES;
    }
    return _noMoreView;
}

- (void)setType:(RFTableFooterViewType)type {
    _type = type;
    
    switch (type) {
        case RFTableFooterViewType_LoadFailed:
        {
            self.retryButton.hidden = NO;
            self.noMoreView.hidden = YES;
        }
            break;
            
        case RFTableFooterViewType_NoMore:
        {
            self.retryButton.hidden = YES;
            self.noMoreView.hidden = NO;
        }
            break;
            
        default:
        {
            self.retryButton.hidden = YES;
            self.noMoreView.hidden = YES;
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
