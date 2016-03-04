//
//  BingView.h
//  JZCJB_ro
//
//  Created by ryhx on 16/3/4.
//  Copyright © 2016年 lay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BingView : UIView
@property (nonatomic,assign) CGFloat bl;
static inline void drawArc(CGContextRef ctx, CGPoint point, float angle_start, float angle_end, UIColor* color);
@end
