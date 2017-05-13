//
//  UIImage+Additions.h
//  CCTalk
//
//  Created by VincentX on 1/21/14.
//  Copyright (c) 2014 Hujiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

+ (UIImage*)imageWithColor: (UIColor*)color size: (CGSize)size;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

- (UIImage *)ct_drawImage:(UIImage *)anImage inRect:(CGRect)rect;
- (UIImage *)ct_drawImage:(UIImage *)anImage;

@end
