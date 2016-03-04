//
//  LExtension.h
//  Test
//
//  Created by ryhx on 16/1/6.
//  Copyright © 2016年 ryhx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define R_G_B_16(value) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0x00FF00) >> 8))/255.0 blue:((float)(value & 0x0000FF))/255.0 alpha:1]
//主屏幕宽高
#define kMainScreenW [UIScreen mainScreen].bounds.size.width
#define kMainScreenH [UIScreen mainScreen].bounds.size.height

@interface LExtension : NSObject
/**
 *  存入偏好设置
 */
+(void)saveObject:(NSObject *)object forKey:(NSString *)key;
/**
 *  从偏好取数据
 */
+(id)objectForKey:(NSString *)key;
@end

IB_DESIGNABLE
@interface UIView (convenience)
@property (nonatomic,strong) IBInspectable UIColor * borderColor;
@property (nonatomic,assign) IBInspectable CGFloat borderRadius;
@property (nonatomic,assign) IBInspectable CGFloat borderWidth;

@property (nonatomic,assign) CGFloat sizeWidth;
@property (nonatomic,assign) CGFloat sizeHeight;
@property (nonatomic,assign) CGFloat originX;
@property (nonatomic,assign) CGFloat originY;
@end