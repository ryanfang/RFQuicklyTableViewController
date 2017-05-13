//
//  DemoStaticTableViewController.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/8/18.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "DemoStaticTableViewController.h"
#import "RFBaseStaticTableViewCell.h"
#import "DemoStaticTableViewLogoutCell.h"
#import "RFBaseWebViewController.h"

@interface DemoStaticTableViewController ()

@property (nonatomic, strong) RFBaseStaticTableViewCell *pushSetTableViewCell;
@property (nonatomic, strong) RFBaseStaticTableViewCell *helpTableViewCell;
@property (nonatomic, strong) RFBaseStaticTableViewCell *rateMeTableViewCell;
@property (nonatomic, strong) RFBaseStaticTableViewCell *feedbackTableViewCell;
@property (nonatomic, strong) RFBaseStaticTableViewCell *aboutTableViewCell;

@end

@implementation DemoStaticTableViewController

- (id)init {
    self = [super init];
    if (self) {
        [self __setupModel];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _pushSetTableViewCell = nil;
    _helpTableViewCell = nil;
    _rateMeTableViewCell = nil;
    _feedbackTableViewCell = nil;
    _aboutTableViewCell = nil;
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

- (void)__setupNavigation {
    [super __setupNavigation];
    self.title = NSLocalizedString(@"Settings", nil);
}

- (NSArray *)__getList {
    
    SEL clickPushSetSelector = @selector(pushSetTableViewCellClick);
    NSValue *clickPushSetSelectorAsValue = [NSValue valueWithBytes:&clickPushSetSelector objCType:@encode(SEL)];
    NSDictionary *pushSetDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.pushSetTableViewCell, @"cell",
                                    @(k_RF_BaseTableViewCell_Height), @"height",
                                    clickPushSetSelectorAsValue, k_DidSelectRowAtIndexPath_selector_key, nil];
    
    SEL clickHelpSelector = @selector(helpTableViewCellClick);
    NSValue *clickHelpSelectorAsValue = [NSValue valueWithBytes:&clickHelpSelector objCType:@encode(SEL)];
    NSDictionary *helpDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.helpTableViewCell, @"cell",
                                @(k_RF_BaseTableViewCell_Height), @"height",
                                clickHelpSelectorAsValue, k_DidSelectRowAtIndexPath_selector_key, nil];
    
    SEL clickRateMeSelector = @selector(rateMeTableViewCellClick);
    NSValue *clickRateMeSelectorAsValue = [NSValue valueWithBytes:&clickRateMeSelector objCType:@encode(SEL)];
    NSDictionary *rateMeDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.rateMeTableViewCell, @"cell",
                                @(k_RF_BaseTableViewCell_Height), @"height",
                                clickRateMeSelectorAsValue, k_DidSelectRowAtIndexPath_selector_key, nil];
    
    SEL clickFeedbackSelector = @selector(feedbackTableViewCellClick);
    NSValue *clickFeedbackSelectorAsValue = [NSValue valueWithBytes:&clickFeedbackSelector objCType:@encode(SEL)];
    NSDictionary *feedbackDic = [NSDictionary dictionaryWithObjectsAndKeys:
                               self.feedbackTableViewCell, @"cell",
                               @(k_RF_BaseTableViewCell_Height), @"height",
                               clickFeedbackSelectorAsValue, k_DidSelectRowAtIndexPath_selector_key, nil];
    
    SEL clickAboutSelector = @selector(aboutTableViewCellClick);
    NSValue *clickAboutSelectorAsValue = [NSValue valueWithBytes:&clickAboutSelector objCType:@encode(SEL)];
    NSDictionary *aboutDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                  self.aboutTableViewCell, @"cell",
                                  @(k_RF_BaseTableViewCell_Height), @"height",
                                  clickAboutSelectorAsValue, k_DidSelectRowAtIndexPath_selector_key, nil];
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    
    NSArray *sectionArray1 = [NSArray arrayWithObjects:pushSetDic, nil];
    UIView *sectionView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    sectionView1.backgroundColor = [UIColor clearColor];
    NSDictionary *sectionDic1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 sectionArray1, @"array",
                                 sectionView1, @"header_view", nil];
    NSArray *sectionArray2 = [NSArray arrayWithObjects:helpDic, rateMeDic, feedbackDic, aboutDic, nil];
    UIView *sectionView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 15.0f)];
    sectionView2.backgroundColor = [UIColor clearColor];
    NSDictionary *sectionDic2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 sectionArray2, @"array",
                                 sectionView2, @"header_view", nil];
    
    NSArray *sections = [NSArray arrayWithObjects:sectionDic1, sectionDic2, nil];
    
    return sections;
}

- (void)__setupModel {
    self.model = [[RFBaseStaticTableViewModel alloc] init];
    RFBaseStaticTableViewModel *model = (RFBaseStaticTableViewModel *)self.model;
    model.sections = [self __getList];
}

#pragma mark - 控件定义

- (RFBaseStaticTableViewCell *)pushSetTableViewCell {
    if (!_pushSetTableViewCell) {
        _pushSetTableViewCell = [[RFBaseStaticTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                               reuseIdentifier:@"cell"];
        [_pushSetTableViewCell.textLabel setText:NSLocalizedString(@"PUSH_SET", nil)];
    }
    return _pushSetTableViewCell;
}


- (RFBaseStaticTableViewCell *)helpTableViewCell {
    if (!_helpTableViewCell) {
        _helpTableViewCell = [[RFBaseStaticTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:@"cell"];
        [_helpTableViewCell.textLabel setText:NSLocalizedString(@"HELP", nil)];
    }
    return _helpTableViewCell;
}

- (RFBaseStaticTableViewCell *)rateMeTableViewCell {
    if (!_rateMeTableViewCell) {
        _rateMeTableViewCell = [[RFBaseStaticTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                              reuseIdentifier:@"cell"];
        [_rateMeTableViewCell.textLabel setText:NSLocalizedString(@"RATE_ME", nil)];
    }
    return _rateMeTableViewCell;
}

- (RFBaseStaticTableViewCell *)feedbackTableViewCell {
    if (!_feedbackTableViewCell) {
        _feedbackTableViewCell = [[RFBaseStaticTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                              reuseIdentifier:@"cell"];
        [_feedbackTableViewCell.textLabel setText:NSLocalizedString(@"FEEDBACK", nil)];
    }
    return _feedbackTableViewCell;
}

- (RFBaseStaticTableViewCell *)aboutTableViewCell {
    if (!_aboutTableViewCell) {
        _aboutTableViewCell = [[RFBaseStaticTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                             reuseIdentifier:@"cell"];
        [_aboutTableViewCell.textLabel setText:NSLocalizedString(@"ABOUT", nil)];
    }
    return _aboutTableViewCell;
}

#pragma mark - didSelectRowAtIndexPath selector

- (void)pushSetTableViewCellClick {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    });
}

- (void)helpTableViewCellClick {
    NSString *title = NSLocalizedString(@"HELP", nil);
    RFBaseWebViewController *vc = [[RFBaseWebViewController alloc] initWithTitle:title webUrl:@"https://www.baidu.com"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rateMeTableViewCellClick {
    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%d", 1111111111];
    NSURL *url= [NSURL URLWithString: urlStr];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)feedbackTableViewCellClick {
    
}

- (void)aboutTableViewCellClick {

}

@end
