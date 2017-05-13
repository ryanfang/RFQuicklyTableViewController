//
//  NSString+RichText.h
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/7/22.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (RichText)

/**
 *  计算字符串显示的Size
 *
 *  @param font 需要计算的字体
 *  @param maxSize 能显示的最大Size
 *
 */
- (CGSize)getSizeWithFont:(UIFont *)font
          maxDispSize:(CGSize)maxDispSize;


/**
 *  生成包含图片的字符串
 *
 *  @param font 需要计算的字体
 *  @param textColor 文本显示颜色
 *  @param image 插入的图片
 *  @param imageDispSize 图片显示控件的大小
 *  @param insertAtIndex 图片在字符串中插入的位置
 *  @param maxDispSize 能显示的最大Size
 *
 */
- (NSAttributedString *)getAttributedStringWithFont:(UIFont *)font
                                          textColor:(UIColor *)textColor
                                              image:(UIImage *)image
                                      imageDispSize:(CGSize)imageDispSize
                                      insertAtIndex:(NSUInteger)insertAtIndex
                                        maxDispSize:(CGSize)maxDispSize;

/**
 *  两行显示不同风格的富文本
 *
 *  @param font1 第一行字符串字体
 *  @param textColor1 第一行字符串颜色
 *  @param enterAtIndex 字符串需要换行的位置
 *  @param enterSpaceHeight 行间距
 *  @param enterSpaceString 换行字符串
 *  @param font2 第二行字符串字体
 *  @param textColor2 第二行字符串颜色
 *  @param maxDispSize 能显示的最大Size
 *
 */
- (NSAttributedString *)getAttributedStringWithFont1:(UIFont *)font1
                                          textColor1:(UIColor *)textColor1
                                        enterAtIndex:(NSUInteger)enterAtIndex
                                    enterSpaceHeight:(CGFloat)enterSpaceHeight
                                    enterSpaceString:(NSString *)enterSpaceString
                                               font2:(UIFont *)font2
                                          textColor2:(UIColor *)textColor2
                                         maxDispSize:(CGSize)maxDispSize;

/**
 *  两行显示不同风格的富文本
 *
 *  @param stringArray 字符串显示信息的数组
 *                    [
 *                      {"string": 显示内容
 *                       "color" : 显示颜色
 *                       "font"  : 显示字体
 *                      },
 *                    ...
 *                    ]
 *
 *
*/
- (NSAttributedString *)getAttributedStringWithStringArray:(NSArray *)stringArray;
    
/**
 *  生成带下划线的字符串
 */
- (NSAttributedString *)getUnline;


@end
