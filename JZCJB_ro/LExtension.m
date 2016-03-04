//
//  LExtension.m
//  Test
//
//  Created by ryhx on 16/1/6.
//  Copyright © 2016年 ryhx. All rights reserved.
//

#import "LExtension.h"

@implementation LExtension

/**
 *  存入偏好设置
 */
+(void)saveObject:(NSObject *)object forKey:(NSString *)key{
    NSUserDefaults * userDf = [NSUserDefaults standardUserDefaults];
    [userDf setObject:object forKey:key];
    [userDf synchronize];
}
/**
 *  从偏好取数据
 */
+(id)objectForKey:(NSString *)key{
    NSUserDefaults * userDf = [NSUserDefaults standardUserDefaults];
    return [userDf objectForKey:key];
}
@end


@implementation UIView (convenience)


@dynamic borderColor;
@dynamic borderRadius;
@dynamic borderWidth;


- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.masksToBounds = YES;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderRadius:(CGFloat)borderRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = borderRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = borderWidth;
}

-(void)setSizeWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(void)setSizeHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(void)setOriginX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(void)setOriginY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)sizeWidth{
    return CGRectGetWidth(self.frame);
}
-(CGFloat)sizeHeight{
    return CGRectGetHeight(self.frame);
}
-(CGFloat)originX{
    return CGRectGetMinX(self.frame);
}
-(CGFloat)originY{
    return CGRectGetMinY(self.frame);
}


@end