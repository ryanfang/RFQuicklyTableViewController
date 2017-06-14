//
//  Resize.h
//  RFQuicklyTableViewController
//
//  Created by RyanFang Mobile on 05/16/13.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

- (UIImage *)resizeToSize:(CGSize)size withScale:(BOOL)scale inflate:(BOOL)inflate;
- (UIImage *)resizeWithRatio:(CGFloat)ratio;
- (UIImage *)resizeToWidth:(CGFloat)width;
- (UIImage *)resizeToHeight:(CGFloat)height;

@end
