//
//  ResultCell.m
//  JZCJB_ro
//
//  Created by ryhx on 16/3/7.
//  Copyright © 2016年 lay. All rights reserved.
//

#import "ResultCell.h"
#import "LExtension.h"
@implementation ResultCell

- (void)awakeFromNib {

}

-(void)menCounts:(NSArray *)men womenCounts:(NSArray*)women maxCount:(NSInteger)max{
    CGFloat width = kMainScreenW/max;
    UILabel * lb;
    for (NSInteger i=0;i<3;i++) {
        lb = ((UILabel *)self.menOptions[i]);
        lb.sizeWidth = width*[men[i] integerValue];
        CGFloat ox = lb.sizeWidth;
        lb.text = [men[i] stringValue];
        lb = ((UILabel *)self.womenOptions[i]);
        lb.sizeWidth = width*[women[i] integerValue];
        lb.originX = ox;
        lb.text = [women[i] stringValue];
    }
    [self layoutIfNeeded];
    
}

@end
