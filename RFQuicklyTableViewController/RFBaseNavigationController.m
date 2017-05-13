//
//  RFBaseNavigationController.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/7/2.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "RFBaseNavigationController.h"
#import "UIColor+HJMHexString.h"
#import "UIImage+Additions.h"

@interface RFBaseNavigationController ()

@end

@implementation RFBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self __setupNormalSkin];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
//    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private method

- (void)__setupNormalSkin
{
//    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [self.navigationBar setBackgroundColor:[UIColor colorWithHexString:@"9b59b6"]];
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"9b59b6"] size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
    if ([self.navigationBar respondsToSelector:@selector(setShadowImage:)]) {
        [self.navigationBar setShadowImage:[UIImage new]];
    }
    self.navigationBar.tintColor = [UIColor whiteColor];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeZero;
    [self.navigationBar setTitleTextAttributes:@{
                                            NSFontAttributeName : [UIFont boldSystemFontOfSize:18],
                                            NSForegroundColorAttributeName : [UIColor whiteColor],
                                            NSShadowAttributeName : shadow,
                                            }];
    NSMutableDictionary *barButtonItemTextAttributes = [self.navigationBar.titleTextAttributes mutableCopy];
    barButtonItemTextAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:barButtonItemTextAttributes forState:UIControlStateNormal];
}

@end
