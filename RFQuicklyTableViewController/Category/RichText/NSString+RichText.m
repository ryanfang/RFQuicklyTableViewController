//
//  NSString+RichText.m
//  RFQuicklyTableViewController
//
//  Created by Ryan Fang on 16/7/22.
//  Copyright © 2016年 RFQuicklyTableViewController. All rights reserved.
//

#import "NSString+RichText.h"

@implementation NSString (RichText)


/**
 *  计算字符串显示的Size
 *
 *  @param font 需要计算的字体
 *  @param maxSize 能显示的最大Size
 *
 */
- (CGSize)getSizeWithFont:(UIFont *)font
                    maxDispSize:(CGSize)maxDispSize  {
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSMutableAttributedString *attributedContent1Temp = [[NSMutableAttributedString alloc] initWithString:self];
    [attributedContent1Temp addAttribute:NSFontAttributeName
                                   value:font
                                   range:NSMakeRange(0, self.length)];
    CGRect rect = [attributedContent1Temp boundingRectWithSize:maxDispSize
                                                       options:options
                                                       context:nil];
    return rect.size;
}


/**
 *  生成包含图片的字符串
 *
 *  @param font 需要计算的字体
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
                                            maxDispSize:(CGSize)maxDispSize {
    
    NSString *content = [NSString stringWithString:self];
    
    /*********** 计算宽度并剪裁字符串长度 ************/
    CGFloat checkWidth = maxDispSize.width - imageDispSize.width;
    for (NSInteger i = self.length - 1; i > 0; i--) {
        CGSize size = [self getSizeWithFont:font maxDispSize:maxDispSize];
        if (checkWidth >= size.width) {
            break;
        }
        content = [NSString stringWithFormat:@"%@%@  ", [self substringToIndex:i], @"..."];
    }
    
    /************** 生成处理字符串 ***************/
    NSTextAttachment *attch = nil;
    // 添加表情
    attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = image;
    // 设置图片大小
    CGFloat imageY = (imageDispSize.height - font.lineHeight)/2.0f;
    attch.bounds = CGRectMake(0, imageY, imageDispSize.width, imageDispSize.height);
    
    /**************** 生成富文本字符串 ****************/
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    // 设置字体大小
    [attributedString addAttribute:NSFontAttributeName
                             value:font
                             range:NSMakeRange(0, content.length)];
    // 设置字体颜色
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:textColor
                             range:NSMakeRange(0, content.length)];
    // 插入图片
    if (attch) {
        if (attributedString.length < insertAtIndex) {
            insertAtIndex = attributedString.length;
        }
        [attributedString insertAttributedString:[NSAttributedString attributedStringWithAttachment:attch]
                                         atIndex:insertAtIndex];
    }
    
    return attributedString;
}

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
                                        maxDispSize:(CGSize)maxDispSize {
    
    NSString *string1 = [self substringToIndex:enterAtIndex];
    NSString *divString = [enterSpaceString copy]; // 用来控制行间距
    NSString *string2 = [self substringWithRange:NSMakeRange(enterAtIndex + divString.length , self.length - string1.length - divString.length)];
    
    NSDictionary *subStringDic1 = @{@"location": @(0),
                                    @"length": @(string1.length),
                                    @"color": textColor1,
                                    @"font": font1};
    NSDictionary *divStringgDic = @{@"location": @(string1.length),
                                    @"length": @(divString.length),
                                    @"color": [UIColor clearColor],
                                    @"font": [UIFont boldSystemFontOfSize:enterSpaceHeight]};
    NSDictionary *subStringDic2 = @{@"location": @(string1.length + divString.length),
                                    @"length": @(string2.length),
                                    @"color": textColor2,
                                    @"font": font2};
    NSArray *subStringArray = @[subStringDic1, divStringgDic, subStringDic2];
    
    NSAttributedString *attributedString = [self getAttributedStringWithStringArray:subStringArray];
    return attributedString;
}
    
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
- (NSAttributedString *)getAttributedStringWithStringArray:(NSArray *)stringArray {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    for (NSDictionary *stringInfo in stringArray) {
        NSInteger subLocation = [stringInfo[@"location"] integerValue];
        NSInteger subLength = [stringInfo[@"length"] integerValue];
        NSString *subString = [self substringWithRange:NSMakeRange(subLocation, subLength)];
        UIColor *subColor = stringInfo[@"color"];
        UIFont *subFont = stringInfo[@"font"];
        
        if (subString && subColor && subFont) {
            NSMutableAttributedString *subAttrString = [[NSMutableAttributedString alloc] initWithString:subString];
            // 设置字体大小
            [subAttrString addAttribute:NSFontAttributeName
                                     value:subFont
                                     range:NSMakeRange(0, subString.length)];
            // 设置字体颜色
            [subAttrString addAttribute:NSForegroundColorAttributeName
                                     value:subColor
                                     range:NSMakeRange(0, subString.length)];
            [attributedString appendAttributedString:subAttrString];
        }
    }
    
    return attributedString;
}

/**
 *  生成带下划线的字符串
 */
- (NSAttributedString *)getUnline {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self];
    NSRange contentRange = {0, [self length]};
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    
    return attributedString;
}

@end
