//
//  SGActivityView.h
//  RFQuicklyTableViewController
//
//  Created by RyanFang on 17-5-3.
//  Copyright (c) 2017年 RFQuicklyTableViewController. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGActivityView : UIView

IB_DESIGNABLE
@property (strong, readonly, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (assign, nonatomic) BOOL hidesWhenStopped;
@property (strong, readonly, nonatomic) UIButton *button;
@property (assign, nonatomic) BOOL showsButton;

- (void)showInView:(UIView *)superView withStatus:(NSString *)status;

- (void)showInView:(UIView *)superView withStatus:(NSString *)status andLoadingAnimation:(BOOL)animation;

- (void)showInView:(UIView *)superView withStatus:(NSString *)status andFrame:(CGRect)frame;

- (void)showInView:(UIView *)superView withStatus:(NSString *)status andFrame:(CGRect)frame andLoadingAnimation:(BOOL)animation;

- (void)startAnimating;
- (void)stopAnimating;
- (void)dismiss;

@end
