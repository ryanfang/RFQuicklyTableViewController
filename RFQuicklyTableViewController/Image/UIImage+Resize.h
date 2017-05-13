//
//  Resize.h
//  yuer
//
//  Created by HJ Mobile on 05/16/13.
//  Copyright (c) 2013 Shanghai Hujia Cultural Communications Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

- (UIImage *)resizeToSize:(CGSize)size withScale:(BOOL)scale inflate:(BOOL)inflate;
- (UIImage *)resizeWithRatio:(CGFloat)ratio;
- (UIImage *)resizeToWidth:(CGFloat)width;
- (UIImage *)resizeToHeight:(CGFloat)height;

@end
