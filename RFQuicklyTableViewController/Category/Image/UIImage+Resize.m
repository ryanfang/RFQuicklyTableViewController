//
//  Resize.m
//  RFQuicklyTableViewController
//
//  Created by RyanFang Mobile on 05/16/13.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage *)resizeToSize:(CGSize)size withScale:(BOOL)scale inflate:(BOOL)inflate {
    CGSize newSize = size;
    if (self.size.width < size.width && self.size.height < size.height) {
        if (!inflate) {
            newSize = self.size;
        }
    }
    CGFloat originX = 0.0f;
    CGFloat originY = 0.0f;

    if (scale) {
        CGFloat originalFactor = self.size.width / self.size.height;
        CGFloat destinationFactor = size.width / size.height;
        if (originalFactor > destinationFactor) {
            CGFloat scaledHeightFactor = newSize.height / self.size.height;
            CGFloat scaledWidth = self.size.width * scaledHeightFactor;
            originX = (scaledWidth - newSize.width) * 0.5;
        }
        else if (originalFactor < destinationFactor) {
            CGFloat scaledWidthFactor = newSize.width / self.size.width;
            CGFloat scaledHeight = self.size.height * scaledWidthFactor;
            originY = (scaledHeight - newSize.height) * 0.5;
        }
    }

    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    }
    else {
        UIGraphicsBeginImageContext(newSize);
    }
    [self drawInRect:CGRectMake(-originX, -originY, newSize.width + originX * 2.0, newSize.height + originY * 2.0)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

- (UIImage *)resizeWithRatio:(CGFloat)ratio {
    CGFloat newWidth = self.size.width * ratio;
    CGFloat newHeight = self.size.height * ratio;
    CGSize newSize = CGSizeMake(newWidth, newHeight);

    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    }
    else {
        UIGraphicsBeginImageContext(newSize);
    }
    [self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

- (UIImage *)resizeToWidth:(CGFloat)width {
    CGFloat ratio = width / self.size.width;
    return [self resizeWithRatio:ratio];
}

- (UIImage *)resizeToHeight:(CGFloat)height {
    CGFloat ratio = height / self.size.height;
    return [self resizeWithRatio:ratio];
}

@end
