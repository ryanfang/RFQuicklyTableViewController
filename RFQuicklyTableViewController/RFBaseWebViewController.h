//
//  RFBaseWebViewController.h
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/9/4.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseViewController.h"

@interface RFBaseWebViewController : RFBaseViewController

@property (nonatomic, strong) id model;
@property (nonatomic, strong) UIWebView *webView;

/** 初始化
 * 
 *  @param title 标题字符串
 *  @param webUrl 网址（不包含HOST地址，只是后面的，HOST会在里面自动拼接）
 *
 *  return 返回实例
 */
- (instancetype)initWithTitle:(NSString *)title webUrl:(NSString *)webUrl;

@end
