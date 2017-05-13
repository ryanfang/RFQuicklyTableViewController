//
//  RFBaseWebViewController.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/9/4.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseWebViewController.h"
#import "SVPullToRefresh.h"

@interface RFBaseWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) NSString *webUrl;

@end

@implementation RFBaseWebViewController

- (instancetype)initWithTitle:(NSString *)title webUrl:(NSString *)webUrl {
    self = [super init];
    if (self) {
        _webUrl = webUrl;
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
    
    [self.webView.scrollView.pullToRefreshView startAnimating];
    [self __refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    _model = nil;
    _webView = nil;
}

#pragma mark - Define

- (UIWebView *)webView {
    if (!_webView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat w = CGRectGetWidth(self.view.frame);
        CGFloat h = CGRectGetHeight(self.view.frame);
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        webView.delegate = self;
        webView.backgroundColor = [UIColor whiteColor];
        webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
        
        __typeof__ (self) __weak weakSelf = self;
        [webView.scrollView addPullToRefreshWithActionHandler:^{
            [weakSelf __refresh];
        }];
        
        _webView = webView;
    }
    return _webView;
}

#pragma mark - Private method

- (void)__refresh {
    if (self.webUrl && self.webUrl.length > 0) {
        NSString *addressString = [self.webUrl copy];
        NSURL *addressUrl = [NSURL URLWithString:addressString];
        NSURLRequest *request =[NSURLRequest requestWithURL:addressUrl];
        [self.webView loadRequest:request];
    }
}

#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [self.webView.scrollView.pullToRefreshView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView.scrollView.pullToRefreshView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.webView.scrollView.pullToRefreshView stopAnimating];
}

@end
