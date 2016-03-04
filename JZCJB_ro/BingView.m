//
//  BingView.m
//  JZCJB_ro
//
//  Created by ryhx on 16/3/4.
//  Copyright © 2016年 lay. All rights reserved.
//

#import "BingView.h"
#define PI 3.14159265358979323846
#define radius 100
#define R_G_B_16(value) [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0x00FF00) >> 8))/255.0 blue:((float)(value & 0x0000FF))/255.0 alpha:1]
@implementation BingView



static inline float radians(double degrees) {
    return degrees * PI / 180;
}

static inline void drawArc(CGContextRef ctx, CGPoint point, float angle_start, float angle_end, UIColor* color) {
    CGContextMoveToPoint(ctx, point.x, point.y);
    CGContextSetFillColor(ctx, CGColorGetComponents( [color CGColor]));
    CGContextAddArc(ctx, point.x, point.y, radius,  angle_start, angle_end, 0);
    //CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    
    float angle_start = radians(0.0);
    float angle_end = radians(self.bl*360);
    drawArc(ctx, CGPointMake(self.frame.size.width/2, self.frame.size.height/2), angle_start, angle_end, R_G_B_16(0x4CCCD0));
    
    
    angle_start = angle_end;
    angle_end = radians(360);
    drawArc(ctx,CGPointMake(self.frame.size.width/2, self.frame.size.height/2), angle_start, angle_end, R_G_B_16(0xFF6778));

}

@end
