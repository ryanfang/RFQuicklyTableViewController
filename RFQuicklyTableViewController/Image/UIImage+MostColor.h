//
//  UIImage+MostColor.h
//  DT
//
//  Created by Ryan Fang on 2017/1/30.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (MostColor)

/**
 *  获取图片主题色相适配的前景字符色
 */
- (UIColor *)foregroundColor;

/**
 *  获取图片的主题色
 */
- (UIColor *)mostColor;

@end
