//
//  SGActivityView.m
//  CCTalk
//
//  Created by HJ Mobile on 14-6-3.
//  Copyright (c) 2014年 RFQuicklyTableViewController. All rights reserved.
//

#import "SGActivityView.h"

@interface SGActivityView ()

@property (strong, readwrite, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong, readwrite, nonatomic) UIButton *button;

@end

@implementation SGActivityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;

        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:self.indicatorView];

        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.backgroundColor = [UIColor clearColor];
        self.statusLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.statusLabel];

        _showsButton = NO;
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.hidden = YES;
        [self addSubview:_button];

        _hidesWhenStopped = YES;
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setShowsButton:(BOOL)showsButton {
    if (_showsButton != showsButton) {
        _showsButton = showsButton;
        [self setNeedsLayout];
    }
}

- (void)showInView:(UIView *)superView withStatus:(NSString *)status {
    [self showInView:superView withStatus:status andLoadingAnimation:NO];
}

- (void)showInView:(UIView *)superView withStatus:(NSString *)status andLoadingAnimation:(BOOL)animation {
    [self showInView:superView withStatus:status andFrame:CGRectZero andLoadingAnimation:animation];
}

- (void)showInView:(UIView *)superView withStatus:(NSString *)status andFrame:(CGRect)frame andLoadingAnimation:(BOOL)animation {
    if (CGRectEqualToRect(frame, CGRectZero)) {
        self.frame = superView.bounds;
    } else {
        self.frame = frame;
    }

    if (status) {
        self.statusLabel.text = status;
    }

    if (self.superview) {
        [self removeFromSuperview];
    }
    [superView addSubview:self];

    if (animation) {
        [self startAnimating];
    } else if (self.imageView.isAnimating) {
        [self stopAnimating];
    }

    [self setNeedsLayout];
}

- (void)showInView:(UIView *)superView withStatus:(NSString *)status andFrame:(CGRect)frame {
    [self showInView:superView withStatus:status andFrame:frame andLoadingAnimation:NO];
}

- (void)startAnimating {
    if (self.imageView) {
        [self.imageView startAnimating];
    } else {
        [self.indicatorView startAnimating];
    }
}

- (void)stopAnimating {
    [self.indicatorView stopAnimating];
    [self.imageView stopAnimating];
    if (self.hidesWhenStopped) {
        [self dismiss];
    }
    [self setNeedsLayout];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)setImageView:(UIImageView *)imageView {
    if (_imageView != imageView) {
        [_imageView removeFromSuperview];
        _imageView = imageView;
        [self addSubview:imageView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.statusLabel sizeToFit];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    if (self.imageView) {
        [self.imageView sizeToFit];
        self.imageView.center = CGPointMake(center.x, center.y - self.imageView.image.size.height * 0.5f);
        self.statusLabel.center = CGPointMake(
                self.imageView.center.x,
                self.imageView.center.y + (CGRectGetHeight(self.imageView.bounds) + CGRectGetHeight(self.statusLabel.bounds)) * 0.5f + 10.0f
        );
    } else {
        if (self.indicatorView.isAnimating) {
            static CGFloat margin = 5.0f;
            self.indicatorView.center = CGPointMake(center.x - CGRectGetWidth(self.statusLabel.bounds) * 0.5f - margin, center.y);
            self.statusLabel.center = CGPointMake(center.x + CGRectGetWidth(self.indicatorView.bounds) * 0.5f + margin, center.y);
        } else {
            self.statusLabel.center = center;
        }
    }

    if (self.showsButton) {
        self.button.hidden = NO;
        self.button.center = CGPointMake(center.x, CGRectGetMaxY(self.statusLabel.frame) + CGRectGetMidY(self.button.bounds) + 15.0f);
    } else {
        self.button.hidden = YES;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.showsButton && CGRectContainsPoint(self.button.frame, point)) {
        return self.button;
    }
    if (self.isHidden) {
        return [super hitTest:point withEvent:event];
    }
    return self;
}

@end
